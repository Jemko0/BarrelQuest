// 


#include "Tiles/TileSaveLoadLibrary.h"

#include "BarrelUtilityLibrary.h"
#include "Tiles/Features/Interfaces/TileFeatureSerializationInterface.h"
#include "Tiles/Features/TileFeatureLibrary.h"
#include "Tiles/TileChunk.h"

FSavedChunk UTileSaveLoadLibrary::SerializeChunk(ATileChunk* InChunk)
{
	FSavedChunk result;
	
	for (const FIntVector& key : InChunk->TileKeys)
	{
		FSquareTile& square = InChunk->Tiles[key];
		if (FStoredFeatureArray* StoredFeatures = InChunk->AttachedFeatures.Find(key))
		{
			for (const FStoredFeature& StoredFeature : StoredFeatures->features)
			{
				if (!StoredFeature.ComponentPtr || !square.GetObjectsOnSquare().IsValidIndex(StoredFeature.OwningObject))
				{
					continue;
				}

				FTileRuntimeData& RuntimeData = square.GetObjectsOnSquare()[StoredFeature.OwningObject].runtimeData;
				UTileFeatureLibrary::SerializeFeatureRuntimeData(StoredFeature.ComponentPtr, StoredFeature.FeatureName, RuntimeData);

				if (StoredFeature.ComponentPtr->GetClass()->ImplementsInterface(UTileFeatureSerializationInterface::StaticClass()))
				{
					ITileFeatureSerializationInterface::Execute_SerializeRuntimeData(StoredFeature.ComponentPtr, RuntimeData);
				}
			}
		}
		
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
