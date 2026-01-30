// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "RightClickLibrary.h"
#include "RightClickInterface.generated.h"

// This class does not need to be modified.
UINTERFACE(MinimalAPI, Blueprintable)
class URightClickInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API IRightClickInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	TArray<FRCMOption> GetRCMOptions(AActor* Actor, FVector Location);
};
