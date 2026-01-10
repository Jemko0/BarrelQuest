// 

#pragma once

#include "CoreMinimal.h"
#include "Engine/DataAsset.h"
#include "TagDataAsset.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UTagDataAsset : public UPrimaryDataAsset
{
	GENERATED_BODY()
	
public:
	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category="Data")
	FString tagString;
};
