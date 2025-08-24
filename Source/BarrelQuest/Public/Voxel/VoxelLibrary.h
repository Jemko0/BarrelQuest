
#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "VoxelChunk.h"
#include "VoxelLibrary.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UVoxelLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
public:
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FVoxelPos MakeVoxelPos(uint8 x, uint8 y, uint8 z);

	UFUNCTION(BlueprintCallable, BlueprintPure)
	static void BreakVoxelPos(FVoxelPos& s, uint8& x, uint8& y, uint8& z);
};
