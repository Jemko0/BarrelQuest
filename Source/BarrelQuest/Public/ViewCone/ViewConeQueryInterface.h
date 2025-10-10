

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "ViewCone/ViewConeActor.h"
#include "ViewConeQueryInterface.generated.h"

// This class does not need to be modified.
UINTERFACE(MinimalAPI)
class UViewConeQueryInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API IViewConeQueryInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:

	UFUNCTION(BlueprintImplementableEvent, BlueprintCallable, Category = "View Cone")
	AViewConeActor* GetViewCone() const;

	UFUNCTION(BlueprintImplementableEvent, BlueprintCallable, Category = "View Cone")
	FVector GetFocusPoint() const;

};
