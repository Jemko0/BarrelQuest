// 

#pragma once

#include "CoreMinimal.h"
#include "Tiles/TileLibrary.h"
#include "UObject/Interface.h"
#include "TileFeatureSerializationInterface.generated.h"

// This class does not need to be modified.
UINTERFACE(Blueprintable)
class UTileFeatureSerializationInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API ITileFeatureSerializationInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	UFUNCTION(BlueprintCallable, BlueprintImplementableEvent)
	void SerializeRuntimeData(UPARAM(ref) FTileRuntimeData& RuntimeData);
	
	UFUNCTION(BlueprintCallable, BlueprintImplementableEvent)
	void DeserializeRuntimeData(const FTileRuntimeData& RuntimeData);
};
