

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "TemperatureInterface.generated.h"

// This class does not need to be modified.
UINTERFACE(MinimalAPI)
class UTemperatureInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API ITemperatureInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:

	UFUNCTION(BlueprintImplementableEvent, BlueprintCallable, Category = "Temperature")
	float GetInsulationLevel() const;
	//virtual float GetInsulationLevel_Implementation() const { return 0.0f; }
};
