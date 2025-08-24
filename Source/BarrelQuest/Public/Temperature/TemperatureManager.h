


#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "TemperatureInvoker.h"
#include "TemperatureInterface.h"
#include "TemperatureManager.generated.h"

USTRUCT(BlueprintType)
struct FWallCheckResult
{
	GENERATED_BODY()

	FWallCheckResult()
	{
	}

	FWallCheckResult(bool h, float i)
	{
		hit = h;
		insulation = i;
	}

	bool hit;
	float insulation;
};


UCLASS()
class BARRELQUEST_API ATemperatureManager : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	ATemperatureManager();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

	void UpdateTemperatures(FVector ucenter, float temp);
	void FindNeighborsIterative(FVector startCenter, float invokerTemp);
	FWallCheckResult CheckForWall(FVector center, FVector direction);

	void SnapVectorToGrid(FVector &v, FVector grid);

	void RegisterInvoker(UTemperatureInvoker* invoker);
	void UnregisterInvoker(UTemperatureInvoker* invoker);

	void SetOutsideTemperature(float outsideTemperature);

	float ambientTemperature = 20.0f;

	UPROPERTY(EditAnywhere)
	TMap<FVector, float> temperatureMap;

	UPROPERTY(EditAnywhere)
	TArray<FVector> tilesToProcess;

	TSet<FVector> visitedTiles;

	UPROPERTY(EditAnywhere)
	TMap<UTemperatureInvoker*, bool> registeredInvokers;

	UPROPERTY(EditAnywhere)
	bool drawDebug = true;

	UPROPERTY(EditAnywhere)
	int MAX_NEIGHBOR_ITERATIONS = 32;

	int ITERATIONS = 0;
};
