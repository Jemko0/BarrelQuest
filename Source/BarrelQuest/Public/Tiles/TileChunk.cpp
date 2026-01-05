#include "Tiles/TileChunk.h"
#include "Tiles/TileManager.h"
#include "BarrelUtilityLibrary.h"

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
	
	//BuildChunk();
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

    // Clear existing HISM components
    for (auto& Pair : HISMMap)
    {
        if (Pair.Value)
        {
            Pair.Value->ClearInstances();
        }
    }
    HISMMap.Empty();
    HISMReverseLookup.Empty();
	UE_LOG(LogBarrelQuest, Warning, TEXT("BuildChunk called, Tiles count: %d"), Tiles.Num());
	
    // Iterate all tiles in this chunk
    for (auto& TilePair : Tiles)
    {
        const FIntVector& Position = TilePair.Key;
        FSquareTile& Square = TilePair.Value;

        TArray<FTileObject>& Objects = Square.GetObjectsOnSquare();
        for (int32 i = 0; i < Objects.Num(); i++)
        {
            FTileObject& ObjectDef = Objects[i];
            const FTileDefinition& TileDef = mgr->GetTileByID(ObjectDef.ID);

            // Skip logic-only objects (no mesh)
            if (!TileDef.Mesh)
            {
                ObjectDef.RenderInstanceIndex = -1;
                continue;
            }

            // Build key for HISM map
            FTileRenderKey Key { TileDef.Mesh, TileDef.ParentMaterial };

            // Lazily create HISM component
            if (!HISMMap.Contains(Key))
            {
                UHierarchicalInstancedStaticMeshComponent* HISM = NewObject<UHierarchicalInstancedStaticMeshComponent>(this);
                HISM->SetStaticMesh(TileDef.Mesh);
                HISM->SetMaterial(0, TileDef.ParentMaterial);
                HISM->SetNumCustomDataFloats(customDataFloats);
                HISM->RegisterComponent();
                HISMMap.Add(Key, HISM);
                HISMReverseLookup.Add(Key, TArray<FObjectReference>());
            }

            UHierarchicalInstancedStaticMeshComponent* HISM = HISMMap[Key];
            TArray<FObjectReference>& Lookup = HISMReverseLookup[Key];

            // Compute instance transform
            FVector InstanceLoc = FVector(
                Position.X * TileSize.X,
                Position.Y * TileSize.Y,
                Position.Z * TileSize.Z
            );
            FRotator Rotation = FRotator(0.f, static_cast<float>(ObjectDef.Direction) * 90.f, 0.f);
            FTransform InstanceTransform(Rotation, InstanceLoc, FVector(1.f));

            // Add instance
            int32 InstanceIndex = HISM->AddInstance(InstanceTransform, false);
            ObjectDef.RenderInstanceIndex = InstanceIndex;

            // Ensure Lookup array is large enough
            if (Lookup.Num() <= InstanceIndex)
            {
                Lookup.SetNum(InstanceIndex + 1);
            }
            Lookup[InstanceIndex] = { Position, i };
        	
            TStaticArray<float, customDataFloats> InstanceData = GetCustomDataArray(TileDef, ObjectDef);
            HISM->SetCustomData(InstanceIndex, InstanceData, true);
        	
        	UE_LOG(LogBarrelQuest, Warning, TEXT("HISM %s has %d instances"), *Key.Mesh->GetName(), HISM->GetInstanceCount());
        }
    }
	
	for (auto& HISM : HISMMap)
	{
		HISM.Value->BuildTreeIfOutdated(true, false);  // Rebuild the HISM tree
		HISM.Value->MarkRenderStateDirty();
		
		
	}
}

void ATileChunk::AddObjectInstance(const FIntVector& Position, int32 ObjectIndex, FTileObject& ObjectDef)
{
    ATileManager* mgr = GetOwningTileManager();
    if (!mgr) return;

    const FTileDefinition& TileDef = mgr->GetTileByID(ObjectDef.ID);
    if (!TileDef.Mesh) return; // Logic object only

    FTileRenderKey Key { TileDef.Mesh, TileDef.ParentMaterial };
    
    // Ensure Component Exists
    if (!HISMMap.Contains(Key))
    {
        // If HISM doesn't exist, lazily Create it
        UHierarchicalInstancedStaticMeshComponent* HISM = NewObject<UHierarchicalInstancedStaticMeshComponent>(this);
        HISM->SetStaticMesh(TileDef.Mesh);
        HISM->SetMaterial(0, TileDef.ParentMaterial);
        HISM->SetNumCustomDataFloats(customDataFloats);
        HISM->RegisterComponent();
        HISMMap.Add(Key, HISM);
        HISMReverseLookup.Add(Key, TArray<FObjectReference>());
    }

    UHierarchicalInstancedStaticMeshComponent* HISM = HISMMap[Key];

    // Math
    FVector InstanceLoc = FVector(
          Position.X * TileSize.X,
          Position.Y * TileSize.Y,
          Position.Z * TileSize.Z 
    );
    FRotator Rotation = FRotator(0.f, static_cast<float>(ObjectDef.Direction) * 90.f, 0.f);
    FTransform InstanceTransform = FTransform(Rotation, InstanceLoc, FVector(1.0f));

    // Add Instance
    int32 NewIndex = HISM->AddInstance(InstanceTransform, false); // false = Don't mark dirty yet
    ObjectDef.RenderInstanceIndex = NewIndex;

    // Update Reverse Lookup
    TArray<FObjectReference>& Lookup = HISMReverseLookup[Key];
    if (Lookup.Num() <= NewIndex)
    {
        Lookup.SetNum(NewIndex + 1);
    }
    Lookup[NewIndex] = { Position, ObjectIndex };

    // Set Data
    TStaticArray<float, customDataFloats> instanceData = GetCustomDataArray(TileDef, ObjectDef);
    HISM->SetCustomData(NewIndex, instanceData, true); // true = Mark Dirty Now
}

void ATileChunk::RemoveObjectInstance(const FTileObject& ObjectDef)
{
    // If it was never rendered (e.g. logic block), ignore
    if (ObjectDef.RenderInstanceIndex == -1) return;

    ATileManager* mgr = GetOwningTileManager();
    if (!mgr) return;

    const FTileDefinition& tile = mgr->GetTileByID(ObjectDef.ID);
    FTileRenderKey Key { tile.Mesh, tile.ParentMaterial };

    if (!HISMMap.Contains(Key)) return;
    
    UHierarchicalInstancedStaticMeshComponent* HISM = HISMMap[Key];
    TArray<FObjectReference>& Lookup = HISMReverseLookup[Key];

    int32 IndexToRemove = ObjectDef.RenderInstanceIndex;
    int32 LastIndex = HISM->GetInstanceCount() - 1;
	
    HISM->RemoveInstance(IndexToRemove);
	
    if (IndexToRemove != LastIndex)
    {
        // an instance was moved. We must update its owner.
        // who was at the end?
        FObjectReference SwappedOwnerRef = Lookup[LastIndex];
        
        // update Lookup Table
        Lookup[IndexToRemove] = SwappedOwnerRef;

        // update the actual obj in the grid
        if (Tiles.Contains(SwappedOwnerRef.TilePosition))
        {
             FSquareTile& Square = Tiles[SwappedOwnerRef.TilePosition];
             if (Square.GetObjectsOnSquare().IsValidIndex(SwappedOwnerRef.ObjectArrayIndex))
             {
                 Square.GetObjectsOnSquare()[SwappedOwnerRef.ObjectArrayIndex].RenderInstanceIndex = IndexToRemove;
             }
        }
    }

    // 3. Shrink Lookup
    if (Lookup.Num() > 0)
    {
        Lookup.RemoveAt(LastIndex);
    }
}

ATileManager* ATileChunk::GetOwningTileManager() const
{
	if (!GetOwner())
	{
		UE_LOG(LogBarrelQuest, Error, TEXT("ATileChunk::GetOwningTileManager has no owner!"));
		return nullptr;
	}
	
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
	
	return newTile;
}

FSquareTile& ATileChunk::AddSquare(FIntVector Position, const FSquareTile& newSquare)
{
	FSquareTile& AddedTile = Tiles.Add(Position, newSquare);
	
	TArray<FTileObject>& Objects = AddedTile.GetObjectsOnSquare();
	for(int32 i = 0; i < Objects.Num(); i++)
	{
		AddObjectInstance(Position, i, Objects[i]);
	}
	
	return AddedTile;
}
void ATileChunk::AddObject(FIntVector Position, const FTileObject& Object)
{
	FSquareTile& tile = GetOrCreateSquareTile(Position);
	int32 newObjectIndex = tile.GetObjectsOnSquare().Add(Object);
	
	AddObjectInstance(Position, newObjectIndex, tile.GetObjectsOnSquare()[newObjectIndex]);
    
	ATileManager* mgr = GetOwningTileManager();
	if (!mgr) return;
	
	mgr->InvalidateRoomAt(Position);

	ETileCategory cat = mgr->GetTileByID(Object.ID).Category;
    
	if (UTileLibrary::CountsAsWall(cat))
	{
		tile.SetWall(Object.Direction, true);
       
		FIntVector neighborGlobal = LocalToGlobalTileIndex(Position);
		ETileDirection oppDir = Object.Direction;

		if (Object.Direction == ETileDirection::NORTH) { neighborGlobal.Y += 1; oppDir = ETileDirection::SOUTH; }
		else if (Object.Direction == ETileDirection::SOUTH) { neighborGlobal.Y -= 1; oppDir = ETileDirection::NORTH; }
		else if (Object.Direction == ETileDirection::EAST)  { neighborGlobal.X += 1; oppDir = ETileDirection::WEST;  }
		else if (Object.Direction == ETileDirection::WEST)  { neighborGlobal.X -= 1; oppDir = ETileDirection::EAST;  }
       
		bool found = false;
		FSquareTile& NeighborTile = GetOrCreateSquareTile(neighborGlobal);
		if (found)
		{
			NeighborTile.SetWall(oppDir, true);
		}
	}
	else if (cat == ETileCategory::FLOOR)
	{
		FIntVector belowPos = Position - FIntVector(0, 0, 1);
		
		FSquareTile& belowTile = GetOrCreateSquareTile(belowPos);
		belowTile.SetHasCeiling(true);
	}
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

FIntVector ATileChunk::LocalToGlobalTileIndex(FIntVector LocalPosition)
{
	int x = (ChunkPosition.X * ChunkSize.X) + LocalPosition.X;
	int y = (ChunkPosition.Y * ChunkSize.Y) + LocalPosition.Y;
	int z = LocalPosition.Z;
    
	return FIntVector(x, y, z);
}

const FSquareTile& ATileChunk::GetSquareTile(FIntVector Position, bool& success)
{
	success = true;
	static FSquareTile fallback = FSquareTile();
	
	FSquareTile* Tile = Tiles.Find(Position);
	if (Tile)
	{
		return *Tile;
	}
	
	//tile is nullptr
	success = false;
	return fallback;
}

bool ATileChunk::HasSquare(FIntVector Position)
{
	FSquareTile* Tile = Tiles.Find(Position);
	return Tile != nullptr;
}

TStaticArray<float, ATileChunk::customDataFloats> ATileChunk::GetCustomDataArray(const FTileDefinition& tileDef, const FTileObject& tileObject)
{
	TStaticArray<float, customDataFloats> instanceData;
	
	instanceData[(int)ETileInstanceDataIndex::ALBEDO_TEX] = (float)tileDef.Albedo;
	instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = (float)tileDef.Metallic;
	instanceData[(int)ETileInstanceDataIndex::NORMAL_TEX] = (float)tileDef.Normal;
	instanceData[(int)ETileInstanceDataIndex::SPECULAR_TEX] = (float)tileDef.Specular;
	instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = tileDef.BaseMetallic;
	instanceData[(int)ETileInstanceDataIndex::BASE_ROUGHNESS] = tileDef.BaseRoughness;
	instanceData[(int)ETileInstanceDataIndex::OBJ_DIRECTION] = (float)tileObject.Direction;
	instanceData[(int)ETileInstanceDataIndex::SHOULD_CUT] = 0.0f; //should cut
	instanceData[(int)ETileInstanceDataIndex::FORCE_CUT] = 0.0f; //force cut
	
	return instanceData;
}
