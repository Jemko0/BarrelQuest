#include "Tiles/TileLibrary.h"
#include "Tiles/TileManager.h"
#include "Tiles/TileChunk.h"
#include "BarrelUtilityLibrary.h"
#include "Kismet/KismetSystemLibrary.h"

void FTileRuntimeData::SetValue(FName Key, FString Value)
{
	FString valueStr = FString::Printf(TEXT("%s=%s"), *Key.ToString(), *Value);
	
	if (int32* i = indexLookup.Find(Key))
	{
		runtimeData[*i] = valueStr;
	}
	else
	{
		int32 newIndex = runtimeData.AddUnique(valueStr);
		indexLookup.Add(Key, newIndex);
	}
	
	OnChanged.Broadcast(Key, Value);
}

bool FTileRuntimeData::RemoveValue(FName Key)
{
	if (int32* i = indexLookup.Find(Key))
	{
		indexLookup.Remove(Key);
		runtimeData.RemoveAt(*i);
	}
	else
	{
		return false;
	}
	OnRemoved.Broadcast(Key);
	return true;
}

TArray<FName> FTileRuntimeData::Keys() const
{
	TArray<FName> keys;
	indexLookup.GenerateKeyArray(keys);
	return keys;
}

const TArray<FString>& FTileRuntimeData::Values() const
{
	return runtimeData;
}

FRuntimeDataQueryResult FTileRuntimeData::GetValue(FName Key) const
{
	if (const int32* i = indexLookup.Find(Key))
	{
		const FString& data = runtimeData[*i];
		
		FString ParsedValue;
		if (data.Split(TEXT("="), nullptr, &ParsedValue))
		{
			return FRuntimeDataQueryResult(*i, ParsedValue);
		}
		
		return FRuntimeDataQueryResult(*i, data);
	}

	UE_LOG(LogBarrelQuest, Warning, TEXT("FTileRuntimeData::GetValue Key not found: %s"), *Key.ToString());
	return FRuntimeDataQueryResult(); // invalid
}

void FBuildingValue::CalculateBounds(ATileManager* mgr)
{
	BoundingBoxes.Empty();
	MainBounds = FBox(ForceInit);

	const FVector TileSize = UTileLibrary::GetTileSize();

	for (auto& roomID : RoomIDs)
	{
		FRoomValue room = mgr->GetRoomByID(roomID);
		FBox RoomBox(ForceInit);

		auto AddTileToBox = [&](const FIntVector& tilePos)
		{
			FVector Min((tilePos.X - 0.5f) * TileSize.X, (tilePos.Y - 0.5f) * TileSize.Y, tilePos.Z * TileSize.Z);
			FVector Max((tilePos.X + 0.5f) * TileSize.X, (tilePos.Y + 0.5f) * TileSize.Y, (tilePos.Z + 1.0f) * TileSize.Z);
			RoomBox += Min;
			RoomBox += Max;
		};

		for (const FIntVector& tilePos : room.tiles)
		{
			AddTileToBox(tilePos);
		}

		for (const FIntVector& ceilPos : room.ceilings)
		{
			AddTileToBox(ceilPos);
		}

		if (RoomBox.IsValid)
		{
			BoundingBoxes.Add(RoomBox);
			MainBounds += RoomBox;
		}
	}
}

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

ETileDirection UTileLibrary::GetOppositeDirection(const ETileDirection& inDir)
{
	switch (inDir)
	{
		case ETileDirection::NORTH:
		return ETileDirection::SOUTH;
	
		case ETileDirection::SOUTH:
		return ETileDirection::NORTH;
		
		case ETileDirection::EAST:
		return ETileDirection::WEST;
		
		case ETileDirection::WEST:
		return ETileDirection::EAST;
	}
	
	return ETileDirection::NORTH;
}

FIntVector UTileLibrary::GetTileIndexOffsetFromDirection(const ETileDirection& inDir)
{
	switch (inDir)
	{
		case ETileDirection::NORTH:
		return FIntVector(1, 0, 0);
		
		case ETileDirection::EAST:
		return FIntVector(0, 1, 0);
		
		case ETileDirection::SOUTH:
		return FIntVector(-1, 0, 0);
		
		case ETileDirection::WEST:
		return FIntVector(0, -1, 0);
	}
	
	return FIntVector(0, 0, 0);
}

bool UTileLibrary::IsSquareExitSquare(ATileManager* mgr, const FSquareTile& square, FIntVector squarePos, int currentRoomID)
{
	// Check if this square has a doorframe leading out to a different room
	auto& objects = square.GetReadOnlyObjects();
	for (auto& object : objects)
	{
		const FTileDefinition& def = mgr->GetTileByID(object.ID);
		if (def.Category == ETileCategory::DOORFRAME)
		{
			FIntVector neighborPos = squarePos + GetTileIndexOffsetFromDirection(object.Direction);
			if (mgr->GetRoomIDAt(neighborPos) != currentRoomID)
			{
				return true;
			}
		}
	}

	// Check if a neighbor has a doorframe leading into this square from a different room
	TArray<ETileDirection> Dirs = { ETileDirection::NORTH, ETileDirection::EAST, ETileDirection::SOUTH, ETileDirection::WEST };
	for (ETileDirection dir : Dirs)
	{
		FIntVector neighborPos = squarePos + GetTileIndexOffsetFromDirection(dir);
		bool found = false;
		const FSquareTile& neighborSquare = mgr->GetSquareTileByTileIndex(neighborPos, found);
		
		if (found)
		{
			ETileDirection opposite = GetOppositeDirection(dir);
			for (auto& nObject : neighborSquare.GetReadOnlyObjects())
			{
				const FTileDefinition& nDef = mgr->GetTileByID(nObject.ID);
				if (nDef.Category == ETileCategory::DOORFRAME && nObject.Direction == opposite)
				{
					// Neighbor has a door pointing at us. Is it from a different room?
					if (mgr->GetRoomIDAt(neighborPos) != currentRoomID)
					{
						return true;
					}
				}
			}
		}
	}
	
	return false;
}

void UTileLibrary::DrawTileSquaresFromSet(const TSet<FIntVector>& squares)
{
	for (auto& square : squares)
	{
		FVector worldPos = TileToWorldPosition(square) + FVector(0, 0, GetTileSize().Z / 2);
		UWorld* world = GEngine->GameViewport->GetWorld();
		UKismetSystemLibrary::DrawDebugBox(world, worldPos, GetTileSize() / 2, FLinearColor::Green, FRotator::ZeroRotator, 
			world->GetDeltaSeconds() * 1.05f, 2);
	}
}

void UTileLibrary::DrawTileSquaresFromArray(const TArray<FIntVector>& squares)
{
	for (auto& square : squares)
	{
		FVector worldPos = TileToWorldPosition(square) + FVector(0, 0, GetTileSize().Z / 2);
		UWorld* world = GEngine->GameViewport->GetWorld();
		UKismetSystemLibrary::DrawDebugBox(world, worldPos, GetTileSize() / 2, FLinearColor::Green, FRotator::ZeroRotator, 
			world->GetDeltaSeconds() * 1.05f, 2);
	}
}

FTileRuntimeData& UTileLibrary::SetRuntimeDataValue(FTileRuntimeData& runtimeData, FName Key, FString Value)
{
	runtimeData.SetValue(Key, Value);
	return runtimeData;
}

FTileRuntimeData UTileLibrary::ConvertMapRuntimeDataToTileRuntimeData(const TMap<FName, FString>& Map)
{
	FTileRuntimeData runtimeData;
	for (auto& pair : Map)
	{
		runtimeData.SetValue(pair.Key, pair.Value);
	}
	
	return runtimeData;
}

TArray<FString> UTileLibrary::ParseRuntimeData(FTileRuntimeData& runtimeData)
{
	TArray<FString> strArray;
	
	TArray<FName> keys = runtimeData.Keys();
	
	if (keys.Num() < 1) return TArray<FString>();
	
	for (const FName key : keys)
	{
		FString keyStr = key.ToString();
		FRuntimeDataQueryResult query = runtimeData.GetValue(key);
		FString valueStr = query.data;
		
		FStringFormatNamedArguments args;
		args.Add(keyStr, valueStr);
		
		FString formattedStr = FString::Printf(TEXT("%s=%s"), *keyStr, *valueStr);
		strArray.Add(formattedStr);
	}
	
	return strArray;
}
