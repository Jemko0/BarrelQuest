// 

#pragma once

#include "CoreMinimal.h"
#include "TileLibrary.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "TileSaveLoadLibrary.generated.h"

USTRUCT(BlueprintType)
struct FMapEditorSaveData
{
	GENERATED_BODY()
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FVector PawnLocation;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FName SelectedTileID;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FRotator CameraRotation;
};

USTRUCT(BlueprintType)
struct FSavedChunk
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FIntVector> SquarePositions;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FSquareTile> ChunkSquares;
};

USTRUCT(BlueprintType)
struct FBasicResourceHandle
{
	GENERATED_BODY()
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FString ResourcePath;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FSoftObjectPath AssetSoftObject;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	bool IsBuiltin;
};

USTRUCT(BlueprintType)
struct FWorldBGMData
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FBasicResourceHandle AudioResource;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	float AudioVolume = 1.0f;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	float AudioPlaybackSpeedMultiplier = 1.0f;
};

USTRUCT(BlueprintType)
struct FWorldEnvironmentData
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	bool HasBackground = false;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FBasicResourceHandle BackgroundResource;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FVector2D BackgroundScroll;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FVector2D BackgroundTextureSize;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	float SunLightIntensity = 10.0f;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FLinearColor SunLightColor = FLinearColor(1.0f, 1.0f, 1.0f);
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	float SkyLightIntensity = 10.0f;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FLinearColor SkyLightColor = FLinearColor(1.0f, 1.0f, 1.0f);
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	float DayTime = 12.0f;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	float TimeAccel = 0.0f;
};

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UTileSaveLoadLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
public:
	UFUNCTION(BlueprintCallable)
	static FSavedChunk SerializeChunk(ATileChunk* InChunk);
	
	UFUNCTION(BlueprintCallable)
	static FMapEditorSaveData GetMapEditorSaveData(UObject* WorldContextObject);
};
