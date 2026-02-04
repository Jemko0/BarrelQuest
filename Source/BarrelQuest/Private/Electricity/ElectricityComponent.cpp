// 


#include "Electricity/ElectricityComponent.h"


// Sets default values for this component's properties
UElectricityComponent::UElectricityComponent()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;

	// ...
}


// Called when the game starts
void UElectricityComponent::BeginPlay()
{
	Super::BeginPlay();

	// ...
	
}

void UElectricityComponent::ReceiveSignal_Implementation(float units)
{
	IElectricityInterface::ReceiveSignal_Implementation(units);
	
	for (AActor* actor : BoundActors)
	{
		UElectricityComponent* elecComp = actor->GetComponentByClass<UElectricityComponent>();
		if (!elecComp) continue;
		
		elecComp->ReceiveSignal(units); //do some math lol
	}
}


void UElectricityComponent::ECBindActor_Implementation(AActor* actor)
{
	BoundActors.Add(actor);
}

// Called every frame
void UElectricityComponent::TickComponent(float DeltaTime, ELevelTick TickType,
                                          FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);

	// ...
}

