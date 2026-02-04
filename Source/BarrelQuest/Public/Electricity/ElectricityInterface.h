// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "ElectricityInterface.generated.h"

// This class does not need to be modified.
UINTERFACE()
class UElectricityInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API IElectricityInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	UFUNCTION(BlueprintNativeEvent)
	void ReceiveSignal(float units);
	
	UFUNCTION(BlueprintNativeEvent)
	void BindActor(AActor* actor);
};
