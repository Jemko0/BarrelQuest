
#include "Temperature/TemperatureInvoker.h"
#include "Kismet/GameplayStatics.h"
#include "Temperature/TemperatureManager.h"

// Sets default values for this component's properties
UTemperatureInvoker::UTemperatureInvoker()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;

	// ...
}


void UTemperatureInvoker::BeginPlay()
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


// Called every frame
void UTemperatureInvoker::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
}

void UTemperatureInvoker::SetTargetTemperature(float temperature)
{
    targetTemperature = temperature;
}

float UTemperatureInvoker::GetTargetTemperature()
{
    return targetTemperature;
}

void UTemperatureInvoker::SetEmitState(bool newState)
{
    emit = newState;
}

bool UTemperatureInvoker::GetEmitState()
{
    return emit;
}
