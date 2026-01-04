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
    
    // 1. Clear old state
    for (auto& Pair : HISMMap)
    {
       Pair.Value->ClearInstances();
    }
    HISMReverseLookup.Empty();
    
    // 2. Iterate and Rebuild
    for (auto& [Position, Square] : Tiles)
    {
       TArray<FTileObject>& Objects = Square.GetObjectsOnSquare();
       
       for (int32 i = 0; i < Objects.Num(); ++i)
       {
          FTileObject& o = Objects[i];
          
          // Reset index initially
          o.RenderInstanceIndex = -1;

          const FTileDefinition& tile = mgr->GetTileByID(o.ID);
          
          // Skip if no mesh (logic-only objects)
          if (!tile.Mesh) continue;

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
             
             // Init Lookup Array
             HISMReverseLookup.Add(Key, TArray<FObjectReference>());
          }
          else
          {
             HISM = HISMMap[Key];
          }
          
          // Calculate Transform
          FVector InstanceLoc = FVector(
             Position.X * TileSize.X,
             Position.Y * TileSize.Y,
             Position.Z * TileSize.Z 
          );
          
          FRotator Rotation = FRotator(0.f, static_cast<float>(o.Direction) * 90.f, 0.f);
          FTransform InstanceTransform = FTransform(Rotation, InstanceLoc, FVector(1.0f));
          
          // Add Instance
          int32 instanceIndex = HISM->AddInstance(InstanceTransform, false);
          
          // Store ID in the object so we can find this instance later
          o.RenderInstanceIndex = instanceIndex;

          // Track in Reverse Lookup
          TArray<FObjectReference>& Lookup = HISMReverseLookup[Key];
          if (Lookup.Num() <= instanceIndex)
          {
              Lookup.SetNum(instanceIndex + 1);
          }
          Lookup[instanceIndex] = { Position, i };

          // Set Custom Data
          TArray<float> instanceData;
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

void ATileChunk::AddObjectInstance(const FIntVector& Position, int32 ObjectIndex, FTileObject& ObjectDef)
{
	static constexpr int customDataFloats = (int)ETileInstanceDataIndex::MAX;
	
    ATileManager* mgr = GetOwningTileManager();
    if (!mgr) return;

    const FTileDefinition& tile = mgr->GetTileByID(ObjectDef.ID);
    if (!tile.Mesh) return; // Logic object only

    FTileRenderKey Key { tile.Mesh, tile.ParentMaterial };
    
    // Ensure Component Exists
    if (!HISMMap.Contains(Key))
    {
        // If HISM doesn't exist, lazily Create it
        UHierarchicalInstancedStaticMeshComponent* HISM = NewObject<UHierarchicalInstancedStaticMeshComponent>(this);
        HISM->SetStaticMesh(tile.Mesh);
        HISM->SetMaterial(0, tile.ParentMaterial);
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
    TStaticArray<float, customDataFloats> instanceData;
	
    instanceData[(int)ETileInstanceDataIndex::ALBEDO_TEX] = (float)tile.Albedo;
    instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = (float)tile.Metallic;
    instanceData[(int)ETileInstanceDataIndex::NORMAL_TEX] = (float)tile.Normal;
    instanceData[(int)ETileInstanceDataIndex::SPECULAR_TEX] = (float)tile.Specular;
    instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = tile.BaseMetallic;
    instanceData[(int)ETileInstanceDataIndex::BASE_ROUGHNESS] = tile.BaseRoughness;
    instanceData[(int)ETileInstanceDataIndex::OBJ_DIRECTION] = (float)ObjectDef.Direction;
    instanceData[(int)ETileInstanceDataIndex::SHOULD_CUT] = 0.0f; //should cut
    instanceData[(int)ETileInstanceDataIndex::FORCE_CUT] = 0.0f; //force cut
	
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
    
	// BuildChunk();
	return AddedTile;
}
void ATileChunk::AddObject(FIntVector Position, const FTileObject& Object)
{
	FSquareTile& tile = GetOrCreateSquareTile(Position);
	int32 newObjectIndex = tile.GetObjectsOnSquare().Add(Object);
	
	AddObjectInstance(Position, newObjectIndex, tile.GetObjectsOnSquare()[newObjectIndex]);
    
	ATileManager* mgr = GetOwningTileManager();
	if (!mgr) return;

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