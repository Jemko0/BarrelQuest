// 


#include "Tiles/Features/Components/TilePointLightFeatureComponent.h"

#include "BarrelUtilityLibrary.h"


UTilePointLightFeatureComponent::UTilePointLightFeatureComponent()
{
	PrimaryComponentTick.bCanEverTick = true;
	PrimaryComponentTick.TickInterval = 1.0f / 10.0f;
	
	bAutoActivate = true;
	SetMobility(EComponentMobility::Movable);
}

void UTilePointLightFeatureComponent::TickComponent(float DeltaTime, enum ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
}

TArray<FRCMOption> UTilePointLightFeatureComponent::GetRCMOptions_Implementation(FVector Location)
{
	TArray<FRCMOption> rightClickOptions;
	if (needsLightbulb)
	{
		rightClickOptions = TArray<FRCMOption>{
			FRCMOption("Insert Light Bulb", "hi", "hi")
		};
	}
	
	return rightClickOptions;
}

void UTilePointLightFeatureComponent::SendRCMInvoke_Implementation(const FString& invokeID, TMap<FName, FRCMInvokeMessage>& payload)
{
	return;
}
