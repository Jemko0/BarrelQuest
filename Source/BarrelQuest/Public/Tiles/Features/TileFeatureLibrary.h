// 

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "TileFeatureLibrary.generated.h"

/**
 * 
 */

#define TF_GENERATED_BODY() \
	protected: \
	FTileObject& OwningObject; \
	virtual void SetOwningObject(FTileObject& OwnerObject) \
	{ \
		OwningObject = OwnerObject;\
	} \
	virtual FTileObject& GetOwningObject() \
	{ \
		return OwningObject;\
	} \

UCLASS()
class BARRELQUEST_API UTileFeatureLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
};