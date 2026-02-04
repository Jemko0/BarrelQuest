// 

#pragma once

#include "CoreMinimal.h"
#include "ElectricityInterface.h"
#include "Components/ActorComponent.h"
#include "ElectricityComponent.generated.h"


UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UElectricityComponent : public UActorComponent, public IElectricityInterface
{
	GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UElectricityComponent();

protected:
	// Called when the game starts
	virtual void BeginPlay() override;
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite)
	TArray<AActor*> BoundActors;
	
	virtual void ReceiveSignal_Implementation(float units) override;
	virtual void BindActor_Implementation(AActor* actor) override;
	
	UFUNCTION(Server)
	void ECBindActor(AActor* actor);
public:
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;
};
