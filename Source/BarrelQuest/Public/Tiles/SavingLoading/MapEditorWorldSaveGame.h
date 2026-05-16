// 

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/SaveGame.h"
#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "Tiles/TileSaveLoadLibrary.h"
#include "MapEditorWorldSaveGame.generated.h"

/**
 * 
 */

UCLASS()
class BARRELQUEST_API UMapEditorWorldSaveGame : public USaveGame
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TMap<FIntVector2, FSavedChunk> WorldChunks;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TMap<int32, FRoomValue> RoomIDToTiles;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TMap<FIntVector, int32> TilesToRoomID;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FString WorldName;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	int32 Version;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FDateTime CreationDate;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FDateTime LastUpdateDate;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FWorldBGMData BGMData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FWorldEnvironmentData EnvironmentData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TMap<FName, FTileDefinition> UserDefinedTiles;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TMap<FString, FCachedResource> DownloadedResources;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FMapEditorSaveData MapEditorData;
	
	UFUNCTION(BlueprintCallable)
	static UMapEditorWorldSaveGame* CreateFromTileManager(ATileManager* TileManager);
};
