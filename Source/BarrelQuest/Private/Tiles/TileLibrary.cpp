#include "Tiles/TileLibrary.h"
#include "Tiles/TileManager.h"
#include "Tiles/TileChunk.h"
#include "BarrelUtilityLibrary.h"

bool FSquareTile::HasObjectOfCategory(ETileCategory category, ATileManager* mgr) const
{
	for (auto& object : objects)
	{
		const FTileDefinition& tileDef = mgr->GetTileByID(object.ID);
			
		if (tileDef.Category == category)
		{
			return true;
		}
	}
	return false;
}

bool FSquareTile::HasObjectOfDirection(ETileDirection direction) const
{
	for (auto& object : objects)
	{
		if (object.Direction == direction)
		{
			return true;
		}
	}
	return false;
}

void UTileLibrary::SetRuntimeBoolProperty(FName prop, bool v, FTileRuntimeData& runtimeData)
{
	runtimeData.boolData[prop] = v;
}

void UTileLibrary::SetRuntimeFloatProperty(FName prop, float v, FTileRuntimeData& runtimeData)
{
	runtimeData.floatData[prop] = v;
}

void UTileLibrary::SetRuntimeIntProperty(FName prop, int32 v, FTileRuntimeData& runtimeData)
{
	runtimeData.intData[prop] = v;
}

///Performance heavy function, be cautious
void UTileLibrary::SetRuntimeStringProperty(FName prop, FString v, FTileRuntimeData& runtimeData)
{
	runtimeData.stringData[prop] = v;
}

bool UTileLibrary::GetRuntimeBoolProperty(FName Key, FTileRuntimeData& runtimeData)
{
	bool* b = runtimeData.boolData.Find(Key);
	if (!b)
	{
		return false;
	}
	
	return *b;
}

float UTileLibrary::GetRuntimeFloatProperty(FName Key, FTileRuntimeData& runtimeData)
{
	float* f = runtimeData.floatData.Find(Key);
	if (!f)
	{
		return -1.0f;
	}
	return *f;
}

int UTileLibrary::GetRuntimeIntProperty(FName Key, FTileRuntimeData& runtimeData)
{
	int* i = runtimeData.intData.Find(Key);
	if (!i)
	{
		return -1;
	}
	return *i;
}

FString UTileLibrary::GetRuntimeStringProperty(FName Key, FTileRuntimeData& runtimeData)
{
	FString* s = runtimeData.stringData.Find(Key);
	if (!s)
	{
		return FString(TEXT("nullKey"));
	}
	return *s;
}

void UTileLibrary::SetSquareWalkable(FSquareTile& sq, bool newWalkable)
{
	sq.SetWalkable(newWalkable);
}

bool UTileLibrary::SquareIsWalkable(FSquareTile& sq, bool newWalkable)
{
	return sq.IsWalkable();
}

FIntVector2 UTileLibrary::WorldToChunkPosition(FVector worldPosition)
{
	FIntVector chunkSize = ATileChunk::ChunkSize;
	const FVector TileSize = UTileLibrary::GetTileSize();
    
	FIntVector2 chunkPosition;
	chunkPosition.X = FMath::RoundToInt(worldPosition.X / (chunkSize.X * TileSize.X));
	chunkPosition.Y = FMath::RoundToInt(worldPosition.Y / (chunkSize.Y * TileSize.Y));
    
	return chunkPosition;
}

FIntVector UTileLibrary::WorldToLocalChunkTilePosition(FVector worldPosition, ATileChunk* chunk)
{
	if (!chunk)
	{
		UE_LOG(LogBarrelQuest, Error, TEXT("Attempt to get chunk from null chunk"));
		return FIntVector(0, 0, 0);
	}

	const FVector TileSize = chunk->TileSize;
	const FIntVector ChunkSize = ATileChunk::ChunkSize;

	const FVector LocalPos = worldPosition - chunk->GetActorLocation();

	FIntVector TilePos(
	   FMath::FloorToInt(LocalPos.X / TileSize.X),
	   FMath::FloorToInt(LocalPos.Y / TileSize.Y),
	   FMath::FloorToInt(LocalPos.Z / TileSize.Z)
	);

	return TilePos;
}


FIntVector UTileLibrary::WorldToTilePosition(FVector WorldPosition)
{
	const FVector TileSize = GetTileSize();

	FIntVector TilePos(
	   FMath::FloorToInt((WorldPosition.X + TileSize.X * 0.5f) / TileSize.X),
	   FMath::FloorToInt((WorldPosition.Y + TileSize.Y * 0.5f) / TileSize.Y),
	   FMath::FloorToInt((WorldPosition.Z) / TileSize.Z)
	);

	return TilePos;
}

FVector UTileLibrary::ChunkToWorldPosition(FIntVector2 chunkPosition)
{
	FIntVector chunkSize = ATileChunk::ChunkSize;
	FVector tileSize = GetTileSize();
	return FVector(chunkPosition.X * (float)chunkSize.X * tileSize.X, chunkPosition.Y * (float)chunkSize.Y * tileSize.Y, 0);
}

FVector UTileLibrary::TileToWorldPosition(FIntVector tilePosition)
{
	const FVector TileSize = GetTileSize();
    
	FVector worldPos(
	   tilePosition.X * TileSize.X,
	   tilePosition.Y * TileSize.Y,
	   tilePosition.Z * TileSize.Z
	);
    
	return worldPos;
}

int UTileLibrary::AddObjectToSquare(FTileObject object, FSquareTile& squareTile)
{
	return squareTile.GetObjectsOnSquare().Add(object);
}

TArray<FTileObject>& UTileLibrary::GetObjectsOnSquare(UPARAM(Ref) FSquareTile& square)
{
	return square.GetObjectsOnSquare();
}


FVector UTileLibrary::GetTileSize()
{
	return FVector(200.0f, 200.0f, 400.0f);
}

FIntVector UTileLibrary::GetChunkSize()
{
	return ATileChunk::ChunkSize;
}

bool UTileLibrary::CountsAsWall(ETileCategory cat)
{
	return cat == ETileCategory::WALL || cat == ETileCategory::DOORFRAME;
}


