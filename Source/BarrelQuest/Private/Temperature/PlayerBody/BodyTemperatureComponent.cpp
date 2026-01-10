
#include "Temperature/PlayerBody/BodyTemperatureComponent.h"
#include "BarrelWornClothingInterface.h"
#include "BarrelUtilityLibrary.h"
#include "Kismet/GameplayStatics.h"
#include "Kismet/KismetMathLibrary.h"
#include "Temperature/TemperatureManager.h"

// Sets default values for this component's properties
UBodyTemperatureComponent::UBodyTemperatureComponent()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;
	
	//Default Weights
	InsulationWeights.Add(EClothingType::Hat, 0.05f);
	InsulationWeights.Add(EClothingType::Head, 0.15f);
	InsulationWeights.Add(EClothingType::Neck, 0.15f);
	InsulationWeights.Add(EClothingType::Torso, 0.35f);
	InsulationWeights.Add(EClothingType::Legs, 0.25f);
	InsulationWeights.Add(EClothingType::Feet, 0.05f);
}


// Called when the game starts
void UBodyTemperatureComponent::BeginPlay()
{
	Super::BeginPlay();
	InitBodyTemperature();
}

void UBodyTemperatureComponent::InitBodyTemperature()
{
	BodyTemp = BaseBodyTemp;	
}

void UBodyTemperatureComponent::LogVars(float deltaTime)
{
	UE_LOG(LogBarrelQuest, Log, TEXT("BodyTemp: %f"), BodyTemp);
	UE_LOG(LogBarrelQuest, Log, TEXT("OutsideTemp: %f"), OutsideTemperature);
	UE_LOG(LogBarrelQuest, Log, TEXT("InternalHeat: %f"), InternalHeatProduction * deltaTime);
	UE_LOG(LogBarrelQuest, Log, TEXT("ClothingInsul: %f"), ClothingInsulation);
	UE_LOG(LogBarrelQuest, Log, TEXT("HeatLossMultiplier: %f"), GetHeatLossMultiplier(ClothingInsulation));
}

void UBodyTemperatureComponent::RaiseHeatProduction(float heatDelta)
{
	InternalHeatProduction += heatDelta;
}

void UBodyTemperatureComponent::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
	UpdateBodyTemperature(DeltaTime);
}

void UBodyTemperatureComponent::UpdateBodyTemperature(float delta)
{
	const float insulation = IsObject? 0.0f : UpdateClothingInsulation();
	
	ATemperatureManager* mgr = Cast<ATemperatureManager>(UGameplayStatics::GetActorOfClass(GetWorld(), ATemperatureManager::StaticClass()));

	if(mgr)
	{
		OutsideTemperature = mgr->GetInterpTemperature(GetOwner()->GetActorLocation());
	}
	
	float driftRate = OutsideInfluence / (1.0f + insulation * ClothingInsulationInfluence);
	BodyTemp = UKismetMathLibrary::FInterpTo(BodyTemp, OutsideTemperature, delta, driftRate);
	
	float heatProduction = InternalHeatProduction * delta;
	
	BodyTemp += heatProduction;
	InternalHeatProduction -= heatProduction;
    
	//LogVars(delta);
}

float UBodyTemperatureComponent::GetHeatLossMultiplier(float insulation)
{
	return BaseHeatLossFactor / (1.0f + insulation * ClothingInsulationInfluence);
}

float UBodyTemperatureComponent::UpdateClothingInsulation()
{
	TArray<FWearingClothingData> clothingData = GetClothingData();

	if(clothingData.IsEmpty()) return 0.0f;
	
	float totalWeightedIns = 0.0f;

	for (const FWearingClothingData& clothing : clothingData)
	{
		const float* weightPtr = InsulationWeights.Find(clothing.clothingType);
		float Weight = weightPtr ? *weightPtr : 0.0f;
		
		totalWeightedIns += clothing.insulationLevel * Weight;
	}
	
	ClothingInsulation = FMath::Clamp(totalWeightedIns, 0.0f, 2.0f);

	return ClothingInsulation;
}

TArray<FWearingClothingData> UBodyTemperatureComponent::GetClothingData()
{
	TArray<FWearingClothingData> result;
	result = IBarrelWornClothingInterface::Execute_GetWornClothingData(GetOwner());
	return result;
}
