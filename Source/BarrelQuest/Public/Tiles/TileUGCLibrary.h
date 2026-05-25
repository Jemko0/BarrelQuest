// 

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "TileUGCLibrary.generated.h"

USTRUCT(BlueprintType)
struct FDreamWorldConnection
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	int64 ConnectionID = 0;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	int64 FromWorldID = 0;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	int64 ToWorldID = 0;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FString TransitionTargetName;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FDateTime CreatedAt;
};

USTRUCT(BlueprintType)
struct FDreamWorldMetadata
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	int64 ID = 0;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FString Name;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FString Author;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FDateTime CreatedAt;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FDateTime LastUpdatedAt;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FString MapFileURL;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	FString LocalSavePath;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	TArray<FDreamWorldConnection> Connections;

	UPROPERTY(BlueprintReadWrite, VisibleAnywhere)
	TArray<FString> AvailableTransitionTargetNames;
};

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UTileUGCLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
};
