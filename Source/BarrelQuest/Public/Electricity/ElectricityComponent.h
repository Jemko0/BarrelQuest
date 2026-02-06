// 

#pragma once

#include "CoreMinimal.h"
#include "ElectricityInterface.h"
#include "Net/UnrealNetwork.h"
#include "Components/ActorComponent.h"
#include "ElectricityComponent.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnElectricityReceived, float, units);
DECLARE_DYNAMIC_MULTICAST_DELEGATE(FOnElectricityExceeded);

USTRUCT(BlueprintType)
struct FElectricityConsumeResult
{
	GENERATED_BODY()
	
	FElectricityConsumeResult() = default;
	FElectricityConsumeResult(float newUsed, float newReq) : usedCapacity(newUsed), requiredConsumption(newReq) {};
	
public:
	float usedCapacity = 0.0f;
	float requiredConsumption = 0.0f;
};

UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UElectricityComponent : public UActorComponent, public IElectricityInterface
{
	GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UElectricityComponent();
	
	UFUNCTION(BlueprintCallable)
	float GetMinimumRequiredEnergy();
	
	UFUNCTION(BlueprintCallable)
	FElectricityConsumeResult ConsumeElectricity();

protected:
	// Called when the game starts
	virtual void BeginPlay() override;
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite)
	TArray<AActor*> BoundActors;
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite)
	float capacity = 0.f;
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite)
	float maxIntake = 240.f;
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite)
	float maxExport = 240.f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, BlueprintAssignable)
	FOnElectricityReceived OnElectricityReceived;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, BlueprintAssignable)
	FOnElectricityExceeded OnElectricityExceeded;
	
	virtual void ReceiveSignal_Implementation(float units) override;
	virtual void BindActor_Implementation(AActor* actor) override;
	
	virtual void ECTransmit();
	
	virtual void GetLifetimeReplicatedProps(TArray<class FLifetimeProperty>& OutLifetimeProps) const override;
	
	UFUNCTION(Server, Reliable)
	void ECBindActor(AActor* actor);
public:
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;
};
