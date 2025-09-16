#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "TemperatureInvoker.generated.h"


UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UTemperatureInvoker : public UActorComponent
{
	GENERATED_BODY()

public:	
	// Sets default values for this component's properties
	UTemperatureInvoker();

protected:
	// Called when the game starts
	virtual void BeginPlay() override;
	virtual void EndPlay(const EEndPlayReason::Type EndPlayReason) override;

public:	
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

	UFUNCTION(BlueprintCallable)
	void SetTargetTemperature(float temperature);

	UFUNCTION(BlueprintCallable)
	float GetTargetTemperature();

	UFUNCTION(BlueprintCallable)
	void SetEmitState(bool newState);

	UFUNCTION(BlueprintCallable, BlueprintPure)
	bool GetEmitState();

	UPROPERTY(EditAnywhere)
	float targetTemperature;

	UPROPERTY(EditAnywhere)
	bool emit = true;
};
