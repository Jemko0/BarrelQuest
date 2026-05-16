// 

#pragma once
#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "Components/BoxComponent.h"
#include "Interactable/InteractableInterface.h"
#include "Kismet/KismetStringLibrary.h"
#include "Tiles/RightClickInterface.h"
#include "Tiles/Features/TileFeatureLibrary.h"
#include "Tiles/Features/Interfaces/TileFeatureInterface.h"
#include "TileInteractionFeatureComponent.generated.h"


UCLASS(Blueprintable, ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UTileInteractionFeatureComponent : public USceneComponent, 
	public ITileFeatureInterface, public IRightClickInterface, public IInteractableInterface
{
	GENERATED_BODY()
	TF_GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UTileInteractionFeatureComponent();

protected:
	// Called when the game starts
	virtual void BeginPlay() override;
	virtual void OnComponentDestroyed(bool bDestroyingHierarchy) override;

public:
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;
	virtual TArray<FRCMOption> GetRCMOptions_Implementation(FVector ClickWorldPosition) override;
	void EnsureInteractionBoxComponent();
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UBoxComponent* InteractionBoxComponent = nullptr;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float InteractionRange = 200.0f;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	FVector BoxComponentBounds;
	
	virtual void Interact_Implementation(AActor* InteractionOwner) override;
	
	UFUNCTION(BlueprintImplementableEvent, BlueprintCallable)
	void OnInteract(AActor* Causer);
	
	virtual void BindRuntimeData(FTileRuntimeData& RuntimeData) override
	{
		EnsureInteractionBoxComponent();

		BindKey(RuntimeData, "interaction_range", [this](const FString& Value)
		{
			InteractionRange = FCString::Atof(*Value);
		});
		
		BindKey(RuntimeData, "box_bounds", [this](const FString& Value)
		{
			bool success = BoxComponentBounds.InitFromString(Value);
			if (!success)
			{
				UE_LOG(LogTemp, Warning, TEXT("Failed to convert string to FVector, str: %s"), *Value);
				return;
			}
			
			if (!InteractionBoxComponent)
			{
				UE_LOG(LogTemp, Warning, TEXT("box component is nullptr"));
				return;
			}
			
			InteractionBoxComponent->SetBoxExtent(BoxComponentBounds, true);
		});
	}
	
	virtual bool CanInteract_Implementation() override;
};
