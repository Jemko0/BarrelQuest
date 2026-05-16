// 


#include "Tiles/TileSaveLoadLibrary.h"

#include "BarrelUtilityLibrary.h"
#include "Tiles/TileChunk.h"

FSavedChunk UTileSaveLoadLibrary::SerializeChunk(ATileChunk* InChunk)
{
	FSavedChunk result;
	
	for (const FIntVector& key : InChunk->TileKeys)
	{
		const FSquareTile& square = InChunk->Tiles[key];
		
		result.SquarePositions.Add(key);
		result.ChunkSquares.Add(square);
	}
	
	return result;
}

FMapEditorSaveData UTileSaveLoadLibrary::GetMapEditorSaveData(UObject* WorldContextObject)
{
	UWorld* world = WorldContextObject->GetWorld();
	
	if (!world)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("GetMapEditorSaveData: No World Found"));
	}
	
	UE_LOG(LogBarrelQuest, Warning, TEXT("GetMapEditorSaveData: UNFINISHED STUB CALLED"));
	return FMapEditorSaveData();
}
