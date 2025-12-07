#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "BarrelUtilityLibrary.h"
#include "BodyTemperatureComponent.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnTemperatureChanged, float, NewTemperature);

UCLASS( ClassGroup=(Custom), meta=(BlueprintSpawnableComponent) )
class BARRELQUEST_API UBodyTemperatureComponent : public UActorComponent
{
	GENERATED_BODY()

public:	
	// Sets default values for this component's properties
	UBodyTemperatureComponent();
protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

	UFUNCTION(BlueprintCallable)
	void UpdateBodyTemperature(float delta);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	float GetHeatLossMultiplier(float insulation);

	UFUNCTION(BlueprintCallable)
	float UpdateClothingInsulation();
	
	UFUNCTION(BlueprintCallable)
	TArray<FWearingClothingData> GetClothingData();
	
	UFUNCTION(BlueprintCallable)
	void InitBodyTemperature();
	
	UFUNCTION(BlueprintCallable)
	void LogVars(float deltaTime);
	
	UFUNCTION(BlueprintCallable)
	void RaiseHeatProduction(float heatDelta);

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Body")
	float BodyTemp = 0.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Clothing")
	TMap<EClothingType, float> InsulationWeights = TMap<EClothingType, float>();
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Clothing")
	float ClothingInsulation = 0.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Body")
	float BaseHeatLossFactor = 8.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Body")
	float SafeBodyTempRange = 2.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Body")
	float BaseBodyTemp = 37.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Body")
    bool IsObject = false;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Outside Factors")
	float OutsideTemperature = 0.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Outside Factors")
	float OutsideInfluence = 0.002f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Clothing")
	float ClothingInsulationInfluence = 2.2f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Body")
	float InternalHeatProduction = 0.0f;
	
	UPROPERTY(BlueprintAssignable, Category = "Events")
	FOnTemperatureChanged OnTemperatureChanged;
};
