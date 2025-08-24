
#include "Kismet/KismetSystemLibrary.h"
#include "Temperature/TemperatureManager.h"

// Sets default values
ATemperatureManager::ATemperatureManager()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

}

// Called when the game starts or when spawned
void ATemperatureManager::BeginPlay()
{
	Super::BeginPlay();
}

// Called every frame
void ATemperatureManager::Tick(float DeltaTime)
{
    Super::Tick(DeltaTime);

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

void ATemperatureManager::UpdateTemperatures(FVector ucenter, float temp)
{
    visitedTiles.Empty();
    tilesToProcess.Empty();
    FindNeighborsIterative(ucenter, temp);

    //debug shti
    if (drawDebug)
    {
        TArray<FVector> keys;
        temperatureMap.GenerateKeyArray(keys);

        for (int i = 0; i < keys.Num(); i++)
        {
            UKismetSystemLibrary::DrawDebugBox(GetWorld(), keys[i], FVector(100, 100, 400), FLinearColor::Blue, FRotator(0), 0.033f, 1.0f);
        }
    }
}

void ATemperatureManager::FindNeighborsIterative(FVector startCenter, float invokerTemp)
{
    SnapVectorToGrid(startCenter, FVector(200, 200, 400));

    TMap<FVector, float> tileTemperatures;
    tileTemperatures.Add(startCenter, invokerTemp);
    tilesToProcess.Add(startCenter);

    FVector initialCenter = startCenter;
    TArray<FVector> neighborOffsets =
    {
        FVector(200, 0, 0),
        FVector(-200, 0, 0),
        FVector(0, 200, 0),
        FVector(0, -200, 0)
    };

    int iterations = 0;
    while (tilesToProcess.Num() > 0 && iterations < MAX_NEIGHBOR_ITERATIONS)
    {
        FVector currentTile = tilesToProcess[0];
        tilesToProcess.RemoveAt(0);

        if (visitedTiles.Contains(currentTile))
        {
            continue;
        }

        visitedTiles.Add(currentTile);

        float currentTemp = tileTemperatures[currentTile];
        temperatureMap.Add(currentTile, currentTemp);

        for (const FVector& offset : neighborOffsets)
        {
            FVector neighborTile = currentTile + offset;

            if (!visitedTiles.Contains(neighborTile))
            {
                FWallCheckResult wallResult = CheckForWall(currentTile, offset);

                float transferredTemp = currentTemp;

                if (wallResult.hit)
                {

                    transferredTemp = currentTemp * (1.0f - wallResult.insulation);

                    // If insulation is too high (e.g., >= 1.0), don't transfer at all
                    if (wallResult.insulation >= 1.0f)
                    {
                        continue;
                    }
                }

                tileTemperatures.Add(neighborTile, transferredTemp);
                tilesToProcess.Add(neighborTile);
            }
        }

        iterations++;
    }
}

FWallCheckResult ATemperatureManager::CheckForWall(FVector center, FVector direction)
{
    SnapVectorToGrid(center, FVector(200, 200, 400));

    // Set trace height to middle of voxel (Z = 200 for 400 height voxel)
    FVector traceStart = FVector(center.X, center.Y, 200.0f);

    FCollisionQueryParams TraceParams;
    TraceParams.bTraceComplex = true;
    TraceParams.bReturnPhysicalMaterial = false;
    TraceParams.AddIgnoredActor(this);

    // Trace just one unit (201 units) into the specified direction
    FVector traceEnd = traceStart + direction.GetSafeNormal() * 201.0f;

    FHitResult hitResult;
    bool bHit = GetWorld()->LineTraceSingleByChannel(
        hitResult,
        traceStart,
        traceEnd,
        ECollisionChannel::ECC_GameTraceChannel8,
        TraceParams
    );

    AActor* hitActor = hitResult.GetActor();
    float insulation = 0.0f;

    if (hitActor)
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
