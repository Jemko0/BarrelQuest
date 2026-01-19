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
	GetOwningObject().runtimeData.SetValue("light_color", UBarrelUtilityFunctionLibrary::LinearColorToHexString(FLinearColor::MakeRandomColor()));
}