#include "Tiles/TileLibrary.h"

#include "BarrelUtilityLibrary.h"
#include "Developer/NaniteUtilities/Public/VectorUtil.h"
#include "Tiles/TileManager.h"

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

ATileChunk::ATileChunk()
{
	TileSize = UTileLibrary::GetTileSize();
}

FIntVector ATileChunk::ChunkSize = FIntVector(96, 96, 7);

void ATileChunk::OnRep_ReplicatedTiles()
{
	Tiles.Empty();
	for (auto& entry : ReplicatedTiles)
	{
		Tiles.Add(entry.Location, entry.Tile);
	}
		
	BuildChunk();
}

void ATileChunk::PrepareForReplication()
{
	ReplicatedTiles.Empty();
	for (auto& Pair : Tiles)
	{
		FTileEntry Entry;
		Entry.Location = Pair.Key;
		Entry.Tile = Pair.Value;
		ReplicatedTiles.Add(Entry);
	}
}

void ATileChunk::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const
{
	Super::GetLifetimeReplicatedProps(OutLifetimeProps);
	DOREPLIFETIME(ATileChunk, ReplicatedTiles);
}

void ATileChunk::BuildChunk()
{
	ATileManager* mgr = GetOwningTileManager();
	
	if (!mgr)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("TileManager was null!"));
		return;
	}
	
	for (auto& Pair : HISMMap)
	{
		Pair.Value->ClearInstances();
	}
	
	for (auto& [Position, Square] : Tiles)
	{
		FVector InstanceLoc = FVector(
		   Position.X * TileSize.X,
		   Position.Y * TileSize.Y,
		   Position.Z * TileSize.Z 
		);
		
		for (auto& o : Square.GetObjectsOnSquare())
		{
			const FTileDefinition& tile = mgr->GetTileByID(o.ID);
			
			FTileRenderKey Key { tile.Mesh, tile.ParentMaterial };
			UHierarchicalInstancedStaticMeshComponent* HISM = nullptr;

			if (!HISMMap.Contains(Key))
			{
				HISM = NewObject<UHierarchicalInstancedStaticMeshComponent>(this);
				HISM->SetStaticMesh(tile.Mesh);
				HISM->SetMaterial(0, tile.ParentMaterial);
				HISM->SetNumCustomDataFloats(6);
				HISM->RegisterComponent();
				HISMMap.Add(Key, HISM);
			}
			else
			{
				HISM = HISMMap[Key];
			}
			
			FRotator Rotation = FRotator(0.f, static_cast<float>(o.Direction) * 90.f, 0.f);
			FTransform InstanceTransform = FTransform(Rotation, InstanceLoc, FVector(1.0f));
			
			int32 instanceIndex = HISM->AddInstance(InstanceTransform, false);
			
			TArray<float> instanceData = TArray<float>();
			
			instanceData.Add(static_cast<float>(tile.Albedo));
			instanceData.Add(static_cast<float>(tile.Metallic));
			instanceData.Add(static_cast<float>(tile.Normal));
			instanceData.Add(static_cast<float>(tile.Specular));
			
			instanceData.Add(tile.BaseMetallic);
			instanceData.Add(tile.BaseRoughness);
			
			HISM->SetCustomData(instanceIndex, instanceData, false);
		}
	}
	
	for (auto& Pair : HISMMap)
	{
		Pair.Value->MarkRenderStateDirty();
	}
}

ATileManager* ATileChunk::GetOwningTileManager() const
{
	return Cast<ATileManager>(GetOwner());
}

FSquareTile& ATileChunk::GetOrCreateSquareTile(FIntVector Position)
{
	FSquareTile* Tile = Tiles.Find(Position);
	if (Tile)
	{
		return *Tile;
	}
	
	//tile is nullptr
	FSquareTile& newTile = AddSquare(Position, FSquareTile());
	BuildChunk();
	
	return newTile;
}

FSquareTile& ATileChunk::AddSquare(FIntVector Position, const FSquareTile& newSquare)
{
	FSquareTile& AddedTile = Tiles.Add(Position, newSquare);
	BuildChunk();
	
	return AddedTile;
}

void ATileChunk::AddObject(FIntVector Position, const FTileObject& Object)
{
	FSquareTile& Tile = GetOrCreateSquareTile(Position);
	Tile.GetObjectsOnSquare().Add(Object);
	
	BuildChunk();
}

TArray<FTileObject>& ATileChunk::GetObjectsOnSquare(FIntVector Position, bool& success)
{
	static TArray<FTileObject> EmptyArray; // fallback
	success = true;
	
	FSquareTile* Tile = Tiles.Find(Position);
	if (!Tile)
	{
		success = false;
		return EmptyArray;
	}
	return Tile->GetObjectsOnSquare();
}

const FSquareTile& ATileChunk::GetSquareTile(FIntVector Position)
{
	static FSquareTile fallback = FSquareTile();
	
	FSquareTile* Tile = Tiles.Find(Position);
	if (Tile)
	{
		return *Tile;
	}
	
	//tile is nullptr
	return fallback;
}

bool ATileChunk::HasSquare(FIntVector Position)
{
	FSquareTile* Tile = Tiles.Find(Position);
	return Tile != nullptr;
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


