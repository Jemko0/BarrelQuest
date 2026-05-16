// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "MapEditorBaseInterface.generated.h"

// This class does not need to be modified.
UINTERFACE()
class UMapEditorBaseInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API IMapEditorBaseInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	UFUNCTION(BlueprintNativeEvent, BlueprintCallable)
	bool IsMapEditorInstance();
};
