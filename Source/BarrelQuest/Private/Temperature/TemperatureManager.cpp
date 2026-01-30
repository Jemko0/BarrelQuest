
#include "Temperature/TemperatureManager.h"

#include <string>

#include "Kismet/KismetSystemLibrary.h"

// Sets default values
ATemperatureManager::ATemperatureManager()
{
	PrimaryActorTick.bCanEverTick = true;
}

void ATemperatureManager::BeginPlay()
{
	Super::BeginPlay();

    if (UseUpdateTimer)
    {
        GetWorld()->GetTimerManager().SetTimer(UpdateTimerHandle, this, &ATemperatureManager::UpdateInvokers, UpdateTimerInterval, true, 0.0f);
    }
}

void ATemperatureManager::UpdateInvokers()
{
    TArray<FName> out;
    registeredInvokers.GenerateKeyArray(out);

    for (FName& id : out)
    {
        TScriptInterface<ITemperatureInterface>& invoker = *registeredInvokers.Find(id);

        if (!invoker->GetEmitState())
        {
            UpdateTemperatures(invoker->GetOwnerLocation(), ambientTemperature);
            continue;
        }
        
        UpdateTemperatures(invoker->GetOwnerLocation(), invoker->GetTargetTemperature());
    }
}

// Called every frame
void ATemperatureManager::Tick(float DeltaTime)
{
    Super::Tick(DeltaTime);

    if (!UseUpdateTimer)
    {
        UpdateInvokers();
    }
}

void ATemperatureManager::UpdateTemperatures(FVector ucenter, float temp)
{
    visitedTiles.Empty();
    tilesToProcess.Empty();
    FindNeighborsIterative(ucenter, temp);

    if (drawDebug)
    {
        TArray<FVector> keys;
        temperatureMap.GenerateKeyArray(keys);

        for (int i = 0; i < keys.Num(); i++)
        {
            FVector tileCenter = keys[i];
            float tileTemp = temperatureMap[tileCenter];

            FLinearColor debugColor = GetTemperatureColor(tileTemp);

            UKismetSystemLibrary::DrawDebugBox(
                GetWorld(),
                tileCenter,
                FVector(100, 100, 200),
                debugColor,
                FRotator(0),
                0.033f,
                2.0f
            );

            FVector textLocation = tileCenter + FVector(0, 0, 250);
            FString tempText = FString::Printf(TEXT("%.1f�"), tileTemp);

            UKismetSystemLibrary::DrawDebugString(
                GetWorld(),
                textLocation,
                tempText,
                nullptr,
                debugColor,
                0.3f
            );

            if (drawHeatFlow)
            {
                DrawHeatFlowArrows(tileCenter, tileTemp);
            }
        }

        DrawHeatSources();
    }
}

FName ATemperatureManager::GenerateIDForInvoker(USceneComponent* refInvoker)
{
    static int32 count = 0;
    count++;
    return FName(FString::Printf(TEXT("%s_%d"), *refInvoker->GetName(), count));
}

void ATemperatureManager::FindNeighborsIterative(FVector startCenter, float invokerTemp)
{
    SnapVectorToGrid(startCenter, FVector(200, 200, 400));

    float heatTransferRate = globalHeatTransferRate;

    // Set the heat source temperature
    temperatureMap.FindOrAdd(startCenter) = invokerTemp;

    TArray<FVector> neighborOffsets =
    {
        FVector(200, 0, 0),
        FVector(-200, 0, 0),
        FVector(0, 200, 0),
        FVector(0, -200, 0)
    };

    TMap<FVector, float> temperatureChanges;

    // Get current heated tiles
    TArray<FVector> heatedTiles;
    temperatureMap.GenerateKeyArray(heatedTiles);

    // Process each heated tile and its neighbors
    for (const FVector& currentTile : heatedTiles)
    {
        float currentTemp = temperatureMap[currentTile];

        for (const FVector& offset : neighborOffsets)
        {
            FVector neighborTile = currentTile + offset;

            float neighborTemp = temperatureMap.Contains(neighborTile) ?
                temperatureMap[neighborTile] : ambientTemperature;

            float tempDifference = neighborTemp - currentTemp;

            // Only transfer heat if there's a meaningful temperature difference
            if (FMath::Abs(tempDifference) < 0.1f)
            {
                continue;
            }

            FWallCheckResult wallResult = CheckForWall(currentTile, offset);

            float transferEfficiency = 1.0f;
            if (wallResult.hit)
            {
                transferEfficiency = (1.0f - wallResult.insulation);
                if (wallResult.insulation >= 1.0f)
                {
                    continue;
                }
            }

            float heatTransfer = tempDifference * heatTransferRate * transferEfficiency;

            if (!temperatureChanges.Contains(currentTile))
            {
                temperatureChanges.Add(currentTile, 0.0f);
            }

            if (!temperatureChanges.Contains(neighborTile))
            {
                temperatureChanges.Add(neighborTile, 0.0f);
            }

            temperatureChanges[currentTile] += heatTransfer;
            temperatureChanges[neighborTile] -= heatTransfer;
        }
    }

    // Apply temperature changes
    for (auto& change : temperatureChanges)
    {
        FVector tile = change.Key;
        float tempChange = change.Value;

        float currentTemp = temperatureMap.Contains(tile) ?
            temperatureMap[tile] : ambientTemperature;

        float newTemp = currentTemp + tempChange;

        // Only add to map if temperature is significantly different from ambient
        if (FMath::Abs(newTemp - ambientTemperature) > 0.1f)
        {
            temperatureMap.FindOrAdd(tile) = newTemp;
        }
        else
        {
            // Remove tiles that are essentially at ambient temperature
            temperatureMap.Remove(tile);
        }
    }

    // Get all active invoker positions for source tile protection
    TArray<FVector> invokerPositions;
    TArray<FName> activeInvokers;
    registeredInvokers.GenerateKeyArray(activeInvokers);

    for (const FName id : activeInvokers)
    {
        TScriptInterface<ITemperatureInterface>& invoker = *registeredInvokers.Find(id);
        if (invoker && invoker->GetEmitState())
        {
            FVector invokerPos = invoker->GetOwnerLocation();
            SnapVectorToGrid(invokerPos, FVector(200, 200, 400));
            invokerPositions.Add(invokerPos);
        }
    }

    // IMPROVED CLEANUP: More aggressive removal of tiles close to ambient
    TArray<FVector> tilesToRemove;
    temperatureMap.GenerateKeyArray(heatedTiles); // Refresh the list after changes

    for (const FVector& tile : heatedTiles)
    {
        float tileTemp = temperatureMap[tile];

        // Never remove active heat source tiles
        bool isSourceTile = false;
        for (const FVector& invokerPos : invokerPositions)
        {
            if (tile == invokerPos)
            {
                isSourceTile = true;
                break;
            }
        }

        if (isSourceTile)
        {
            continue;
        }

        // Remove tiles that are very close to ambient temperature
        // Use a more aggressive threshold than the original 0.5f
        if (FMath::Abs(tileTemp - ambientTemperature) < 1.0f)
        {
            tilesToRemove.Add(tile);
        }
    }

    // Remove tiles marked for removal
    for (const FVector& tile : tilesToRemove)
    {
        temperatureMap.Remove(tile);
    }

    // PERIODIC AGGRESSIVE CLEANUP to prevent gradual accumulation
    static float lastAggressiveCleanup = 0.0f;
    float currentTime = GetWorld()->GetTimeSeconds();

    if (currentTime - lastAggressiveCleanup > 2.0f) // Every 2 seconds
    {
        lastAggressiveCleanup = currentTime;

        TArray<FVector> allTiles;
        temperatureMap.GenerateKeyArray(allTiles);

        int32 removedCount = 0;

        for (const FVector& tile : allTiles)
        {
            float tileTemp = temperatureMap[tile];

            // Never remove active heat source tiles
            bool isSourceTile = false;
            for (const FVector& invokerPos : invokerPositions)
            {
                if (tile == invokerPos)
                {
                    isSourceTile = true;
                    break;
                }
            }

            if (!isSourceTile)
            {
                // More aggressive cleanup - remove tiles closer to ambient
                if (FMath::Abs(tileTemp - ambientTemperature) < 2.0f)
                {
                    temperatureMap.Remove(tile);
                    removedCount++;
                }
            }
        }

        // Log performance info if we're removing a lot of tiles
        if (removedCount > 0)
        {
            UE_LOG(LogTemp, Warning, TEXT("Aggressive cleanup: removed %d tiles. Total tiles: %d"),
                removedCount, temperatureMap.Num());
        }

        // EMERGENCY CLEANUP: If we still have too many tiles, remove more aggressively
        if (temperatureMap.Num() > (2 << 15)) // Adjust this threshold as needed
        {
            UE_LOG(LogTemp, Error, TEXT("Emergency cleanup triggered! Tile count: %d"), temperatureMap.Num());

            temperatureMap.GenerateKeyArray(allTiles);
            int32 emergencyRemovedCount = 0;

            for (const FVector& tile : allTiles)
            {
                float tileTemp = temperatureMap[tile];

                // Never remove active heat source tiles
                bool isSourceTile = false;
                for (const FVector& invokerPos : invokerPositions)
                {
                    if (tile == invokerPos)
                    {
                        isSourceTile = true;
                        break;
                    }
                }

                if (!isSourceTile)
                {
                    // Very aggressive emergency cleanup
                    if (FMath::Abs(tileTemp - ambientTemperature) < 5.0f)
                    {
                        temperatureMap.Remove(tile);
                        emergencyRemovedCount++;
                    }
                }
            }

            UE_LOG(LogTemp, Error, TEXT("Emergency cleanup removed %d tiles. New total: %d"),
                emergencyRemovedCount, temperatureMap.Num());
        }
    }
}

FWallCheckResult ATemperatureManager::CheckForWall(FVector center, FVector direction)
{
    SnapVectorToGrid(center, FVector(200, 200, 400));

    FVector traceStart = FVector(center.X, center.Y, center.Z + 200);
    FCollisionQueryParams TraceParams;
    TraceParams.bTraceComplex = true;
    TraceParams.bReturnPhysicalMaterial = false;
    TraceParams.AddIgnoredActor(this);

    FVector traceEnd = traceStart + direction;
    FHitResult hitResult;
    bool bHit = GetWorld()->LineTraceSingleByChannel(
        hitResult,
        traceStart,
        traceEnd,
        wallTraceChannel,
        TraceParams
    );

    AActor* hitActor = hitResult.GetActor();
    float insulation = 0.0f;

    if (hitActor && hitActor->Implements<UTemperatureInterface>())
    {
        insulation = ITemperatureInterface::Execute_GetInsulationLevel(hitActor);
    }
    
    return FWallCheckResult(bHit, insulation);
}

void ATemperatureManager::SnapVectorToGrid(FVector& v, FVector grid)
{
    if (grid.X != 0.0f)
        v.X = FMath::RoundToFloat(v.X / grid.X) * grid.X;

    if (grid.Y != 0.0f)
        v.Y = FMath::RoundToFloat(v.Y / grid.Y) * grid.Y;

    if (grid.Z != 0.0f)
        v.Z = FMath::RoundToFloat(v.Z / grid.Z) * grid.Z;
}

void ATemperatureManager::RegisterInvoker(USceneComponent* invoker)
{
    FName newID = GenerateIDForInvoker(invoker);
    registeredInvokers.Add(newID, invoker);
}

void ATemperatureManager::UnregisterInvoker(FName key)
{
    registeredInvokers.Remove(key);
}

void ATemperatureManager::SetOutsideTemperature(float outsideTemperature)
{
    ambientTemperature = outsideTemperature;
}

float ATemperatureManager::GetInterpTemperature(FVector position)
{
    // Grid size based on your system (200x200 horizontal, 400 vertical)
    FVector gridSize(200, 200, 400);

    // Find the closest grid position (snapped position)
    FVector snappedPos = position;
    SnapVectorToGrid(snappedPos, gridSize);

    // If we have an exact match, return that temperature
    if (temperatureMap.Contains(snappedPos))
    {
        return temperatureMap[snappedPos];
    }

    // Calculate the offset from the snapped position
    FVector offset = position - snappedPos;

    // If the offset is very small, we're essentially on a grid node
    if (offset.Size() < 1.0f)
    {
        return ambientTemperature;
    }

    // Find the 4 surrounding horizontal grid points for bilinear interpolation
    // We'll interpolate on the XY plane at the snapped Z level
    FVector corners[4];
    corners[0] = snappedPos; // Base corner

    // Determine which direction we're offset in
    float xSign = FMath::Sign(offset.X);
    float ySign = FMath::Sign(offset.Y);

    corners[1] = snappedPos + FVector(xSign * gridSize.X, 0, 0);
    corners[2] = snappedPos + FVector(0, ySign * gridSize.Y, 0); 
    corners[3] = snappedPos + FVector(xSign * gridSize.X, ySign * gridSize.Y, 0);

    // Get temperatures at each corner (use ambient if not found)
    float temps[4];
    for (int32 i = 0; i < 4; i++)
    {
        temps[i] = temperatureMap.Contains(corners[i]) ?
            temperatureMap[corners[i]] : ambientTemperature;
    }

    // Calculate interpolation weights (0.0 to 1.0)
    float xWeight = FMath::Abs(offset.X) / gridSize.X;
    float yWeight = FMath::Abs(offset.Y) / gridSize.Y;

    // Clamp weights to [0,1] range
    xWeight = FMath::Clamp(xWeight, 0.0f, 1.0f);
    yWeight = FMath::Clamp(yWeight, 0.0f, 1.0f);

    // Bilinear interpolation
    // First interpolate along X axis
    float temp1 = FMath::Lerp(temps[0], temps[1], xWeight); // Bottom edge
    float temp2 = FMath::Lerp(temps[2], temps[3], xWeight); // Top edge

    float finalTemp = FMath::Lerp(temp1, temp2, yWeight);

    if (FMath::Abs(finalTemp - ambientTemperature) < 0.01f)
    {
        return ambientTemperature;
    }

    return finalTemp;
}

FLinearColor ATemperatureManager::GetTemperatureColor(float temperature)
{
    float coldTemp = -20.0f;
    float coolTemp = 32.0f;
    float neutralTemp = 70.0f;
    float warmTemp = 100.0f;
    float hotTemp = 200.0f;

    FLinearColor color;

    if (temperature <= coldTemp)
    {
        color = FLinearColor(0.0f, 0.2f, 1.0f, 0.7f);
    }
    else if (temperature <= coolTemp)
    {
        float alpha = (temperature - coldTemp) / (coolTemp - coldTemp);
        color = FLinearColor::LerpUsingHSV(
            FLinearColor(0.0f, 0.2f, 1.0f, 0.7f),
            FLinearColor(0.0f, 1.0f, 1.0f, 0.7f),
            alpha
        );
    }
    else if (temperature <= neutralTemp)
    {
        float alpha = (temperature - coolTemp) / (neutralTemp - coolTemp);
        color = FLinearColor::LerpUsingHSV(
            FLinearColor(0.0f, 1.0f, 1.0f, 0.7f),
            FLinearColor(0.8f, 0.8f, 0.8f, 0.7f),
            alpha
        );
    }
    else if (temperature <= warmTemp)
    {
        float alpha = (temperature - neutralTemp) / (warmTemp - neutralTemp);
        color = FLinearColor::LerpUsingHSV(
            FLinearColor(0.8f, 0.8f, 0.8f, 0.7f),
            FLinearColor(1.0f, 1.0f, 0.0f, 0.7f),
            alpha
        );
    }
    else if (temperature <= hotTemp)
    {
        float alpha = (temperature - warmTemp) / (hotTemp - warmTemp);
        color = FLinearColor::LerpUsingHSV(
            FLinearColor(1.0f, 1.0f, 0.0f, 0.7f),
            FLinearColor(1.0f, 0.0f, 0.0f, 0.7f), 
            alpha
        );
    }
    else
    {
        color = FLinearColor(1.0f, 0.2f, 0.0f, 0.8f);
    }

    color.A = 1.0f;
    return color;
}

void ATemperatureManager::DrawHeatFlowArrows(FVector tileCenter, float tileTemp)
{
    TArray<FVector> neighborOffsets =
    {
        FVector(200, 0, 0),
        FVector(-200, 0, 0),
        FVector(0, 200, 0),
        FVector(0, -200, 0)
    };

    for (const FVector& offset : neighborOffsets)
    {
        FVector neighborPos = tileCenter + offset;

        if (temperatureMap.Contains(neighborPos))
        {
            float neighborTemp = temperatureMap[neighborPos];
            float tempDiff = tileTemp - neighborTemp;


            // Only draw arrow if there's significant temperature difference
            if (FMath::Abs(tempDiff) > 1.0f)
            {
                FVector arrowStart = tileCenter + (offset * 0.3f); // Start 30% toward neighbor
                FVector arrowEnd = tileCenter + (offset * 0.7f);   // End 70% toward neighbor

                // Arrow color intensity based on temperature difference
                float intensity = FMath::Clamp(FMath::Abs(tempDiff) / 20.0f, 0.2f, 1.0f);
                FLinearColor arrowColor = tempDiff > 0 ?
                    FLinearColor(1.0f, 0.5f, 0.0f, intensity) : // Orange for heat flow
                    FLinearColor(0.0f, 0.5f, 1.0f, intensity);  // Blue for cold flow

                UKismetSystemLibrary::DrawDebugArrow(
                    GetWorld(),
                    arrowStart,
                    arrowEnd,
                    10.0f, // Arrow head size
                    arrowColor,
                    0.033f,
                    1.0f
                );
            }
        }
    }
}

void ATemperatureManager::DrawHeatSources()
{
}