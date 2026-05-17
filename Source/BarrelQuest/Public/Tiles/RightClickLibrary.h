// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/ObjectMacros.h"
#include "UObject/ScriptMacros.h"
#include "RightClickLibrary.generated.h"

USTRUCT(BlueprintType)
struct FRCMInvokeMessage
{
	GENERATED_BODY()
	
public:
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FString> StringData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<uint8> ByteData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FIntVector> IntVectorData;
};

USTRUCT(BlueprintType)
struct FRCMOption
{
	GENERATED_BODY()
	
public:
	FRCMOption() = default;
	FRCMOption(const FText& name, const FName& color, const FString& invoke) : OptionName(name), UIColor(color), invokeID(invoke) {};
	FRCMOption(const FString& name, const FString& color, const FString& invoke) : OptionName(FText::FromString(name)), UIColor(*color), invokeID(invoke) {};
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FText OptionName;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FName UIColor;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FString invokeID;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FName, FRCMInvokeMessage> Payload;
};