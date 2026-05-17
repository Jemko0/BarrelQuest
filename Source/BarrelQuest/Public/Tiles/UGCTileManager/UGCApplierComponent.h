// 

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "Tiles/TileSaveLoadLibrary.h"
#include "UGCApplierComponent.generated.h"


UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent), Blueprintable)
class BARRELQUEST_API UUGCApplierComponent : public UActorComponent
{
	GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UUGCApplierComponent();

protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType,
	                           FActorComponentTickFunction* ThisTickFunction) override;
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	void ApplyEnvironmentSettings(const FWorldEnvironmentData& EnvironmentData);
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	void ApplyBGM(const FWorldBGMData& BGMData);
};
