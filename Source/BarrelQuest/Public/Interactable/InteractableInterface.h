// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "InteractableInterface.generated.h"

// This class does not need to be modified.
UINTERFACE()
class UInteractableInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API IInteractableInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	void Interact(AActor* InteractionOwner);
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	FString GetInteractionText();
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	bool CanInteract();
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	TArray<FIntVector> GetTileInteractionPoints(FVector FromWorld, float Range);
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	void InteractWithTileObject(AActor* InteractionOwner, FIntVector TileIndex, int32 ObjectIndex);
};
