#include "Tiles/TileChunk.h"

#include "BarrelUtilityFunctionLibrary.h"
#include "Tiles/TileManager.h"
#include "BarrelUtilityLibrary.h"
#include "Features/Interfaces/TileFeatureInterface.h"
#include "Kismet/KismetSystemLibrary.h"
#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "Materials/MaterialInstanceDynamic.h"
#include "Net/UnrealNetwork.h"

namespace
{
	bool IsTileAssetHandleSet(const FTileSavedAssetHandle& Handle)
	{
		return Handle.Kind != ERegisteredAssetType::None || !Handle.Id.IsEmpty() || Handle.AssetPath.IsValid() || !Handle.Url.IsEmpty();
	}

	const TCHAR* TileTextureKindToStringForChunkLog(ERegisteredAssetType Kind)
	{
		switch (Kind)
		{
		case ERegisteredAssetType::CookedAsset:
			return TEXT("CookedAsset");
		case ERegisteredAssetType::RuntimeTexture:
			return TEXT("RuntimeTexture");
		case ERegisteredAssetType::RuntimeMesh:
			return TEXT("RuntimeMesh");
		default:
			return TEXT("None");
		}
	}

	FString DescribeTileTextureHandleForLog(const FTileSavedAssetHandle& Handle)
	{
		return FString::Printf(
			TEXT("Id='%s' Kind=%s AssetPath='%s' Url='%s'"),
			*Handle.Id,
			TileTextureKindToStringForChunkLog(Handle.Kind),
			*Handle.AssetPath.ToString(),
			*Handle.Url);
	}
}

ATileChunk::ATileChunk()
{
	TileSize = UTileLibrary::GetTileSize();
	InitializeFuncMap();
	
	SetReplicateMovement(false);
	bReplicates = true;
	bAlwaysRelevant = true;
	
	/*USceneComponent* Root = CreateDefaultSubobject<USceneComponent>(TEXT("Root"));
	RootComponent = Root;*/
}

TArray<FRCMOption> ATileChunk::GetRCMOptions_Implementation(FVector Location)
{
	TArray<FRCMOption> RCMOptions;
	
	FIntVector squarePos = UTileLibrary::WorldToTilePosition(Location);
	bool found;
	FSquareTile* squarePtr = GetSquareTilePtr(squarePos, found);
	
	if (!squarePtr)
	{
		return RCMOptions;
	}
	
	const TArray<FTileObject>& objectsOnSquare = squarePtr->GetReadOnlyObjects();
	
	for (const FTileObject& Object : objectsOnSquare)
	{
		FTileDefinition def = GetOwningTileManager()->GetTileByID(this, Object.ID);
		RCMOptions.Append(def.DefaultRightClickOptions);
	}
	
	return RCMOptions;
}

void ATileChunk::SendRCMInvoke_Implementation(const FString& invokeID, TMap<FName, FRCMInvokeMessage>& payload)
{
	UE_LOG(LogBarrelQuestTileChunk, Log, TEXT("chunk received message, invoke ID: %s"), *invokeID);
	IRightClickInterface::SendRCMInvoke_Implementation(invokeID, payload);
}

TArray<FIntVector> ATileChunk::GetTileInteractionPoints_Implementation(FVector FromWorld, float Range)
{
	FIntVector Center = UTileLibrary::WorldToTilePosition(FromWorld);
	TArray<FIntVector> Result;

	int32 TileRange = FMath::FloorToInt(Range / 100.0f);

	for (int32 X = -TileRange; X <= TileRange; X++)
	{
		for (int32 Y = -TileRange; Y <= TileRange; Y++)
		{
			if (FMath::Square(X) + FMath::Square(Y) > FMath::Square(TileRange))
				continue;

			FIntVector TileKey = FIntVector(Center.X + X, Center.Y + Y, Center.Z);

			FStoredFeatureArray* Features = AttachedFeatures.Find(TileKey);
			
			if (!Features)
				continue;

			bool bHasInteractable = false;
			for (FStoredFeature& Feature : Features->features)
			{
				if (Cast<IInteractableInterface>(Feature.ComponentPtr))
				{
					bHasInteractable = true;
					break;
				}
			}

			if (bHasInteractable)
				Result.Add(TileKey);
		}
	}

	return Result;
}

void ATileChunk::OnRep_TileKeys()
{
	Tiles.RebuildIndex();
}

FIntVector ATileChunk::ChunkSize = FIntVector(96, 96, 7);

void ATileChunk::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const
{
	Super::GetLifetimeReplicatedProps(OutLifetimeProps);
	DOREPLIFETIME(ATileChunk, ChunkPosition);
	DOREPLIFETIME(ATileChunk, TileKeys);
	DOREPLIFETIME(ATileChunk, TileValues);
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
	
	int builtInstances = 0;

    // Clear existing HISM components
    for (auto& Pair : HISMMap)
    {
        if (Pair.Value)
        {
            Pair.Value->ClearInstances();
			Pair.Value->DestroyComponent();
        }
    }
    HISMMap.Empty();
    HISMReverseLookup.Empty();
	
	bool isServer = false;
	
	UWorld* world = GetWorld();
	if (world)
	{
		UNetDriver* netDriver = world->GetNetDriver();
		if (netDriver)
		{
			isServer = netDriver->IsServer();
		}
	}
	
	UE_LOG(LogBarrelQuest, Warning, TEXT("BuildChunk called on [%s], Tiles count: %d"), isServer? L"SERVER" : L"CLIENT", Tiles.Num());
	
    // Iterate all tiles in this chunk
    for (auto TilePair : Tiles)
    {
        const FIntVector& Position = TilePair.Key;
        FSquareTile& Square = TilePair.Value;

        TArray<FTileObject>& Objects = Square.GetObjectsOnSquare();
        for (int32 i = 0; i < Objects.Num(); i++)
        {
            FTileObject& ObjectDef = Objects[i];
            const FTileDefinition& TileDef = mgr->GetTileByID(this, ObjectDef.ID);
			UStaticMesh* ResolvedMesh = ResolveMeshForTileDefinition(TileDef);

            // Skip logic-only objects (no mesh)
            if (!ResolvedMesh)
            {
                ObjectDef.RenderInstanceIndex = -1;
                continue;
            }

            // Build key for HISM map
            FTileRenderKey Key { ResolvedMesh, TileDef.ParentMaterial };

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
        	
        	
        	UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr;
            TStaticArray<float, customDataFloats> InstanceData = GetCustomDataArray(TileDef, ObjectDef, Square, TileTextureRegistry);
            HISM->SetCustomData(InstanceIndex, InstanceData, false);
        	
        	ApplyAllDataForObject(TilePair.Key, i, ObjectDef);
        	builtInstances++;
        }
    }
	
	for (auto& HISM : HISMMap)
	{
		HISM.Value->BuildTreeIfOutdated(true, false);  // Rebuild the HISM tree
		HISM.Value->MarkRenderStateDirty();
	}
	
	UE_LOG(LogBarrelQuest, Warning, TEXT("Built Chunk: Tiles In Mem: %i"), Tiles.Num());
	UE_LOG(LogBarrelQuest, Warning, TEXT("Built Chunk: Instances: %i"), builtInstances);
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

    const FTileDefinition& TileDef = mgr->GetTileByID(this, ObjectDef.ID);
	UStaticMesh* ResolvedMesh = ResolveMeshForTileDefinition(TileDef);
    if (!ResolvedMesh) return; // Logic object only

    FTileRenderKey Key { ResolvedMesh, TileDef.ParentMaterial };
    
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
	UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr;
    TStaticArray<float, customDataFloats> instanceData = GetCustomDataArray(TileDef, ObjectDef, *square, TileTextureRegistry);
    HISM->SetCustomData(NewIndex, instanceData, true); // true = Mark Dirty Now
}

///Removes an object instance, does NOT remove its data, only the visual instance that lives in the HISM
void ATileChunk::RemoveObjectInstance(const FTileObject& ObjectDef)
{
    // If it was never rendered (e.g. logic block), ignore
    if (ObjectDef.RenderInstanceIndex == -1) return;

    ATileManager* mgr = GetOwningTileManager();
    if (!mgr) return;

    const FTileDefinition& tile = mgr->GetTileByID(this, ObjectDef.ID);
	UStaticMesh* ResolvedMesh = ResolveMeshForTileDefinition(tile);
    FTileRenderKey Key { ResolvedMesh, tile.ParentMaterial };

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
    	if (!Lookup.IsValidIndex(LastIndex))
    	{
    		UE_LOG(LogBarrelQuest, Error, TEXT("ATileChunk::RemoveObjectInstance() >> LastIndex is invalid!"))
    		return;
    	}
    	
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

    //shrink Lookup
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

void ATileChunk::SetTiles(const TArray<FIntVector>& tilePositions, const TArray<FSquareTile>& tileSquares)
{
	if (tilePositions.Num() != tileSquares.Num())
	{
		UE_LOG(LogBarrelQuest, Error, TEXT("ATileChunk::SetTiles: Position/value count mismatch. Positions=%d Squares=%d"),
			tilePositions.Num(),
			tileSquares.Num());
		return;
	}

	ResetChunkState();

	TileKeys.Reserve(tilePositions.Num());
	TileValues.Reserve(tileSquares.Num());
	TileKeys.Append(tilePositions);
	TileValues.Append(tileSquares);
	Tiles.RebuildIndex();

	BuildChunk();

	for (auto TilePair : Tiles)
	{
		FSquareTile& Square = TilePair.Value;
		TArray<FTileObject>& Objects = Square.GetObjectsOnSquare();
		for (int32 ObjectIndex = 0; ObjectIndex < Objects.Num(); ++ObjectIndex)
		{
			AddObjectFeatures(TilePair.Key, Objects[ObjectIndex], ObjectIndex);
		}
	}
}

///Adds a square, will automatically add the objects as well.
FSquareTile& ATileChunk::AddSquare(FIntVector Position, const FSquareTile& newSquare)
{
	FSquareTile& AddedTile = Tiles.Add(Position, newSquare);
	
	TArray<FTileObject>& Objects = AddedTile.GetObjectsOnSquare();
	
	for(int32 i = 0; i < Objects.Num(); i++)
	{
		AddObjectInstance(Position, i, Objects[i]);
		AddObjectFeatures(Position, Objects[i], i);
		ApplyAllDataForObject(Position, i, Objects[i]);
	}
	
	return AddedTile;
}

void ATileChunk::ApplyAllDataForObject(FIntVector position, int32 objectIndex, FTileObject& objectRef)
{
	for (auto& runtimeKey : objectRef.runtimeData.Keys())
	{
		FRuntimeDataQueryResult query = objectRef.runtimeData.GetValue(runtimeKey);
		FString& runtimeValue = query.data;
		
		OnTileObjectDataChanged(position, objectIndex, runtimeKey, runtimeValue);
	}
}

void ATileChunk::SetObjectRuntimeData(FIntVector Position, int32 objectIndex, FName Key, const FString& Value)
{
	bool found;
	FSquareTile* squarePtr = GetSquareTilePtr(Position, found);
	
	if (!found)
	{
		UE_LOG(LogBarrelQuest, Error, TEXT("SetObjectRuntimeData: square not found"));
		return;
	}
	
	if (!squarePtr->GetObjectsOnSquare().IsValidIndex(objectIndex)) return;
	
	squarePtr->GetObjectsOnSquare()[objectIndex].runtimeData.SetValue(Key, Value);
	OnTileObjectDataChanged(Position, objectIndex, Key, Value);
}

void ATileChunk::SetSquare(FIntVector Position, const FSquareTile& squareTile)
{
	Tiles.Add(Position, squareTile);
}

///Adds a new object at the positions square, adds data and instance visual. Use this to create new tiles
void ATileChunk::AddObject(FIntVector Position, FTileObject& Object)
{
	FSquareTile& tile = GetOrCreateSquareTile(Position);
	int32 newObjectIndex = tile.GetObjectsOnSquare().Add(Object);
	
	AddObjectInstance(Position, newObjectIndex, tile.GetObjectsOnSquare()[newObjectIndex]);
	AddObjectFeatures(Position, tile.GetObjectsOnSquare()[newObjectIndex], newObjectIndex);
	ApplyAllDataForObject(Position, newObjectIndex, Object);
    
	ATileManager* mgr = GetOwningTileManager();
	if (!mgr) return;
	
	mgr->InvalidateRoomAt(Position);

	ETileCategory cat = mgr->GetTileByID(this, Object.ID).Category;
    
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

    ATileManager* mgr = GetOwningTileManager();
    if (mgr)
    {
        mgr->InvalidateRoomAt(Position);
        const FTileDefinition& TileDef = mgr->GetTileByID(this, Object.ID);
        
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
        	UnbindRuntimeData(Position, i);
        	tile->RemoveObjectByIndex(i);
            
        	//fix the shifting indices
        	for (int32 j = i; j < Objs.Num(); j++)
        	{
        		const FTileDefinition& Def = mgr->GetTileByID(this, Objs[j].ID);
				UStaticMesh* ResolvedMesh = ResolveMeshForTileDefinition(Def);
        		FTileRenderKey Key { ResolvedMesh, Def.ParentMaterial };
            
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
	
	for (const FTileObjectFeature& Feature : Object.Features)
	{
		if (!Feature.FeatureClass) continue;

		USceneComponent* Component = NewObject<USceneComponent>(
		   this, 
		   Feature.FeatureClass,
		   NAME_None,
		   RF_Transactional
	   );

		Component->AttachToComponent(
			RootComponent,
			FAttachmentTransformRules::KeepRelativeTransform
		);
		
		FTransform FeatureTransform = Feature.RelativeTransform;
		FeatureTransform.AddToTranslation(TileWorldOffset);

		Component->SetRelativeTransform(FeatureTransform);
		Component->RegisterComponent();
		
		if (auto* FeatureComp = Cast<ITileFeatureInterface>(Component))
		{
			FeatureComp->SetOwningTileIndex(Position, NewObjectIndex);
			FeatureComp->SetTileManager(GetOwningTileManager());
			FeatureComp->BindRuntimeData(Object.runtimeData);
			FeatureComp->InitializeFromObject(Object);
		}
		else
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("ATileChunk::AddObjectFeatures: Feature component does not implement TileFeatureInterface. Component='%s'"),
				*Component->GetName());
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
	
	//UE_LOG(LogBarrelQuest, Warning, TEXT("Removing features for object %d"), TargetObjectIndex);
	
	for (int32 i = arr->features.Num() - 1; i >= 0; i--)
	{
		auto& feature = arr->features[i];
        
		if (feature.OwningObject != TargetObjectIndex) continue;
		if (!feature.ComponentPtr) continue;
       
		if (auto* Interface = Cast<ITileFeatureInterface>(feature.ComponentPtr))
		{
			Interface->UnbindFromData(Obj.runtimeData);
			Interface->ResetOwners();
		}
		else
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("invalid interface"));
		}
        
		feature.ComponentPtr->DestroyComponent();
		arr->features.RemoveAt(i);
	}
}

void ATileChunk::StoreNewFeature(const FStoredFeature& feature)
{
	FStoredFeatureArray& arr = AttachedFeatures.FindOrAdd(feature.OwningSquare);
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

void ATileChunk::ReportError(FString msg)
{
	FString Message = FString::Printf(TEXT("Chunk ERROR: %s"), *msg);
	UE_LOG(LogBarrelQuestTileChunk, Error, TEXT("%s"), *Message);
	
	//OnChunkError.Broadcast(Message);
	
	ATileManager* mgr = GetOwningTileManager();
	if (!mgr) return;
	
	mgr->AddError(this, Message);
}

//Returns true if a square exists at the tile position
bool ATileChunk::HasSquare(FIntVector Position)
{
	FSquareTile* Tile = Tiles.Find(Position);
	return Tile != nullptr;
}

FStoredFeatureArray ATileChunk::FindAllFeaturesForObject(FIntVector squareIdx, int32 objIdx)
{
	FStoredFeatureArray results;
	FStoredFeatureArray* featureArray = AttachedFeatures.Find(squareIdx);
	
	if (!featureArray)
	{
		return FStoredFeatureArray();
	}
	
	for (FStoredFeature feature : featureArray->features)
	{
		if (feature.OwningObject != objIdx)
		{
			continue;
		}
		
		results.features.Add(feature);
	}
	
	return results;
}

void ATileChunk::ResetChunkState()
{
	for (auto pair : Tiles)
	{
		FSquareTile& square = pair.Value;
		TArray<FTileObject>& objects = square.GetObjectsOnSquare();
		for (int i = 0; i < objects.Num(); i++)
		{
			RemoveObjectFeatures(pair.Key, i);
			UnbindRuntimeData(pair.Key, i);
		}
	}
	
	for (auto& pair : HISMMap)
	{
		if (pair.Value)
		{
			pair.Value->ClearInstances();
			pair.Value->DestroyComponent();
		}
	}
	
	Tiles.Empty();
	HISMMap.Empty();
	HISMReverseLookup.Empty();
}

int64 ATileChunk::GetEstimatedMemoryUsageBytes() const
{
	int64 TotalBytes = sizeof(*this);

	TotalBytes += TileKeys.GetAllocatedSize();
	TotalBytes += TileValues.GetAllocatedSize();
	TotalBytes += Tiles.LookupIndex.GetAllocatedSize();
	TotalBytes += HISMMap.GetAllocatedSize();
	TotalBytes += HISMReverseLookup.GetAllocatedSize();
	TotalBytes += AttachedFeatures.GetAllocatedSize();
	TotalBytes += perSquareHandles.GetAllocatedSize();
	TotalBytes += RVTOutputs.GetAllocatedSize();

	for (const FSquareTile& Square : TileValues)
	{
		const TArray<FTileObject>& Objects = Square.GetReadOnlyObjects();
		TotalBytes += Objects.GetAllocatedSize();

		for (const FTileObject& Object : Objects)
		{
			TotalBytes += Object.Features.GetAllocatedSize();

			const TArray<FString>& RuntimeValues = Object.runtimeData.Values();
			TotalBytes += RuntimeValues.GetAllocatedSize();
			for (const FString& RuntimeValue : RuntimeValues)
			{
				TotalBytes += RuntimeValue.GetAllocatedSize();
			}
		}
	}

	for (const TPair<FTileRenderKey, TArray<FObjectReference>>& Pair : HISMReverseLookup)
	{
		TotalBytes += Pair.Value.GetAllocatedSize();
	}

	for (const TPair<FIntVector, FStoredFeatureArray>& Pair : AttachedFeatures)
	{
		TotalBytes += Pair.Value.features.GetAllocatedSize();
	}

	for (const TPair<FIntVector, TArray<FRuntimeListenerObject>>& Pair : perSquareHandles)
	{
		TotalBytes += Pair.Value.GetAllocatedSize();
	}

	for (const TPair<FTileRenderKey, UHierarchicalInstancedStaticMeshComponent*>& Pair : HISMMap)
	{
		const UHierarchicalInstancedStaticMeshComponent* HISM = Pair.Value;
		if (!HISM)
		{
			continue;
		}

		const int64 InstanceCount = HISM->GetInstanceCount();
		TotalBytes += sizeof(UHierarchicalInstancedStaticMeshComponent);
		TotalBytes += InstanceCount * sizeof(FTransform);
		TotalBytes += InstanceCount * customDataFloats * sizeof(float);
	}

	return TotalBytes;
}


TStaticArray<float, ATileChunk::customDataFloats> ATileChunk::GetCustomDataArray(const FTileDefinition& tileDef, const FTileObject& tileObject, const FSquareTile& tileSquare, UTileTextureRegistry* TileTextureRegistry)
{
	TStaticArray<float, customDataFloats> instanceData;
	for (int32 Index = 0; Index < customDataFloats; ++Index)
	{
		instanceData[Index] = 0.0f;
	}
	
	instanceData[(int)ETileInstanceDataIndex::ALBEDO_TEX] = (float)tileDef.TextureProperties.Albedo;
	instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = (float)tileDef.TextureProperties.Metallic;
	instanceData[(int)ETileInstanceDataIndex::NORMAL_TEX] = (float)tileDef.TextureProperties.Normal;
	instanceData[(int)ETileInstanceDataIndex::SPECULAR_TEX] = (float)tileDef.TextureProperties.Specular;
	instanceData[(int)ETileInstanceDataIndex::BASE_METALLIC] = tileDef.TextureProperties.BaseMetallic;
	instanceData[(int)ETileInstanceDataIndex::BASE_ROUGHNESS] = tileDef.TextureProperties.BaseRoughness;
	instanceData[(int)ETileInstanceDataIndex::OBJ_DIRECTION] = (float)tileObject.Direction;
	instanceData[(int)ETileInstanceDataIndex::SHOULD_CUT] = 0.0f;
	instanceData[(int)ETileInstanceDataIndex::FORCE_CUT] = 0.0f;
	
	instanceData[(int)ETileInstanceDataIndex::TINT_R] = tileDef.tint.R;
	instanceData[(int)ETileInstanceDataIndex::TINT_G] = tileDef.tint.G;
	instanceData[(int)ETileInstanceDataIndex::TINT_B] = tileDef.tint.B;
	instanceData[(int)ETileInstanceDataIndex::HUE_SHIFT] = 0.0f;
	instanceData[(int)ETileInstanceDataIndex::DARKENED] = 0.0f;
	instanceData[(int)ETileInstanceDataIndex::MIRRORED] = tileObject.Mirrored ? 1.0f : 0.0f;
	
	//interior walls
	instanceData[(int)ETileInstanceDataIndex::INT_ALBEDO_TEX] = (float)tileDef.TextureProperties.InteriorAlbedo;
	instanceData[(int)ETileInstanceDataIndex::INT_METALLIC_TEX] = (float)tileDef.TextureProperties.InteriorMetallic;
	instanceData[(int)ETileInstanceDataIndex::INT_NORMAL_TEX] = (float)tileDef.TextureProperties.InteriorNormal;
	instanceData[(int)ETileInstanceDataIndex::INT_SPECULAR_TEX] = (float)tileDef.TextureProperties.InteriorSpecular;
	
	instanceData[(int)ETileInstanceDataIndex::INT_TINT_R] = tileDef.InteriorTint.R;
	instanceData[(int)ETileInstanceDataIndex::INT_TINT_G] = tileDef.InteriorTint.G;
	instanceData[(int)ETileInstanceDataIndex::INT_TINT_B] = tileDef.InteriorTint.B;

	instanceData[(int)ETileInstanceDataIndex::USERDEF_ALBEDO] = -1.0f;
	instanceData[(int)ETileInstanceDataIndex::USERDEF_NORMAL] = -1.0f;
	instanceData[(int)ETileInstanceDataIndex::USERDEF_ORM] = -1.0f;

	if (TileTextureRegistry)
	{
		const int32 UserAlbedoSlot = IsTileAssetHandleSet(tileDef.TextureProperties.ConstantTexHandles.ConstAlbedo)
			? TileTextureRegistry->ResolveSlotFromHandle(tileDef.TextureProperties.ConstantTexHandles.ConstAlbedo)
			: INDEX_NONE;
		const int32 UserNormalSlot = IsTileAssetHandleSet(tileDef.TextureProperties.ConstantTexHandles.ConstNormal)
			? TileTextureRegistry->ResolveSlotFromHandle(tileDef.TextureProperties.ConstantTexHandles.ConstNormal)
			: INDEX_NONE;
		const int32 UserORMSlot = IsTileAssetHandleSet(tileDef.TextureProperties.ConstantTexHandles.ConstORM)
			? TileTextureRegistry->ResolveSlotFromHandle(tileDef.TextureProperties.ConstantTexHandles.ConstORM)
			: INDEX_NONE;

		if (UserAlbedoSlot != INDEX_NONE)
		{
			instanceData[(int)ETileInstanceDataIndex::USERDEF_ALBEDO] = static_cast<float>(UserAlbedoSlot);
		}

		if (UserNormalSlot != INDEX_NONE)
		{
			instanceData[(int)ETileInstanceDataIndex::USERDEF_NORMAL] = static_cast<float>(UserNormalSlot);
		}

		if (UserORMSlot != INDEX_NONE)
		{
			instanceData[(int)ETileInstanceDataIndex::USERDEF_ORM] = static_cast<float>(UserORMSlot);
		}
	}
	else
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileChunk::GetCustomDataArray: TileTextureRegistry was null. User-defined texture slots remain -1 for TileID='%s'."), *tileObject.ID.ToString());
	}

	return instanceData;
}

UStaticMesh* ATileChunk::ResolveMeshForTileDefinition(const FTileDefinition& tileDef) const
{
	if (tileDef.Mesh)
	{
		return tileDef.Mesh;
	}

	if (tileDef.UserDefinedMesh.Kind == ERegisteredAssetType::None)
	{
		return nullptr;
	}

	UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr;
	if (!TileTextureRegistry)
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileChunk::ResolveMeshForTileDefinition: TileTextureRegistry was null. TileName='%s' Handle={%s}"),
			*tileDef.Name,
			*DescribeTileTextureHandleForLog(tileDef.UserDefinedMesh));
		return nullptr;
	}

	UStaticMesh* ResolvedMesh = TileTextureRegistry->ResolveMeshFromHandle(tileDef.UserDefinedMesh);
	UE_LOG(LogTemp, Display, TEXT("ATileChunk::ResolveMeshForTileDefinition: TileName='%s' Mesh='%s' Handle={%s}"),
		*tileDef.Name,
		ResolvedMesh ? *ResolvedMesh->GetPathName() : TEXT("<null>"),
		*DescribeTileTextureHandleForLog(tileDef.UserDefinedMesh));
	return ResolvedMesh;
}

UHierarchicalInstancedStaticMeshComponent* ATileChunk::LazyCreateHISM(const FTileRenderKey& key, const FTileDefinition& tileDef)
{
	UHierarchicalInstancedStaticMeshComponent* HISM = NewObject<UHierarchicalInstancedStaticMeshComponent>(this);
	
	UStaticMesh* mesh = key.Mesh ? key.Mesh : ResolveMeshForTileDefinition(tileDef);
	
	HISM->SetStaticMesh(mesh);
	
	UMaterialInterface* MaterialToUse = tileDef.ParentMaterial;
	if (tileDef.ParentMaterial)
	{
		UMaterialInstanceDynamic* MID = UMaterialInstanceDynamic::Create(tileDef.ParentMaterial, this);
		UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr;
		UTexture2DArray* UserDefinedAtlas = TileTextureRegistry ? TileTextureRegistry->GetUserDefinedAtlas() : nullptr;

		if (UserDefinedAtlas)
		{
			MID->SetTextureParameterValue(TEXT("UserDefinedAtlas"), UserDefinedAtlas);
			UE_LOG(LogTemp, Display, TEXT("ATileChunk::LazyCreateHISM: Set MID UserDefinedAtlas='%s' for Mesh='%s' Material='%s'"),
				*UserDefinedAtlas->GetPathName(),
				mesh ? *mesh->GetPathName() : TEXT("<null>"),
				*tileDef.ParentMaterial->GetPathName());
		}
		else
		{
			UE_LOG(LogTemp, Warning, TEXT("ATileChunk::LazyCreateHISM: UserDefinedAtlas was null. User-defined texture slots can resolve, but material cannot sample atlas. Mesh='%s' Material='%s'"),
				mesh ? *mesh->GetPathName() : TEXT("<null>"),
				*tileDef.ParentMaterial->GetPathName());
		}

		MaterialToUse = MID;
	}
	else
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileChunk::LazyCreateHISM: ParentMaterial was null for Mesh='%s'"),
			mesh ? *mesh->GetPathName() : TEXT("<null>"));
	}

	HISM->SetMaterial(0, MaterialToUse);
	HISM->SetNumCustomDataFloats(customDataFloats);
	HISM->RuntimeVirtualTextures = RVTOutputs;
	HISM->RegisterComponent();
	HISMMap.Add(key, HISM);
	HISMReverseLookup.Add(key, TArray<FObjectReference>());
	
	return HISM;
}

void ATileChunk::StoreRuntimeListener(FRuntimeListenerObject& listener)
{
	TArray<FRuntimeListenerObject>& Listeners = perSquareHandles.FindOrAdd(listener.squarePosition);
	Listeners.Add(listener);
}

void ATileChunk::BindRuntimeData(FIntVector squarePosition, int32 objectIndex)
{
	bool found = false;
	FSquareTile* squarePtr = GetSquareTilePtr(squarePosition, found);
	if (!found)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("failed to bind runtime data"));
		return;
	}
	FTileObject& object = squarePtr->GetObjectsOnSquare()[objectIndex];
	if (object.runtimeData.Values().IsEmpty())
	{
		return;
	}
	
	FDelegateHandle newHandle =
	object.runtimeData.OnChanged.AddLambda(
		[this, squarePosition, objectIndex](FName Key, const FString& Value)
		{
			OnTileObjectDataChanged(squarePosition, objectIndex, Key, Value);
		}
	);
	
	FRuntimeListenerObject newListener = FRuntimeListenerObject();
	newListener.squarePosition = squarePosition;
	newListener.objectIndex = objectIndex;
	newListener.listenerHandle = newHandle;
	
	StoreRuntimeListener(newListener);
}

void ATileChunk::UnbindRuntimeData(FIntVector Square, int32 ObjectIndex)
{
	TArray<FRuntimeListenerObject>* Listeners = perSquareHandles.Find(Square);
	if (!Listeners)
	{
		return;
	}

	bool found = false;
	FSquareTile* SquarePtr = GetSquareTilePtr(Square, found);
	if (!found)
	{
		return;
	}

	TArray<FTileObject>& Objects = SquarePtr->GetObjectsOnSquare();

	for (int32 i = Listeners->Num() - 1; i >= 0; --i)
	{
		FRuntimeListenerObject& Listener = (*Listeners)[i];

		if (Listener.objectIndex == ObjectIndex)
		{
			if (Objects.IsValidIndex(ObjectIndex))
			{
				Objects[ObjectIndex].runtimeData.OnChanged.Remove(Listener.listenerHandle);
			}

			Listeners->RemoveAtSwap(i);
		}
	}

	if (Listeners->Num() == 0)
	{
		perSquareHandles.Remove(Square);
	}
	
}

void ATileChunk::InitializeFuncMap()
{
	TWeakObjectPtr<ATileChunk> WeakThis(this);
	
	funcMap.Add("tint", [WeakThis](FIntVector square, int32 obj, FName Key, const FString& Value) 
		{
			if (WeakThis.IsValid())
			{
				WeakThis->ApplyTintOverride(square, obj, Key, Value);
			}
		});
	
	funcMap.Add("interior_tint", [WeakThis](FIntVector square, int32 obj, FName Key, const FString& Value) 
	{
		if (WeakThis.IsValid())
		{
			WeakThis->ApplyInteriorTintOverride(square, obj, Key, Value);
		}
	});
}

void ATileChunk::OnTileObjectDataChanged(FIntVector squarePosition, int32 objectIndex, FName Key, const FString& Value)
{
	//UE_LOG(LogBarrelQuest, Warning, TEXT("OnTileObjectDataChanged: objIdx: %i / key : %s / val: %s"), objectIndex, *Key.ToString(), *Value);
	
	auto* f = funcMap.Find(Key);
	
	if (f)
	{
		(*f)(squarePosition, objectIndex, Key, Value);
		return;
	}
	
	OnObjectUnhandledDataChanged(Key, Value);
}

void ATileChunk::SetObjectInstanceData(FIntVector square, int32 objectIndex, ETileInstanceDataIndex propIndex, float propValue)
{
	bool found;
	FSquareTile* squarePtr = GetSquareTilePtr(square, found);
	
	if (!squarePtr)
	{
		return;
	}
	
	FTileObject& Object = squarePtr->GetObjectsOnSquare()[objectIndex];
	FTileDefinition def = GetOwningTileManager()->GetTileByID(this, Object.ID);
	
	UStaticMesh* ResolvedMesh = ResolveMeshForTileDefinition(def);
	const FTileRenderKey renderKey = FTileRenderKey(ResolvedMesh, def.ParentMaterial);
		
	UHierarchicalInstancedStaticMeshComponent** HISMMapResult = HISMMap.Find(renderKey);
			
	if (!HISMMapResult)
	{
		UE_LOG(LogTemp, Warning, TEXT("Didnt find HISM for: %s"), *Object.ID.ToString());
		return;
	}
		
	UHierarchicalInstancedStaticMeshComponent* HISM = *HISMMapResult;
		
	float currentData = HISM->PerInstanceSMCustomData[Object.RenderInstanceIndex * ATileChunk::customDataFloats + (int)propIndex];
	const bool s = HISM->SetCustomDataValue(Object.RenderInstanceIndex, (int)propIndex, propValue, true);
}

void ATileChunk::ApplyTintOverride(FIntVector square, int32 objectIndex, FName Key, const FString& Value)
{
	FLinearColor instColor = UBarrelUtilityFunctionLibrary::HexStringToLinearColor(Value);
	SetObjectInstanceData(square, objectIndex, ETileInstanceDataIndex::TINT_R, instColor.R);
	SetObjectInstanceData(square, objectIndex, ETileInstanceDataIndex::TINT_G, instColor.G);
	SetObjectInstanceData(square, objectIndex, ETileInstanceDataIndex::TINT_B, instColor.B);
}

void ATileChunk::ApplyInteriorTintOverride(FIntVector square, int32 objectIndex, FName Key, const FString& Value)
{
	FLinearColor interiorInstColor = UBarrelUtilityFunctionLibrary::HexStringToLinearColor(Value);
	SetObjectInstanceData(square, objectIndex, ETileInstanceDataIndex::INT_TINT_R, interiorInstColor.R);
	SetObjectInstanceData(square, objectIndex, ETileInstanceDataIndex::INT_TINT_G, interiorInstColor.G);
	SetObjectInstanceData(square, objectIndex, ETileInstanceDataIndex::INT_TINT_B, interiorInstColor.B);
}

void ATileChunk::OnObjectUnhandledDataChanged_Implementation(FName Key, const FString& Value)
{
	return;
}
