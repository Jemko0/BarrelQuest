// 

#pragma once

#include "CoreMinimal.h"
#include "TagDataAsset.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "CraftingLibrary.generated.h"

/**
 * 
 */

USTRUCT(BlueprintType)
struct FCraftingRecipeIngredient
{
	GENERATED_BODY()
public:
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UTagDataAsset* Tag;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	int32 Amount;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	bool useTag;
};

UCLASS()
class BARRELQUEST_API UCraftingLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
};
