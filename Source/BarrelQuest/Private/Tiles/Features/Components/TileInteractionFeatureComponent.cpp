// 


#include "Tiles/Features/Components/TileInteractionFeatureComponent.h"

#include "Components/BoxComponent.h"
#include "Tiles/TileChunk.h"


// Sets default values for this component's properties
UTileInteractionFeatureComponent::UTileInteractionFeatureComponent()
{
	PrimaryComponentTick.bCanEverTick = true;
	ComponentTags.Add(FName("interactable"));
}


// Called when the game starts
void UTileInteractionFeatureComponent::BeginPlay()
{
	Super::BeginPlay();
	EnsureInteractionBoxComponent();
}

void UTileInteractionFeatureComponent::OnComponentDestroyed(bool bDestroyingHierarchy)
{
	if (InteractionBoxComponent)
	{
		InteractionBoxComponent->DestroyComponent();
		InteractionBoxComponent = nullptr;
	}

	Super::OnComponentDestroyed(bDestroyingHierarchy);
}

void UTileInteractionFeatureComponent::EnsureInteractionBoxComponent()
{
	if (InteractionBoxComponent)
	{
		return;
	}

	AActor* Owner = GetOwner();
	if (!Owner)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileInteractionFeatureComponent::EnsureInteractionBoxComponent: Owner was null."));
		return;
	}

	InteractionBoxComponent = NewObject<UBoxComponent>(Owner, NAME_None, RF_Transactional);
	if (!InteractionBoxComponent)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileInteractionFeatureComponent::EnsureInteractionBoxComponent: Failed to create box component."));
		return;
	}

	InteractionBoxComponent->ComponentTags.Add(FName("interactable"));
	InteractionBoxComponent->AttachToComponent(this, FAttachmentTransformRules::KeepRelativeTransform);
	InteractionBoxComponent->SetRelativeTransform(FTransform::Identity);
	if (!BoxComponentBounds.IsNearlyZero())
	{
		InteractionBoxComponent->SetBoxExtent(BoxComponentBounds, false);
	}

	InteractionBoxComponent->RegisterComponent();
}


// Called every frame
void UTileInteractionFeatureComponent::TickComponent(float DeltaTime, ELevelTick TickType,
                                                    FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
}

TArray<FRCMOption> UTileInteractionFeatureComponent::GetRCMOptions_Implementation(FVector ClickWorldPosition)
{
	return IRightClickInterface::GetRCMOptions_Implementation(ClickWorldPosition);
}

void UTileInteractionFeatureComponent::Interact_Implementation(AActor* InteractionOwner)
{
	EnsureInteractionBoxComponent();
	if (!InteractionBoxComponent)
	{
		return;
	}

	if (InteractionBoxComponent->IsOverlappingActor(InteractionOwner))
	{
		OnInteract(InteractionOwner);
	}
}

bool UTileInteractionFeatureComponent::CanInteract_Implementation()
{
	return true;
}

