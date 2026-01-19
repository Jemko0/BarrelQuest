#include "Tiles/TileChunk.h"

#include "BarrelUtilityFunctionLibrary.h"
#include "Tiles/TileManager.h"
#include "BarrelUtilityLibrary.h"
#include "Features/Interfaces/TileFeatureInterface.h"
#include "Net/UnrealNetwork.h"

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
		FTileEntry Entry = FTileEntry();
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

///Builds the chunk using the tile data and creates HISM + Instances
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
				UHierarchicalInstancedStaticMeshComponent* HISM = LazyCreateHISM(Key, TileDef);
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
        	FVector scale = FVector(1.0f, ObjectDef.Mirrored? -1.0f : 1.0f, 1.0f);
            FTransform InstanceTransform(Rotation, InstanceLoc, scale);

            // Add instance
            int32 InstanceIndex = HISM->AddInstance(InstanceTransform, false);
            ObjectDef.RenderInstanceIndex = InstanceIndex;

            // Ensure Lookup array is large enough
            if (Lookup.Num() <= InstanceIndex)
            {
                Lookup.SetNum(InstanceIndex + 1);
            }
            Lookup[InstanceIndex] = { Position, i };
        	
            TStaticArray<float, customDataFloats> InstanceData = GetCustomDataArray(TileDef, ObjectDef, Square);
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

///Adds an object instance, does NOT add object data! Only adds an instance to the corresponding HISM 
///(or creates a new HISM if it has to)
void ATileChunk::AddObjectInstance(const FIntVector& Position, int32 ObjectIndex, FTileObject& ObjectDef)
{
    ATileManager* mgr = GetOwningTileManager();
    if (!mgr) return;
	
	bool found;
	FSquareTile* square = GetSquareTilePtr(Position, found);
	
	if (!found)
	{
		return;
	}

    const FTileDefinition& TileDef = mgr->GetTileByID(ObjectDef.ID);
    if (!TileDef.Mesh) return; // Logic object only

    FTileRenderKey Key { TileDef.Mesh, TileDef.ParentMaterial };
    
    // Ensure Component Exists
    if (!HISMMap.Contains(Key))
    {
        // If HISM doesn't exist, lazily Create it
        UHierarchicalInstancedStaticMeshComponent* HISM = LazyCreateHISM(Key, TileDef);
    }

    UHierarchicalInstancedStaticMeshComponent* HISM = HISMMap[Key];

    // Math
    FVector InstanceLoc = FVector(
          Position.X * TileSize.X,
          Position.Y * TileSize.Y,
          Position.Z * TileSize.Z 
    );
    FRotator Rotation = FRotator(0.f, static_cast<float>(ObjectDef.Direction) * 90.f, 0.f);
	
	FVector scale = FVector(1.0f, ObjectDef.Mirrored? -1.0f : 1.0f, 1.0f);
    FTransform InstanceTransform = FTransform(Rotation, InstanceLoc, scale);

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
    TStaticArray<float, customDataFloats> instanceData = GetCustomDataArray(TileDef, ObjectDef, *square);
    HISM->SetCustomData(NewIndex, instanceData, true); // true = Mark Dirty Now
}

///Removes an object instance, does NOT remove its data, only the visual instance that lives in the HISM
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

///Tries to get a tile, if not found will create one and return a mutable reference to it
FSquareTile& ATileChunk::GetOrCreateSquareTile(FIntVector Position)
{
	FSquareTile* Tile = Tiles.Find(Position);
	if (Tile)
	{
		return *Tile;
	}
	
	//tile is nullptr
	FSquareTile& newTile = AddSquare(Position, FSquareTile(Position));
	
	return newTile;
}

///Adds a square, will automatically add the objects as well.
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

void ATileChunk::SetSquare(FIntVector Position, const FSquareTile& squareTile)
{
	Tiles.Add(Position, squareTile);
}

///Adds a new object at the positions square, adds data and instance visual. Use this to create new tiles
void ATileChunk::AddObject(FIntVector Position, const FTileObject& Object)
{
	FSquareTile& tile = GetOrCreateSquareTile(Position);
	int32 newObjectIndex = tile.GetObjectsOnSquare().Add(Object);
	
	AddObjectInstance(Position, newObjectIndex, tile.GetObjectsOnSquare()[newObjectIndex]);
	AddObjectFeatures(Position, tile.GetObjectsOnSquare()[newObjectIndex], newObjectIndex);
    
	ATileManager* mgr = GetOwningTileManager();
	if (!mgr) return;
	
	mgr->InvalidateRoomAt(Position);

	ETileCategory cat = mgr->GetTileByID(Object.ID).Category;
    
	if (UTileLibrary::CountsAsWall(cat))
	{
		tile.SetWall(Object.Direction, true);
       
		FIntVector neighborGlobal = LocalToGlobalTileIndex(Position);
		ETileDirection oppDir = Object.Direction;

		if (Object.Direction == ETileDirection::NORTH) { neighborGlobal.X += 1; oppDir = ETileDirection::SOUTH; }
		else if (Object.Direction == ETileDirection::SOUTH) { neighborGlobal.X -= 1; oppDir = ETileDirection::NORTH; }
		else if (Object.Direction == ETileDirection::EAST)  { neighborGlobal.Y += 1; oppDir = ETileDirection::WEST;  }
		else if (Object.Direction == ETileDirection::WEST)  { neighborGlobal.Y -= 1; oppDir = ETileDirection::EAST;  }
		
		FSquareTile& NeighborTile = GetOrCreateSquareTile(neighborGlobal);
		NeighborTile.SetWall(oppDir, true);
	}
	else if (cat == ETileCategory::FLOOR)
	{
		FIntVector belowPos = Position - FIntVector(0, 0, 1);
		
		FSquareTile& belowTile = GetOrCreateSquareTile(belowPos);
		belowTile.SetHasCeiling(true);
		belowTile.SetInsideSquare(true);
	}
}

///Removes an object instance and its underlying data representation. Use this to remove objects when modifying
///tiles.
void ATileChunk::RemoveObject(FIntVector Position, const FTileObject& Object)
{
	bool found = false;
    FSquareTile* tile = GetSquareTilePtr(Position, found);
    
    if (!found) return;

    RemoveObjectInstance(Object);
	//RemoveObjectFeatures(Position, ?);

    ATileManager* mgr = GetOwningTileManager();
    if (mgr)
    {
        mgr->InvalidateRoomAt(Position);
        const FTileDefinition& TileDef = mgr->GetTileByID(Object.ID);
        
        if (UTileLibrary::CountsAsWall(TileDef.Category))
        {
            tile->SetWall(Object.Direction, false);
           
            FIntVector neighborPos = Position;
        	ETileDirection oppDir = Object.Direction;
        	
            if (Object.Direction == ETileDirection::NORTH) { neighborPos.X += 1; oppDir = ETileDirection::SOUTH; }
            else if (Object.Direction == ETileDirection::SOUTH) { neighborPos.X -= 1; oppDir = ETileDirection::NORTH; }
            else if (Object.Direction == ETileDirection::EAST)  { neighborPos.Y += 1; oppDir = ETileDirection::WEST;  }
            else if (Object.Direction == ETileDirection::WEST)  { neighborPos.Y -= 1; oppDir = ETileDirection::EAST;  }
        	
            FSquareTile& NeighborTile = GetOrCreateSquareTile(neighborPos);
		    NeighborTile.SetWall(oppDir, false);
        }
        else if (TileDef.Category == ETileCategory::FLOOR)
        {
            FIntVector belowPos = Position - FIntVector(0, 0, 1);
            FSquareTile& belowTile = GetOrCreateSquareTile(belowPos);
		    belowTile.SetHasCeiling(false);
        	belowTile.SetInsideSquare(false);
        }
    }
	
    TArray<FTileObject>& Objs = tile->GetObjectsOnSquare();
    for (int32 i = 0; i < Objs.Num(); i++)
    {
        if (Objs[i].RenderInstanceIndex == Object.RenderInstanceIndex && Objs[i].ID == Object.ID)
        {
        	RemoveObjectFeatures(Position, i);
        	tile->RemoveObjectByIndex(i);
            
        	//fix the shifting indices
        	for (int32 j = i; j < Objs.Num(); j++)
        	{
        		const FTileDefinition& Def = mgr->GetTileByID(Objs[j].ID);
        		FTileRenderKey Key { Def.Mesh, Def.ParentMaterial };
            
        		if (HISMReverseLookup.Contains(Key))
        		{
        			int32 RenderIdx = Objs[j].RenderInstanceIndex;
        			if (HISMReverseLookup[Key].IsValidIndex(RenderIdx))
        			{
        				HISMReverseLookup[Key][RenderIdx].ObjectArrayIndex = j;
        			}
        		}
        	}
        	break;
        }
    }
}

void ATileChunk::AddObjectFeatures(FIntVector Position, FTileObject& Object, int32 NewObjectIndex)
{
	FVector TileWorldOffset = UTileLibrary::TileToWorldPosition(Position);
	UE_LOG(LogBarrelQuest, Warning, TEXT("Adding Object features at: %s"), *TileWorldOffset.ToString());
	
	for (const FTileObjectFeature& Feature : Object.Features)
	{
		if (!Feature.FeatureClass) continue;

		USceneComponent* Component = NewObject<USceneComponent>(this, Feature.FeatureClass);

		Component->AttachToComponent(
			RootComponent,
			FAttachmentTransformRules::KeepRelativeTransform
		);
		
		FTransform FeatureTransform = Feature.RelativeTransform;
		FeatureTransform.AddToTranslation(TileWorldOffset);

		Component->SetRelativeTransform(FeatureTransform);
		Component->RegisterComponent();
		
		UE_LOG(LogBarrelQuest, Warning, TEXT("component: %s"), *Component->GetName());
		
		if (auto* FeatureComp = Cast<ITileFeatureInterface>(Component))
		{
			FeatureComp->SetOwningTileIndex(Position, NewObjectIndex);
			FeatureComp->SetTileManager(GetOwningTileManager());
			FeatureComp->BindRuntimeData(Object.runtimeData);
		}
		
		FStoredFeature stored = FStoredFeature();
		
		stored.ComponentPtr = Component;
		stored.FeatureName = Feature.FeatureName;
		stored.OwningSquare = Position;
		stored.OwningObject = NewObjectIndex;
		
		StoreNewFeature(stored);
	}
}

void ATileChunk::RemoveObjectFeatures(FIntVector Position, int32 TargetObjectIndex)
{
	FStoredFeatureArray* arr = AttachedFeatures.Find(Position);
	if (!arr) return;

	bool s;
	FSquareTile* Square = GetSquareTilePtr(Position, s); 
	if (!Square || !Square->GetObjectsOnSquare().IsValidIndex(TargetObjectIndex)) return;
    
	FTileObject& Obj = Square->GetObjectsOnSquare()[TargetObjectIndex];
	
	arr->features.RemoveAll([&](FStoredFeature& Feature)
	{
		if (Feature.OwningObject == TargetObjectIndex)
		{
			if (Feature.ComponentPtr && !Feature.ComponentPtr->IsBeingDestroyed())
			{
				if (auto* Interface = Cast<ITileFeatureInterface>(Feature.ComponentPtr))
				{
					Interface->UnbindFromData(Obj.runtimeData);
				}
                
				Feature.ComponentPtr->DestroyComponent();
			}
			return true;
		}
		return false;
	});
}

void ATileChunk::StoreNewFeature(const FStoredFeature& feature)
{
	FStoredFeatureArray arr = AttachedFeatures.FindOrAdd(feature.OwningSquare);
	
	arr.features.Add(feature);
}

///Returns a mutable array reference of the objects living on the positions square
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

///Converts a local tile coordinate into a global tile
FIntVector ATileChunk::LocalToGlobalTileIndex(FIntVector LocalPosition)
{
	int x = (ChunkPosition.X * ChunkSize.X) + LocalPosition.X;
	int y = (ChunkPosition.Y * ChunkSize.Y) + LocalPosition.Y;
	int z = LocalPosition.Z;
    
	return FIntVector(x, y, z);
}

///Gets a immutable reference to the square at the position
const FSquareTile& ATileChunk::GetSquareTile(FIntVector Position, bool& success)
{
	success = true;
	static FSquareTile fallback = FSquareTile(FIntVector(0,0,0));
	
	FSquareTile* Tile = Tiles.Find(Position);
	if (Tile)
	{
		return *Tile;
	}
	
	//tile is nullptr
	success = false;
	return fallback;
}

///Gets a pointer to the square at the position. Cannot be called from blueprint
FSquareTile* ATileChunk::GetSquareTilePtr(FIntVector Position, bool& success)
{
	FSquareTile* ptr = Tiles.Find(Position);
	success = ptr != nullptr;
	return ptr;
}

void ATileChunk::RemoveSquareAt(FIntVector Position)
{
	bool success;
	FSquareTile* square = GetSquareTilePtr(Position, success);
    
	if (!success || !square)
	{
		return;
	}
    
	TArray<FTileObject>& objects = square->GetObjectsOnSquare();
	
	for (int32 i = objects.Num() - 1; i >= 0; --i)
	{
		RemoveObject(Position, objects[i]);
	}
	
	Tiles.Remove(Position);
}

//Returns true if a square exists at the tile position
bool ATileChunk::HasSquare(FIntVector Position)
{
	FSquareTile* Tile = Tiles.Find(Position);
	return Tile != nullptr;
}


TStaticArray<float, ATileChunk::customDataFloats> ATileChunk::GetCustomDataArray(const FTileDefinition& tileDef, const FTileObject& tileObject, const FSquareTile& tileSquare)
{
	TStaticArray<float, customDataFloats> instanceData;
	
	instanceData[(int)ETileInstanceDataIndex::ALBEDO_TEX] = (float)tileDef.Albedo;
	instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = (float)tileDef.Metallic;
	instanceData[(int)ETileInstanceDataIndex::NORMAL_TEX] = (float)tileDef.Normal;
	instanceData[(int)ETileInstanceDataIndex::SPECULAR_TEX] = (float)tileDef.Specular;
	instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = tileDef.BaseMetallic;
	instanceData[(int)ETileInstanceDataIndex::BASE_ROUGHNESS] = tileDef.BaseRoughness;
	instanceData[(int)ETileInstanceDataIndex::OBJ_DIRECTION] = (float)tileObject.Direction;
	instanceData[(int)ETileInstanceDataIndex::SHOULD_CUT] = 0.0f;
	instanceData[(int)ETileInstanceDataIndex::FORCE_CUT] = 0.0f;
	
	instanceData[(int)ETileInstanceDataIndex::TINT_R] = tileDef.tint.R;
	instanceData[(int)ETileInstanceDataIndex::TINT_G] = tileDef.tint.G;
	instanceData[(int)ETileInstanceDataIndex::TINT_B] = tileDef.tint.B;
	instanceData[(int)ETileInstanceDataIndex::HUE_SHIFT] = 0.0f;
	instanceData[(int)ETileInstanceDataIndex::DARKENED] = 0.0f;
	instanceData[(int)ETileInstanceDataIndex::MIRRORED] = tileObject.Mirrored ? 1.0f : 0.0f;
	
	return instanceData;
}

UHierarchicalInstancedStaticMeshComponent* ATileChunk::LazyCreateHISM(const FTileRenderKey& key, const FTileDefinition& tileDef)
{
	UHierarchicalInstancedStaticMeshComponent* HISM = NewObject<UHierarchicalInstancedStaticMeshComponent>(this);
	HISM->SetStaticMesh(tileDef.Mesh);
	HISM->SetMaterial(0, tileDef.ParentMaterial);
	HISM->SetNumCustomDataFloats(customDataFloats);
	HISM->RuntimeVirtualTextures = RVTOutputs;
	HISM->RegisterComponent();
	HISMMap.Add(key, HISM);
	HISMReverseLookup.Add(key, TArray<FObjectReference>());
	
	return HISM;
}
