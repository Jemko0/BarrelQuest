// 

#pragma once

#include "CoreMinimal.h"
#include "BarrelUtilityFunctionLibrary.h"
#include "TileFeatureLibrary.h"
#include "Components/PointLightComponent.h"
#include "Interfaces/TileFeatureInterface.h"
#include "Tiles/RightClickInterface.h"
#include "TilePointLightFeatureComponent.generated.h"

UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UTilePointLightFeatureComponent : public UPointLightComponent, public ITileFeatureInterface, public IRightClickInterface
{
	GENERATED_BODY()
	TF_GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UTilePointLightFeatureComponent();
	
	UPROPERTY(EditAnywhere, SaveGame)
	bool needsLightbulb = true;
	
	virtual void TickComponent(float DeltaTime, enum ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;
	
	virtual void BindRuntimeData(FTileRuntimeData& RuntimeData) override
	{
		BindKey(RuntimeData, "light_intensity", [this](const FString& Value)
		{
			SetIntensity(FCString::Atof(*Value));
		});
		
		BindKey(RuntimeData, "light_color", [this](const FString& Value)
		{
			SetLightColor(UBarrelUtilityFunctionLibrary::HexStringToLinearColor(Value));
		});
		
		BindKey(RuntimeData, "light_range", [this](const FString& Value)
		{
			SetAttenuationRadius(FCString::Atof(*Value));
		});
	}
	
	virtual TArray<FRCMOption> GetRCMOptions_Implementation(AActor* Actor, FVector Location) override;
};
