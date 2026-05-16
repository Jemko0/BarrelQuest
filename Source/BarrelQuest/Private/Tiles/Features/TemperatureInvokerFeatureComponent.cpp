// 


#include "Tiles/Features/TemperatureInvokerFeatureComponent.h"

#include "Kismet/GameplayStatics.h"
#include "Temperature/TemperatureManager.h"


// Sets default values for this component's properties
UTemperatureInvokerFeatureComponent::UTemperatureInvokerFeatureComponent()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;

	// ...
}


// Called when the game starts
void UTemperatureInvokerFeatureComponent::BeginPlay()
{
	Super::BeginPlay();

	if (GetWorld()->GetNetMode() == NM_Client)
	{
		return;
	}

	TArray<AActor*> foundActors;
	UGameplayStatics::GetAllActorsOfClass(GetWorld(), ATemperatureManager::StaticClass(), foundActors);

	if (foundActors.Num() > 0)
	{
		ATemperatureManager* manager = Cast<ATemperatureManager>(foundActors[0]);
		if (manager)
		{
			manager->RegisterInvoker(this);
		}
	}
	
}

FVector UTemperatureInvokerFeatureComponent::GetOwnerLocation() const
{
	return UTileLibrary::TileToWorldPosition(OwningTileIndex);
}

// Called every frame
void UTemperatureInvokerFeatureComponent::TickComponent(float DeltaTime, ELevelTick TickType,
                                                        FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
}

void UTemperatureInvokerFeatureComponent::GetLifetimeReplicatedProps(
	TArray<class FLifetimeProperty>& OutLifetimeProps) const
{
	Super::GetLifetimeReplicatedProps(OutLifetimeProps);
	
	DOREPLIFETIME(UTemperatureInvokerFeatureComponent, targetTemperature);
	DOREPLIFETIME(UTemperatureInvokerFeatureComponent, emit);
}