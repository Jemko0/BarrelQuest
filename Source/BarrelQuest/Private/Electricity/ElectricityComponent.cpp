// 


#include "Electricity/ElectricityComponent.h"


// Sets default values for this component's properties
UElectricityComponent::UElectricityComponent()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;
}

float UElectricityComponent::GetMinimumRequiredEnergy()
{
	float requiredEnergy = 0.0f;
	
	for (AActor* actor : BoundActors)
	{
		UElectricityComponent* elecComp = actor->GetComponentByClass<UElectricityComponent>();
		
		if (!elecComp) continue;
		
		requiredEnergy += elecComp->maxIntake;
	}
	
	return requiredEnergy;
}

FElectricityConsumeResult UElectricityComponent::ConsumeElectricity()
{
	FElectricityConsumeResult result = FElectricityConsumeResult();
	float usedCapacity = 0.0f;
	
	usedCapacity = FMath::Min(usedCapacity, maxIntake);
	
	float newCapacity = capacity - usedCapacity;
	capacity = newCapacity;
	
	result.usedCapacity = newCapacity;
	result.requiredConsumption = usedCapacity / maxIntake;
	
	return result;
}


// Called when the game starts
void UElectricityComponent::BeginPlay()
{
	Super::BeginPlay();
}

void UElectricityComponent::ReceiveSignal_Implementation(float units)
{
	IElectricityInterface::ReceiveSignal_Implementation(units);
	
	capacity += units;
	float requiredConsumption = capacity / maxIntake;
	OnElectricityReceived.Broadcast(units);
	ECTransmit();
	
	if (requiredConsumption - 1.0f > 0.0)
	{
		OnElectricityExceeded.Broadcast();
	}
}

void UElectricityComponent::BindActor_Implementation(AActor* actor)
{
	ECBindActor_Implementation(actor);
}

void UElectricityComponent::ECTransmit()
{
	for (AActor* actor : BoundActors)
	{
		float usedCapacity = 0.0f;
		
		UElectricityComponent* elecComp = actor->GetComponentByClass<UElectricityComponent>();
		if (!elecComp) continue;
		
		float exportUnits = FMath::Min(usedCapacity, maxExport);
		exportUnits /= (float)BoundActors.Num();
		
		elecComp->ReceiveSignal(exportUnits);
		
		capacity -= usedCapacity;
		if (capacity < 0) capacity = 0;
	}
}

void UElectricityComponent::GetLifetimeReplicatedProps(TArray<class FLifetimeProperty>& OutLifetimeProps) const
{
	Super::GetLifetimeReplicatedProps(OutLifetimeProps);
	
	DOREPLIFETIME(UElectricityComponent, BoundActors);
	DOREPLIFETIME(UElectricityComponent, maxIntake);
	DOREPLIFETIME(UElectricityComponent, maxExport);
	DOREPLIFETIME(UElectricityComponent, capacity);
}


void UElectricityComponent::ECBindActor_Implementation(AActor* actor)
{
	BoundActors.Add(actor);
}

void UElectricityComponent::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
}