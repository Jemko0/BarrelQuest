// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"
#include "RightClickLibrary.generated.h"

USTRUCT(BlueprintType)
struct FRCMOption
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FText OptionName;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FName UIColor;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FString invokeID;
};