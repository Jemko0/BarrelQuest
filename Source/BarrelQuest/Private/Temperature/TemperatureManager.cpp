
#include "Temperature/TemperatureManager.h"
#include "Kismet/KismetSystemLibrary.h"

// Sets default values
ATemperatureManager::ATemperatureManager()
{
	PrimaryActorTick.bCanEverTick = true;
}

void ATemperatureManager::BeginPlay()
{
	Super::BeginPlay();
}

void ATemperatureManager::UpdateInvokers()
{
    TArray<UTemperatureInvoker*> out;
    registeredInvokers.GenerateKeyArray(out);

    for (const UTemperatureInvoker* const& invoker : out)
    {
        if (!invoker)
        {
            continue;
        }

        UpdateTemperatures(invoker->GetOwner()->GetActorLocation(), invoker->targetTemperature);
    }
}

// Called every frame
void ATemperatureManager::Tick(float DeltaTime)
{
    Super::Tick(DeltaTime);
    UpdateInvokers();
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
            FString tempText = FString::Printf(TEXT("%.1f°"), tileTemp);

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

void ATemperatureManager::FindNeighborsIterative(FVector startCenter, float invokerTemp)
{
    SnapVectorToGrid(startCenter, FVector(200, 200, 400));

    float heatTransferRate = globalHeatTransferRate;

    temperatureMap.FindOrAdd(startCenter) = invokerTemp;

    TArray<FVector> neighborOffsets =
    {
        FVector(200, 0, 0),
        FVector(-200, 0, 0),
        FVector(0, 200, 0),
        FVector(0, -200, 0)
    };

    TMap<FVector, float> temperatureChanges;

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
            if (FMath::Abs(tempDifference) > 0.1f)
            {
                FWallCheckResult wallResult = CheckForWall(currentTile, offset);

                float transferEfficiency = 1.0f;

                if (wallResult.hit)
                {
                    transferEfficiency = (1.0f - wallResult.insulation);

                    // Skip if fully insulated
                    if (wallResult.insulation >= 1.0f)
                    {
                        continue;
                    }
                }

                // Calculate heat transfer (positive means heat flows TO current tile)
                float heatTransfer = tempDifference * heatTransferRate * transferEfficiency;

                // Initialize temperature change tracking for both tiles
                if (!temperatureChanges.Contains(currentTile))
                {
                    temperatureChanges.Add(currentTile, 0.0f);
                }

                if (!temperatureChanges.Contains(neighborTile))
                {
                    temperatureChanges.Add(neighborTile, 0.0f);
                }

                // Apply heat transfer (energy conservation)
                temperatureChanges[currentTile] += heatTransfer;
                temperatureChanges[neighborTile] -= heatTransfer;
            }
        }
    }

    // Apply all temperature changes
    for (auto& change : temperatureChanges)
    {
        FVector tile = change.Key;
        float tempChange = change.Value;

        float currentTemp = temperatureMap.Contains(tile) ?
            temperatureMap[tile] : ambientTemperature;

        float newTemp = currentTemp + tempChange;

        // Only add to map if temperature is significantly different from ambient
        if (FMath::Abs(newTemp - ambientTemperature) > 0.05f)
        {
            temperatureMap.FindOrAdd(tile) = newTemp;
        }
        else
        {
            // Remove tiles that are essentially at ambient temperature
            temperatureMap.Remove(tile);
        }
    }

    // Clean up tiles that are very close to ambient temperature (except the start center)
    TArray<FVector> tilesToRemove;
    for (auto& tile : temperatureMap)
    {
        if (tile.Key != startCenter && FMath::Abs(tile.Value - ambientTemperature) < 0.5f)
        {
            tilesToRemove.Add(tile.Key);
        }
    }

    for (const FVector& tile : tilesToRemove)
    {
        temperatureMap.Remove(tile);
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
    
    // Debug drawing
    if (drawDebug && drawWallTraces)
    {
        FLinearColor traceColor;
        float traceDuration = 0.033f; // One frame
        
        if (bHit)
        {
            // Draw insulation text at hit point
            if (insulation > 0.0f)
            {
                FString insulationText = FString::Printf(TEXT("%.2f"), insulation);
                UKismetSystemLibrary::DrawDebugString(
                    GetWorld(),
                    hitResult.Location + FVector(0, 0, 20),
                    insulationText,
                    nullptr,
                    traceColor,
                    traceDuration
                );
            }
        }
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

void ATemperatureManager::RegisterInvoker(UTemperatureInvoker* invoker)
{
    registeredInvokers.Add(invoker);
}

void ATemperatureManager::UnregisterInvoker(UTemperatureInvoker* invoker)
{
    registeredInvokers.Remove(invoker);
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
    TArray<UTemperatureInvoker*> invokers;
    registeredInvokers.GenerateKeyArray(invokers);

    for (const UTemperatureInvoker* invoker : invokers)
    {
        if (!invoker) continue;

        FVector sourceLocation = invoker->GetOwner()->GetActorLocation();
        float sourceTemp = invoker->targetTemperature;

        // Draw a larger, pulsing indicator for heat sources
        float pulseScale = 1.0f + (0.05f * FMath::Sin(GetWorld()->GetTimeSeconds() * 3.0f));
        FLinearColor sourceColor = GetTemperatureColor(sourceTemp);
        sourceColor.A = 0.9f; // More opaque for sources

        UKismetSystemLibrary::DrawDebugBox(
            GetWorld(),
            sourceLocation,
            FVector(150, 150, 300) * pulseScale,
            sourceColor,
            FRotator(0),
            0.033f,
            3.0f // Thicker outline
        );

        // Draw source temperature text
        FString sourceText = FString::Printf(TEXT("SOURCE\n%.1f°"), sourceTemp);
        UKismetSystemLibrary::DrawDebugString(
            GetWorld(),
            sourceLocation + FVector(0, 0, 400),
            sourceText,
            nullptr,
            FLinearColor::White,
            0.033f
        );
    }
}