// 


#include "Tiles/Features/TilePointLightFeatureComponent.h"

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
	if (!GetOwningObject()) return;
}

TArray<FRCMOption> UTilePointLightFeatureComponent::GetRCMOptions_Implementation(AActor* Actor, FVector Location)
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
