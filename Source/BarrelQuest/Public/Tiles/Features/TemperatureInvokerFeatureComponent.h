// 

#pragma once

#include "CoreMinimal.h"
#include "Net/UnrealNetwork.h"
#include "TileFeatureLibrary.h"
#include "Components/SceneComponent.h"
#include "Interfaces/TileFeatureInterface.h"
#include "Temperature/TemperatureInterface.h"
#include "Tiles/RightClickInterface.h"
#include "TemperatureInvokerFeatureComponent.generated.h"


UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UTemperatureInvokerFeatureComponent : public USceneComponent, public ITileFeatureInterface, 
public IRightClickInterface, public ITemperatureInterface
{
	GENERATED_BODY()
	TF_GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UTemperatureInvokerFeatureComponent();
	
	UPROPERTY(Replicated, BlueprintReadWrite)
	float targetTemperature = 20.0f;
	
	UPROPERTY(Replicated, BlueprintReadWrite)
	bool emit = false;

protected:
	// Called when the game starts
	virtual void BeginPlay() override;
	
	virtual bool GetEmitState() const override
	{
		return emit;
	};
	
	virtual FVector GetOwnerLocation() const override;
	
	virtual float GetTargetTemperature() const override
	{
		return targetTemperature;
	};

public:
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType,
	                           FActorComponentTickFunction* ThisTickFunction) override;
	
	virtual void GetLifetimeReplicatedProps(TArray<class FLifetimeProperty>& OutLifetimeProps) const override;
	
	virtual void BindRuntimeData(FTileRuntimeData& RuntimeData) override
	{
		BindKey(RuntimeData, "target_temperature", [this](const FString& Value)
		{
			targetTemperature = FCString::Atof(*Value);
		});
		
		BindKey(RuntimeData, "emit", [this](const FString& Value)
		{
			emit = FCString::ToBool(*Value);
		});
	}
};
