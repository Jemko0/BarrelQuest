


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

	UFUNCTION(BlueprintCallable)
	void UpdateInvokers();

	UFUNCTION(BlueprintCallable)
	void UpdateTemperatures(FVector ucenter, float temp);

	UFUNCTION(BlueprintCallable)
	void FindNeighborsIterative(FVector startCenter, float invokerTemp);

	UFUNCTION(BlueprintCallable)
	FWallCheckResult CheckForWall(FVector center, FVector direction);

	void SnapVectorToGrid(FVector &v, FVector grid);

	UFUNCTION(BlueprintCallable)
	void RegisterInvoker(UTemperatureInvoker* invoker);

	UFUNCTION(BlueprintCallable)
	void UnregisterInvoker(UTemperatureInvoker* invoker);

	UFUNCTION(BlueprintCallable)
	void SetOutsideTemperature(float outsideTemperature);

	UFUNCTION(BlueprintCallable)
	float GetInterpTemperature(FVector position);

	UFUNCTION(BlueprintCallable, meta = (Category = "Debug"))
	void DrawHeatFlowArrows(FVector tileCenter, float tileTemp);


	UFUNCTION(BlueprintCallable, meta = (Category = "Debug"))
	void DrawHeatSources();

	UFUNCTION(BlueprintCallable, meta = (Category = "Debug"))
	FLinearColor GetTemperatureColor(float temperature);

	UPROPERTY(BlueprintReadOnly)
	float ambientTemperature = 20.0f;


	UPROPERTY(EditAnywhere, Category = "Temp")
	TMap<FVector, float> temperatureMap;

	UPROPERTY(EditAnywhere, Category = "Invokers")
	TMap<UTemperatureInvoker*, bool> registeredInvokers;

	UPROPERTY(EditAnywhere, Category = "Debug")
	bool drawDebug = true;

	UPROPERTY(EditAnywhere)
	float globalHeatTransferRate = 0.01f;

	UPROPERTY(EditAnywhere, Category = "Debug")
	bool drawHeatFlow = false;

	UPROPERTY(EditAnywhere, Category = "Debug")
	bool drawWallTraces = false;

	UPROPERTY(EditAnywhere, Category = "Properties")
	TEnumAsByte<ECollisionChannel> wallTraceChannel = ECC_GameTraceChannel13;

	UPROPERTY(EditAnywhere, Category = "Properties")
	int MAX_NEIGHBOR_ITERATIONS = 64;

	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	bool UseUpdateTimer = false;

	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float UpdateTimerInterval = 1.0f / 20.0f;

private:

	TArray<FVector> tilesToProcess;
	TSet<FVector> visitedTiles;
	FTimerHandle UpdateTimerHandle;
	int ITERATIONS = 0;
};
