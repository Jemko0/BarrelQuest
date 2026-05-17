// 


#include "Tiles/SavingLoading/MapEditorWorldSaveGame.h"

#include "Kismet/GameplayStatics.h"
#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "Tiles/TileChunk.h"
#include "Tiles/TileManager.h"
#include "Tiles/UGCTileManager/TileManagerUGC.h"
#include "Tiles/UGCTileManager/UGCApplierComponent.h"

UMapEditorWorldSaveGame* UMapEditorWorldSaveGame::CreateFromTileManager(ATileManager* TileManager)
{
	if (!TileManager)
	{
		return nullptr;
	}
	
	UMapEditorWorldSaveGame* sg = Cast<UMapEditorWorldSaveGame>(
		UGameplayStatics::CreateSaveGameObject(StaticClass()));
	
	sg->WorldName = TileManager->WorldName;

	//Save Chunks
	for (ATileChunk* chunk : TileManager->Chunks)
	{
		FSavedChunk savedChunk = UTileSaveLoadLibrary::SerializeChunk(chunk);
		sg->WorldChunks.Add(chunk->ChunkPosition, savedChunk);
	}
	
	//Save Rooms
	sg->RoomIDToTiles = TileManager->RoomIDToTiles;
	sg->TilesToRoomID = TileManager->RoomTilesToID;
	
	sg->Version = TileManager->WorldVersion + 1;
	
	UUserResourceComponent* UGCComponent = Cast<UUserResourceComponent>(TileManager->GetComponentByClass(UUserResourceComponent::StaticClass()));
	ATileManagerUGC* TileManagerUGC = Cast<ATileManagerUGC>(TileManager->GetComponentByClass(ATileManagerUGC::StaticClass()));
	
	if (UGCComponent)
	{
		sg->DownloadedResources = UGCComponent->ResourceCache;
	}

	if (TileManagerUGC)
	{
		sg->EnvironmentData = TileManagerUGC->WorldEnvironmentData;
		sg->BGMData = TileManagerUGC->WorldBGMData;
	}
	
	sg->UserDefinedTiles = TileManager->UserDefinedTileDefinitions;
	
	sg->MapEditorData = UTileSaveLoadLibrary::GetMapEditorSaveData(TileManager->GetWorld());
	
	return sg;
}
