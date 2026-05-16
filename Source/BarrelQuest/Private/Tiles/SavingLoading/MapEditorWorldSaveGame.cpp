// 


#include "Tiles/SavingLoading/MapEditorWorldSaveGame.h"

#include "Kismet/GameplayStatics.h"
#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "Tiles/TileChunk.h"
#include "Tiles/TileManager.h"

UMapEditorWorldSaveGame* UMapEditorWorldSaveGame::CreateFromTileManager(ATileManager* TileManager)
{
	if (!TileManager)
	{
		return nullptr;
	}
	
	UMapEditorWorldSaveGame* sg = Cast<UMapEditorWorldSaveGame>(
		UGameplayStatics::CreateSaveGameObject(TSubclassOf<UMapEditorWorldSaveGame>()));
	
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
	
	UUserResourceComponent* UGCComponent = Cast<UUserResourceComponent>(TileManager->GetComponentByClass(TSubclassOf<UUserResourceComponent>()));
	
	if (UGCComponent)
	{
		sg->DownloadedResources = UGCComponent->ResourceCache;
	}
	
	sg->MapEditorData = UTileSaveLoadLibrary::GetMapEditorSaveData(TileManager->GetWorld());
	
	return sg;
}
