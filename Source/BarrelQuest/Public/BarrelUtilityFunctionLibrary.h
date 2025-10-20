

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "BarrelUtilityFunctionLibrary.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UBarrelUtilityFunctionLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FLinearColor HexStringToLinearColor(FString hexString);
};
