#include "Tiles/TileManager.h"

#include "BarrelUtilityFunctionLibrary.h"
#include "Tiles/TileChunk.h"
#include "BarrelUtilityLibrary.h"
#include "Components/HierarchicalInstancedStaticMeshComponent.h"
#include "Kismet/GameplayStatics.h"
#include "Kismet/KismetSystemLibrary.h"
#include "Net/UnrealNetwork.h"
#include "Tiles/RightClickInterface.h"
#include "Tiles/Net/Interfaces/TileNetworkInterface.h"

UDataTable* ATileManager::TileDataTable = nullptr;

// Sets default values
ATileManager::ATileManager()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
	bReplicates = true;
	bAlwaysRelevant = true;
	
	static ConstructorHelpers::FObjectFinder<UDataTable> DTRef(TEXT("/Game/BarrelContent/Tiles/Data/New/CompositeTileDefinitions.CompositeTileDefinitions"));
	ATileManager::TileDataTable = DTRef.Object;
}

// Called when the game starts or when spawned
void ATileManager::BeginPlay()
{
	Super::BeginPlay();
}

void ATileManager::AddRoomTile(FIntVector tilePosition, int roomID, bool isExit)
{
	FRoomValue* foundRoom = RoomIDToTiles.Find(roomID);
	if (!foundRoom)
	{
		RoomIDToTiles.Add(roomID, FRoomValue(tilePosition, isExit));
		return;
	}
	
	if (isExit)
	{
		foundRoom->AddExitTile(tilePosition);
		return;
	}
	
	foundRoom->AddRoomTile(tilePosition);
}

FRoomValue& ATileManager::GetRoomRefByID(int roomID, bool& found)
{
	found = true;
	FRoomValue* roomPtr = RoomIDToTiles.Find(roomID);
	
	if (!roomPtr)
	{
		found = false;
		return fallbackRoomValue;
	}
	
	return *roomPtr;
}

void ATileManager::InvalidateRoomAt(FIntVector tilePosition)
{
	int* roomIdPtr = RoomTilesToID.Find(tilePosition);
	
	if (!roomIdPtr)
	{
		//wasnt part of a room anyway
		return;
	}
	
	int roomId = *roomIdPtr;
	
	FRoomValue* room = RoomIDToTiles.Find(roomId);
	
	if (!room)
	{
		ensureMsgf(false, TEXT("RoomTilesToID had roomId %d but RoomIDToTiles did not"), roomId);
		return;
	}
	
	for (const FIntVector& tile : room->tiles)
	{
		RoomTilesToID.Remove(tile);			
	}
	RoomIDToTiles.Remove(roomId);
	
	UE_LOG(LogBarrelQuest, Verbose, TEXT("Invalidated Room with ID: %i"), roomId);
}

void ATileManager::ResetCurrentState()
{
	for (auto*& chunk : Chunks)
	{
		chunk->ResetChunkState();
		chunk->Destroy();
	}
	Chunks.Empty();
	ChunkLookup.Empty();
	RoomIDToTiles.Empty();
	RoomTilesToID.Empty();
	
	FlushLogs();
}

void ATileManager::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const
{
	Super::GetLifetimeReplicatedProps(OutLifetimeProps);
	DOREPLIFETIME(ATileManager, Chunks);
}

// Called every frame
void ATileManager::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
}

ATileChunk* ATileManager::GetChunkAt(FIntVector2 Position)
{
	return ChunkLookup.FindRef(Position);
}

void ATileManager::FindNewRoom(FVector worldPosition)
{
	static int nextRoomID = 1;
	bool bLeaked = false;

	FIntVector startCoord = UTileLibrary::WorldToTilePosition(worldPosition);

	UE_LOG(LogTemp, Warning, TEXT("=== Starting FindRoom at %s ==="), *startCoord.ToString());

	TArray<FIntVector> Queue;
	TSet<FIntVector> Visited;
	TSet<FIntVector> Exits;
	TSet<FIntVector> Ceilings;

	Queue.Add(startCoord);
	Visited.Add(startCoord);

	struct FDirCheck
	{
		FIntVector Offset;
		FString DirName;
	};

	TArray<FDirCheck> Checks = {
		{FIntVector(1, 0, 0), TEXT("NORTH")},
		{FIntVector(-1, 0, 0), TEXT("SOUTH")},
		{FIntVector(0, 1, 0), TEXT("EAST")},
		{FIntVector(0, -1, 0), TEXT("WEST")},
		{FIntVector(0, 0, 1), TEXT("UP")},
		{FIntVector(0, 0, -1), TEXT("DOWN")}};

	const int MAX_ROOM_SIZE = 5000;
	int maxZ = startCoord.Z;
	int minZ = startCoord.Z;

	while (Queue.Num() > 0)
	{
		if (Visited.Num() > MAX_ROOM_SIZE)
		{
			UE_LOG(LogTemp, Error, TEXT("LEAK: Room expanded beyond max size - %d tiles visited, Z range: %d to %d"), Visited.Num(), minZ, maxZ);
			bLeaked = true;
			break;
		}

		FIntVector current = Queue[0];
		Queue.RemoveAt(0);

		if (current.Z > maxZ)
			maxZ = current.Z;
		if (current.Z < minZ)
			minZ = current.Z;

		bool currentFound = false;
		FSquareTile* currentSquare = GetSquareTilePtr(current);

		if (!currentSquare)
		{
			continue;
		}
		
		currentFound = true;
		
		for (const FDirCheck &check : Checks)
		{
			FIntVector neighborCoord = current + check.Offset;
			if (Visited.Contains(neighborCoord))
				continue;

			bool canTraverse = false;

			// Horizontal movement (Z unchanged)
			if (check.Offset.Z == 0)
			{
				ETileDirection outDir, inDir;
				if (check.Offset.X == 1)
				{
					outDir = ETileDirection::NORTH; // X+ -> NORTH
					inDir = ETileDirection::SOUTH;
				}
				else if (check.Offset.X == -1)
				{
					outDir = ETileDirection::SOUTH; // X- -> SOUTH
					inDir = ETileDirection::NORTH;
				}
				else if (check.Offset.Y == 1)
				{
					outDir = ETileDirection::EAST; // Y+ -> EAST
					inDir = ETileDirection::WEST;
				}
				else
				{
					outDir = ETileDirection::WEST; // Y- -> WEST
					inDir = ETileDirection::EAST;
				}

				bool neighborFound = false;
				const FSquareTile &neighborSquare = GetSquareTileByTileIndex(neighborCoord, neighborFound);

				bool hasOutWall = currentFound && currentSquare->HasWall(outDir);
				
				if (!neighborFound)
				{
					if (!hasOutWall)
					{
						UE_LOG(LogTemp, Warning, TEXT("LEAK HORIZONTAL: %s has no %s wall and no neighbor!"), *current.ToString(), *check.DirName);
						bLeaked = true;
						break;
					}
					continue;
				}

				bool hasInWall = neighborFound && neighborSquare.HasWall(inDir);
				
				canTraverse = !hasOutWall && !hasInWall;
			}
			// Vertical movement UP
			else if (check.Offset.Z == 1)
			{
				bool hasCeiling = currentSquare->HasCeiling();
				if (hasCeiling)
				{
					Ceilings.Add(current + FIntVector(0, 0, 1));
					canTraverse = false; // blocked by ceiling
				}
				else
				{
					bool neighborFound = false;
					GetSquareTileByTileIndex(neighborCoord, neighborFound);
					
					if (!neighborFound)
					{
						if (!HasCeilingAbove(current))
						{
							UE_LOG(LogTemp, Warning, TEXT("LEAK UP: %s has no ceiling at any level above!"), *current.ToString());
							bLeaked = true;
							break;
						}
					}
					
					canTraverse = true; // Traverse to neighbor or through air if ceiling exists above
				}
			}
			else if (check.Offset.Z == -1)
			{
				FIntVector tileBelow = current + FIntVector(0, 0, -1);
				bool belowHasCeiling = HasCeilingAt(tileBelow);

				if (belowHasCeiling)
				{
					canTraverse = false; // Blocked by floor
				}
				else
				{
					// Check if destination tile exists
					bool neighborFound = HasSquareAtTileIndex(neighborCoord);
					
					if (!neighborFound)
					{
						if (!HasFloorBelow(current))
						{
							UE_LOG(LogTemp, Warning, TEXT("LEAK DOWN: %s has no floor at any level below!"), *current.ToString());
							bLeaked = true;
							break;
						}
					}
					
					canTraverse = true; // Traverse to neighbor or through air if floor exists below
				}
			}

			if (bLeaked) break;

			if (canTraverse)
			{
				Visited.Add(neighborCoord);
				Queue.Add(neighborCoord);
			}
		}
		if (bLeaked) break;
	}

	UE_LOG(LogTemp, Warning, TEXT("Flood fill complete: %d tiles, Z range: %d to %d"), Visited.Num(), minZ, maxZ);

    // Check if the topmost level has complete ceiling coverage
    if (!bLeaked)
    {
        for (const FIntVector& pos : Visited)
        {
            if (pos.Z == maxZ && !HasCeilingAt(pos))
            {
                UE_LOG(LogTemp, Warning, TEXT("LEAK AT TOP: %s - No ceiling!"), *pos.ToString());
                bLeaked = true;
                break;
            }
        }
    }

    int roomIDToAssign = bLeaked ? -1 : nextRoomID;
	
	if (roomIDToAssign == -1)
	{
		//dont assign -1
		return;
	}
	
	//pass 1 -> assign rooms
    for (const FIntVector& pos : Visited)
    {
        RoomTilesToID.Add(pos, roomIDToAssign);
    	AddRoomTile(pos, roomIDToAssign, false);
    }
	
	//pass 2 -> add ceilings
	for (const FIntVector& pos : Ceilings)
	{
		FRoomValue* room = RoomIDToTiles.Find(roomIDToAssign);
		room->ceilings.Add(pos);
	}
	
	//pass 2 -> find exit squares
	
	for (const FIntVector& pos : Visited)
	{
		bool found = false;
		FSquareTile& square = GetSquareTileRefByIndex(pos, found);
		bool isExit = UTileLibrary::IsSquareExitSquare(this, square, pos, roomIDToAssign);
		
		if (!found)
		{
			//idk how that would be possible
			continue; 
		}
		
		if (isExit)
		{
			AddRoomTile(pos, roomIDToAssign, true);
		}
	}

    if (!bLeaked) nextRoomID++;
    
    UE_LOG(LogTemp, Warning, TEXT("=== Room assigned ID: %d ==="), roomIDToAssign);
}

int ATileManager::GetRoomAt(FVector worldPosition, FRoomValue& room)
{
	FIntVector tilePosition = UTileLibrary::WorldToTilePosition(worldPosition);

	//if we are standing on a tile that doesnt have a ceiling then we are not inside a room
	if (!HasCeilingAbove(tilePosition))
	{
		return -1; //not inside a room
	}
	
	int* roomId = RoomTilesToID.Find(tilePosition);
	
	if (!roomId)
	{
		FindNewRoom(worldPosition);
		
		//re check
		roomId = RoomTilesToID.Find(tilePosition);
		if (!roomId)
		{
			return -1;
		}
	}

	FRoomValue* roomValue = RoomIDToTiles.Find(*roomId);
	if (!roomValue)
	{
		return -1;
	}

	room = *roomValue;
	return *roomId;
}

bool ATileManager::HasSquareAtTileIndex(const FIntVector& tilePos)
{
	FSquareTile* squarePtr = GetSquareTilePtr(tilePos);
	return squarePtr != nullptr;
}


const FSquareTile& ATileManager::GetSquareTile(FVector WorldPosition, bool& success)
{
	success = true;
	ATileChunk* chunkPtr = GetChunkAtWorld(WorldPosition);
	if (!chunkPtr)
	{
		success = false;
		return constFallbackSquareTile;
	}
	
	FIntVector squarePos = UTileLibrary::WorldToLocalChunkTilePosition(WorldPosition, chunkPtr);
	bool found = false;
	const FSquareTile& square = chunkPtr->GetSquareTile(squarePos, found);
	
	if (!found)
	{
		success = false;
		return constFallbackSquareTile;
	}
	
	return square; 
}

FSquareTile& ATileManager::GetSquareTileRefByIndex(FIntVector tileIndex, bool& success)
{
	success = true;
	
	//convert from tile to chunk
	FVector worldPos = UTileLibrary::TileToWorldPosition(tileIndex);
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(worldPos);
	
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	if (!chunkPtr)
	{
		success = false;
		return fallbackSquareTile;
	}
	
	FSquareTile* squarePtr = chunkPtr->Tiles.Find(tileIndex);
	if (!squarePtr)
	{
		success = false;
		return fallbackSquareTile;
	}
	
	return *squarePtr;
}

const FSquareTile& ATileManager::GetSquareTileByTileIndex(FIntVector tileIndex, bool& success)
{
	success = true;
	
	//convert from tile to chunk
	FVector worldPos = UTileLibrary::TileToWorldPosition(tileIndex);
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(worldPos);
	
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	
	if (!chunkPtr)
	{
		success = false;
		return constFallbackSquareTile;
	}
	bool found = false;
	const FSquareTile& square = chunkPtr->GetSquareTile(tileIndex, found); //fix old func call - martin 2017
	
	if (!found)
	{
		success = false;
		return constFallbackSquareTile;
	}
	
	return square;
}

ATileChunk* ATileManager::GetChunkAtWorld(FVector WorldPosition)
{
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(WorldPosition);
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	return chunkPtr;
}

void ATileManager::OnRep_Chunks()
{
	ChunkLookup.Empty();
	for (auto Chunk : Chunks)
	{
		if (!Chunk || !IsValid(Chunk)) continue;
		ChunkLookup.Add(Chunk->ChunkPosition, Chunk);
	}

	for (int32 i = PendingChunkObjects.Num() - 1; i >= 0; i--)
	{
		auto& [ChunkPos, SquarePos, Object] = PendingChunkObjects[i];
		ATileChunk* Chunk = GetChunkAt(ChunkPos);
		if (Chunk)
		{
			Chunk->AddObject(SquarePos, Object);
			PendingChunkObjects.RemoveAt(i);
		}
	}

	for (int32 i = PendingRemovals.Num() - 1; i >= 0; i--)
	{
		auto& [WorldPos, ID] = PendingRemovals[i];
		ATileChunk* Chunk = GetChunkAtWorld(WorldPos);
		if (Chunk)
		{
			RemoveObjectAtWorldByID(WorldPos, ID);
			PendingRemovals.RemoveAt(i);
		}
	}
}

bool ATileManager::SetInstanceDataByTileIndex(FIntVector tilePosition, ETileInstanceDataIndex propertyIndex, float newPropValue,
	FTileSearchFilter searchFilter)
{
	FVector tileWorld = UTileLibrary::TileToWorldPosition(tilePosition);
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(tileWorld);
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	
	if (!chunkPtr)
	{
		//UE_LOG(LogBarrelQuest, Warning, TEXT("ChunkPtr was null"))
		return false;
	}
	
	FIntVector tileLocalPos = UTileLibrary::WorldToLocalChunkTilePosition(tileWorld, chunkPtr);
	
	bool found = false;
	const TArray<FTileObject>& objects = chunkPtr->GetObjectsOnSquare(tileLocalPos, found);
	
	if (!found)
	{
		//UE_LOG(LogBarrelQuest, Warning, TEXT("Tile %s was not found"), *tileLocalPos.ToString())
		return false;
	}
	
	for (const auto& Object : objects)
	{
		//If was never rendered, ignore
		if (Object.RenderInstanceIndex == -1)
		{
			continue;
		}
		
		const FTileDefinition def = GetTileByID(this, Object.ID);
		
		// apply filters
		if (searchFilter.minZLevel != -1)
		{
			if (tilePosition.Z < searchFilter.minZLevel)
			{
				// tile is below minZLevel ignore it
				continue;
			}
			else if (tilePosition.Z == searchFilter.minZLevel)
			{
				// tile is at minZLevel check category
				if (!searchFilter.IsIncludedCategory(def))
				{
					continue;
				}
			}
			else  // tilePosition.Z > searchFilter.minZLevel
			{
				// tile is aobve minZLevel always process, ignore category
			}
		}
		else
		{
			// no z filter was applied
			if (!searchFilter.IsIncludedCategory(def))
			{
				continue;
			}
		}

		
		const FTileRenderKey renderKey = FTileRenderKey(def.Mesh, def.ParentMaterial);
		
		UHierarchicalInstancedStaticMeshComponent** HISMMapResult = chunkPtr->HISMMap.Find(renderKey);
			
		if (!HISMMapResult)
		{
			UE_LOG(LogTemp, Warning, TEXT("Didnt find HISM for: %s"), *Object.ID.ToString());
			continue;
		}
		
		UHierarchicalInstancedStaticMeshComponent* HISM = *HISMMapResult;
		
		float currentData = HISM->PerInstanceSMCustomData[Object.RenderInstanceIndex * ATileChunk::customDataFloats + (int)propertyIndex];
		
		if (currentData == newPropValue)
		{
			return false;
		}
		
		const bool s = HISM->SetCustomDataValue(Object.RenderInstanceIndex, (int)propertyIndex, newPropValue, true);
		UE_LOG(LogTemp, Log, TEXT("On Tile: %s, Object %s set Property %i on %s with value %f ; SUCCESS = %i"), *tilePosition.ToString(), *Object.ID.ToString(), (int)propertyIndex, *HISM->GetName(), newPropValue, s);
	}
	
	return true;
}

bool ATileManager::SetObjectInstanceData(FIntVector squareTilePosition, int32 targetObjectIndex,
	ETileInstanceDataIndex propertyIndex, float newPropValue)
{
	FVector tileWorld = UTileLibrary::TileToWorldPosition(squareTilePosition);
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(tileWorld);
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	
	if (!chunkPtr)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("SetObjectInstanceData: ChunkPtr was null"))
		return false;
	}
	
	FIntVector tileLocalPos = UTileLibrary::WorldToLocalChunkTilePosition(tileWorld, chunkPtr);
	
	bool found = false;
	TArray<FTileObject>& objects = chunkPtr->GetObjectsOnSquare(tileLocalPos, found);
	
	if (!found)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("SetObjectInstanceData: Tile %s was not found"), *tileLocalPos.ToString())
		return false;
	}
	
	FTileObject& Object = objects[targetObjectIndex];
	
	const FTileDefinition def = GetTileByID(this, Object.ID);
	
	const FTileRenderKey renderKey = FTileRenderKey(def.Mesh, def.ParentMaterial);
		
	UHierarchicalInstancedStaticMeshComponent** HISMMapResult = chunkPtr->HISMMap.Find(renderKey);
			
	if (!HISMMapResult)
	{
		UE_LOG(LogTemp, Warning, TEXT("Didnt find HISM for: %s"), *Object.ID.ToString());
		return false;
	}
		
	UHierarchicalInstancedStaticMeshComponent* HISM = *HISMMapResult;
		
	float currentData = HISM->PerInstanceSMCustomData[Object.RenderInstanceIndex * ATileChunk::customDataFloats + (int)propertyIndex];
		
	if (currentData == newPropValue)
	{
		return false;
	}
	
	const bool s = HISM->SetCustomDataValue(Object.RenderInstanceIndex, (int)propertyIndex, newPropValue, true);
	
	return s;
}

bool ATileManager::HasCeilingAt(FIntVector pos)
{
	bool found = false;
	const FSquareTile& tile = GetSquareTileByTileIndex(pos, found);
	
	return found && tile.HasCeiling();
}

bool ATileManager::HasCeilingAbove(FIntVector pos)
{
	//check up to the max height of the chunk system
	for (int z = pos.Z; z < ATileChunk::ChunkSize.Z * 4; ++z)
	{
		if (HasCeilingAt(FIntVector(pos.X, pos.Y, z)))
		{
			return true;
		}
	}
	return false;
}

bool ATileManager::HasFloorBelow(FIntVector pos)
{
	//a floor at Z is represented by HasCeiling at Z-1
	for (int z = pos.Z; z >= 0; --z)
	{
		if (HasCeilingAt(FIntVector(pos.X, pos.Y, z - 1)))
		{
			return true;
		}
	}
	return false;
}

int ATileManager::GetRoomIDAt(FIntVector tilePosition)
{
	int* idPtr = RoomTilesToID.Find(tilePosition);
	
	if (!idPtr)
	{
		return -1;
	}
	
	return *idPtr;
}

FRoomValue ATileManager::GetRoomByID(int id)
{
	FRoomValue* roomPtr = RoomIDToTiles.Find(id);
	
	if (!roomPtr)
	{
		return FRoomValue();
	}
	
	return *roomPtr;
}

void ATileManager::PlaceObjectAtWorld(FVector WorldPosition, FTileObject NewObject)
{
	FIntVector2 ChunkPosition = UTileLibrary::WorldToChunkPosition(WorldPosition);

	ATileChunk* ChunkPtr = GetChunkAt(ChunkPosition);
	if (!ChunkPtr)
	{
		ChunkPtr = SpawnChunk(ChunkPosition);

		if (!ChunkPtr)
		{
			UE_LOG(LogBarrelQuest, Error, TEXT("PlaceObjectAtWorld: chunk was somehow null after spawning!"));
			return;
		}
	}

	FIntVector TilePositionInChunk = UTileLibrary::WorldToLocalChunkTilePosition(WorldPosition, ChunkPtr);
	MUL_ChunkAddObject(ChunkPosition, TilePositionInChunk, NewObject);
	//ChunkPtr->AddObject(TilePositionInChunk, NewObject);
}

///Removes the first object found on the square with the corresponding ID
bool ATileManager::RemoveObjectAtWorldByID(FVector worldPosition, FName ID)
{
	ATileChunk* chunkPtr = GetChunkAtWorld(worldPosition);
	if (!chunkPtr)
	{
		return false;
	}
	
	FIntVector tilePos = UTileLibrary::WorldToTilePosition(worldPosition);
	bool found = false;
	FSquareTile* square = chunkPtr->GetSquareTilePtr(tilePos, found);
	
	if (!found)
	{
		return false;
	}
	
	TArray<FTileObject>& squareObjects = square->GetObjectsOnSquare();
	
	for (int32 i = 0; i < squareObjects.Num(); i++)
	{
		if (squareObjects[i].ID == ID)
		{
			//capture a COPY of the object data
			//this way, when the array shifts the 'TargetObj' is still valid
			FTileObject TargetObj = squareObjects[i];

			//use the logic function to clean up HISM and the array
			chunkPtr->RemoveObject(tilePos, TargetObj);
          
			return true; // exit immediately once found and removed
		}
	}
	
	return false;
}

bool ATileManager::HasSquareAtWorld(FVector worldPosition)
{
	ATileChunk* chunkPtr = GetChunkAtWorld(worldPosition);
	FIntVector tilePos = UTileLibrary::WorldToTilePosition(worldPosition);
	if (!chunkPtr)
	{
		return false;
	}
	return chunkPtr->HasSquare(tilePos);
}

bool ATileManager::RemoveSquareAtWorld(FVector worldPosition)
{
	if (!HasSquareAtWorld(worldPosition))
	{
		return false;
	}
	
	ATileChunk* chunkPtr = GetChunkAtWorld(worldPosition);
	FIntVector tilePos = UTileLibrary::WorldToTilePosition(worldPosition);
	
	chunkPtr->RemoveSquareAt(tilePos);
	
	return true;
}

ATileChunk* ATileManager::SpawnChunk(FIntVector2 Position)
{
	const FVector TileSize = UTileLibrary::GetTileSize();
    
	FVector newChunkLocation = FVector(
		ATileChunk::ChunkSize.X * Position.X * TileSize.X,
		ATileChunk::ChunkSize.Y * Position.Y * TileSize.Y,
		0.0f
	);
	
	ATileChunk* newChunk = static_cast<ATileChunk*>(CreateNewChunk(newChunkLocation));
    
	newChunk->ChunkPosition = Position;
	newChunk->RVTOutputs = ChunkRVTs;
	
	ChunkLookup.Add(newChunk->ChunkPosition, newChunk);
	Chunks.Add(newChunk);
    
	return newChunk;
}

AActor* ATileManager::CreateNewChunk_Implementation(FVector chunkLocation)
{
	FActorSpawnParameters spawnParams = FActorSpawnParameters();
	spawnParams.Owner = this;
	
	ATileChunk* ret = GetWorld()->SpawnActor<ATileChunk>(
	ATileChunk::StaticClass(),
	chunkLocation,
	FRotator(0.0f),
	spawnParams
	);
	
	return ret;
}

FTileDefinition ATileManager::GetTileByID(UObject* WorldContextObject, FName ID)
{
	FTileDefinition* def = ATileManager::TileDataTable->FindRow<FTileDefinition>(ID, TEXT("Tile Manager"), true);
	if (!def)
	{
		const wchar_t* w = *ID.ToString();
		UE_LOG(LogBarrelQuest, Warning, TEXT("No Definition was found for %s"), w);
		
		if (WorldContextObject)
		{
			ATileManager* t = Cast<ATileManager>(UGameplayStatics::GetActorOfClass(WorldContextObject->GetWorld(), ATileManager::StaticClass()));
			if (t)
			{
				t->AddError(WorldContextObject->GetWorld(), FString::Printf(TEXT("No Definition was found for %s"), *ID.ToString()));
			}
		}

		return FTileDefinition();
	}
	return *def;
}

bool ATileManager::SquareHasObjectOfCategory(FVector worldPosition, ETileCategory category)
{
	bool found = false;
	const FSquareTile& square = GetSquareTile(worldPosition, found);
	
	if (!found)
	{
		return false;
	}
	
	return square.HasObjectOfCategory(category, this);
}

bool ATileManager::SquareHasObjectOfCategoryAndRotation(FVector worldPosition, ETileCategory category, 
	ETileDirection rotation)
{
	bool found = false;
	const FSquareTile& square = GetSquareTile(worldPosition, found);
    
	if (!found)
	{
		return false;
	}

	//iterate through the actual objects on this tile
	const TArray<FTileObject>& objects = square.GetReadOnlyObjects();
	
	for (const FTileObject& o : objects)
	{
		FTileDefinition def = GetTileByID(this, o.ID);
		if (def.Category == category && o.Direction == rotation)
		{
			return true;
		}
	}
    
	return false;
}

TArray<FIntVector> ATileManager::Raycast(FIntVector start, FIntVector end)
{
	TArray<FIntVector> tiles;

	// Current position in the grid
	FIntVector current = start;

	// Ray direction in integer space
	FIntVector delta = end - start;

	// Step: +1 if end > start, -1 if end < start
	int32 stepX = (delta.X >= 0) ? 1 : -1;
	int32 stepY = (delta.Y >= 0) ? 1 : -1;
	int32 stepZ = (delta.Z >= 0) ? 1 : -1;

	// Avoid division by zero
	float tMaxX = (delta.X != 0) ? 0.0f : FLT_MAX;
	float tMaxY = (delta.Y != 0) ? 0.0f : FLT_MAX;
	float tMaxZ = (delta.Z != 0) ? 0.0f : FLT_MAX;

	float tDeltaX = (delta.X != 0) ? FMath::Abs(1.0f / delta.X) : FLT_MAX;
	float tDeltaY = (delta.Y != 0) ? FMath::Abs(1.0f / delta.Y) : FLT_MAX;
	float tDeltaZ = (delta.Z != 0) ? FMath::Abs(1.0f / delta.Z) : FLT_MAX;

	tiles.Add(current);

	// Loop until we reach the end tile
	while (current != end)
	{
		// Determine which axis to step next
		if (tMaxX <= tMaxY && tMaxX <= tMaxZ)
		{
			current.X += stepX;
			tMaxX += tDeltaX;
		}
		else if (tMaxY <= tMaxX && tMaxY <= tMaxZ)
		{
			current.Y += stepY;
			tMaxY += tDeltaY;
		}
		else
		{
			current.Z += stepZ;
			tMaxZ += tDeltaZ;
		}

		tiles.Add(current);
	}

	return tiles;
}

TArray<FIntVector> ATileManager::ThickRaycast(FIntVector start, FIntVector end, int32 thickness)
{
	TSet<FIntVector> allTiles;
    
	// get the main line
	TArray<FIntVector> centerLine = Raycast(start, end);
    
	// for each point on the line, add neighboring tiles based on thickness
	for (const FIntVector& tile : centerLine)
	{
		allTiles.Add(tile);
        
		// Add tiles in a cube around this point
		for (int32 x = -thickness; x <= thickness; x++)
		{
			for (int32 y = -thickness; y <= thickness; y++)
			{
				for (int32 z = -thickness; z <= thickness; z++)
				{
					allTiles.Add(tile + FIntVector(x, y, z));
				}
			}
		}
	}
    
	return allTiles.Array();
}

TArray<FRCMOption> ATileManager::TryGetRightClickOptions(FVector worldPosition)
{
	TArray<FRCMOption> options;
	ATileChunk* c = GetChunkAtWorld(worldPosition);
	
	if (!c)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("TryGetRightClickOptions: No chunk found at worldPosition"));
		return options;
	}
	
	FIntVector squarePosition = UTileLibrary::WorldToTilePosition(worldPosition);
	
	FStoredFeatureArray* featuresOnSquarePtr = c->AttachedFeatures.Find(squarePosition);
	
	if (!featuresOnSquarePtr)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("TryGetRightClickOptions: No features on square"));
		return options;
	}
	
	TArray<FStoredFeature>& featuresArray = featuresOnSquarePtr->features;
	
	if (featuresArray.IsEmpty())
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("TryGetRightClickOptions: No features on square"));
		return options;
	}
	
	for (FStoredFeature& f : featuresArray)
	{
		if (IRightClickInterface* rightClickInterface = Cast<IRightClickInterface>(f.ComponentPtr))
		{
			options.Append(rightClickInterface->Execute_GetRCMOptions(f.ComponentPtr, c, worldPosition));	
		}
	}
	
	return options;
}

TSet<FIntVector> ATileManager::GetObstructingAreaIndices(FIntVector CameraIdx, const TSet<FIntVector>& TargetArea)
{
    TSet<FIntVector> Results;
    if (TargetArea.Num() == 0) return Results;

    //get Room Bounds
    int32 MinX = INT_MAX, MaxX = INT_MIN, MinY = INT_MAX, MaxY = INT_MIN;
    int32 RoomMinZ = INT_MAX;
    
    for (const FIntVector& T : TargetArea)
    {
        MinX = FMath::Min(MinX, T.X); MaxX = FMath::Max(MaxX, T.X);
        MinY = FMath::Min(MinY, T.Y); MaxY = FMath::Max(MaxY, T.Y);
        RoomMinZ = FMath::Min(RoomMinZ, T.Z);
    }

    //determine the vertical range to clear
    int32 LowerZ = FMath::Min(CameraIdx.Z, RoomMinZ);
    int32 UpperZ = FMath::Max(CameraIdx.Z, RoomMinZ);

    // vision cone
    FVector2D Cam2D(CameraIdx.X, CameraIdx.Y);
    FVector2D LeftRay(0, 0), RightRay(0, 0);
    bool bInitialized = false;

	constexpr int padding = 1;
	
	FVector2D Corners[4] = { 
		FVector2D(MinX - padding, MinY - padding), FVector2D(MaxX + padding, MinY - padding),
		FVector2D(MaxX + padding, MaxY + padding), FVector2D(MinX - padding, MaxY + padding) 
	};
    
    for (const FVector2D& Corner : Corners)
    {
        FVector2D Dir = Corner - Cam2D;
        if (Dir.IsNearlyZero()) continue;

        if (!bInitialized) { LeftRay = RightRay = Dir; bInitialized = true; continue; }
        
        float CrossL = LeftRay.X * Dir.Y - LeftRay.Y * Dir.X;
        float CrossR = RightRay.X * Dir.Y - RightRay.Y * Dir.X;
        
        if (CrossL < 0) LeftRay = Dir;
        if (CrossR > 0) RightRay = Dir;
    }

    //scan the shadow Rectangle
    int32 ScanMinX = FMath::Min(CameraIdx.X, MinX);
    int32 ScanMaxX = FMath::Max(CameraIdx.X, MaxX);
    int32 ScanMinY = FMath::Min(CameraIdx.Y, MinY);
    int32 ScanMaxY = FMath::Max(CameraIdx.Y, MaxY);

    for (int32 x = ScanMinX; x <= ScanMaxX; ++x)
    {
        for (int32 y = ScanMinY; y <= ScanMaxY; ++y)
        {
            FVector2D Rel(x - CameraIdx.X, y - CameraIdx.Y);
            if (Rel.IsNearlyZero()) continue;

            bool bRightOfLeft = (LeftRay.X * Rel.Y - LeftRay.Y * Rel.X) >= -0.01f;
            bool bLeftOfRight = (RightRay.X * Rel.Y - RightRay.Y * Rel.X) <= 0.01f;

            if (bRightOfLeft && bLeftOfRight)
            {
                // ADD THE ENTIRE VERTICAL PILLAR
                for (int32 z = LowerZ; z <= UpperZ; ++z)
                {
                    Results.Add(FIntVector(x, y, z));
                }
            }
        }
    }
    return Results;
}

void ATileManager::SetObjectRuntimeProperty(FIntVector tilePosition, int32 objectIdx, FName& Key, FString& Value)
{
	FSquareTile* squarePtr = GetSquareTilePtr(tilePosition);
	
	if (!squarePtr) return;
	
	FTileObject& object = squarePtr->GetObjectsOnSquare()[objectIdx];
	object.runtimeData.SetValue(Key, Value);
}

FRuntimeDataQueryResult ATileManager::GetObjectRuntimeProperty(FIntVector tilePosition, int32 objectIdx, FName& Key)
{
	FSquareTile* squarePtr = GetSquareTilePtr(tilePosition);
	
	if (!squarePtr) return FRuntimeDataQueryResult();
	
	FTileObject& object = squarePtr->GetObjectsOnSquare()[objectIdx];
	return object.runtimeData.GetValue(Key);
}

bool ATileManager::RemoveObjectRuntimeProperty(FIntVector tilePosition, int32 objectIdx, FName& Key)
{
	FSquareTile* squarePtr = GetSquareTilePtr(tilePosition);
	
	if (!squarePtr) return false;
	
	FTileObject& object = squarePtr->GetObjectsOnSquare()[objectIdx];
	return object.runtimeData.RemoveValue(Key);
}

FSquareTile* ATileManager::GetSquareTilePtr(FIntVector tilePos)
{
	FVector tileWorld = UTileLibrary::TileToWorldPosition(tilePos);
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(tileWorld);
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	
	if (!chunkPtr) return nullptr;
	bool found = false;
	return chunkPtr->GetSquareTilePtr(tilePos, found);
}

void ATileManager::ConvertRuntimeDataToInstanceData(FIntVector tilePosition, int32 objectIdx)
{
	FVector tileWorld = UTileLibrary::TileToWorldPosition(tilePosition);
	FIntVector2 chunkPos = UTileLibrary::WorldToChunkPosition(tileWorld);
	ATileChunk* chunkPtr = GetChunkAt(chunkPos);
	
	if (!chunkPtr) return;
	bool found;
	FSquareTile* squarePtr = chunkPtr->GetSquareTilePtr(tilePosition, found);
	
	if (!found) return;
	
	ensureMsgf(objectIdx < squarePtr->GetObjectsOnSquare().Num(), TEXT("Invalid objectIdx %d"), objectIdx);
	
	FTileObject& o = squarePtr->GetObjectsOnSquare()[objectIdx];
	
	FTileDefinition tileDef = ATileManager::GetTileByID(this, o.ID);
	
	FTileRenderKey renderKey = {tileDef.Mesh, tileDef.ParentMaterial};
	UHierarchicalInstancedStaticMeshComponent** HISMPtr = chunkPtr->HISMMap.Find(renderKey);
	
	if (!HISMPtr) return;
	
	UHierarchicalInstancedStaticMeshComponent* HISM = *HISMPtr;
	
	//Apply runtime tint
	FRuntimeDataQueryResult tintOverrideResult = o.runtimeData.GetValue(TEXT("tint_override"));
	FLinearColor tintOverrideColor = FLinearColor::Black;
	if (tintOverrideResult.valid)
	{
		tintOverrideColor = UBarrelUtilityFunctionLibrary::HexStringToLinearColor(tintOverrideResult.data);
		HISM->SetCustomDataValue(o.RenderInstanceIndex, (int)ETileInstanceDataIndex::TINT_R, tintOverrideColor.R);
		HISM->SetCustomDataValue(o.RenderInstanceIndex, (int)ETileInstanceDataIndex::TINT_G, tintOverrideColor.G);
		HISM->SetCustomDataValue(o.RenderInstanceIndex, (int)ETileInstanceDataIndex::TINT_B, tintOverrideColor.B);
	}
}

void ATileManager::AddError(UObject* Source, FString Message)
{
	if (!Source) return;
	
	Logs.Add(FString::Printf(TEXT("%s : %s"), *Source->GetName(), *Message));
	OnTileManagerLog.Broadcast(Message);
}

void ATileManager::FlushLogs()
{
	Logs.Empty();
	OnTileManagerFlushLog.Broadcast();
}

void ATileManager::SV_RequestChunkSync_Implementation(FIntVector2 ChunkPosition, APlayerController* PlayerController)
{
    ATileChunk* ChunkPtr = GetChunkAt(ChunkPosition);
	
	ITileNetworkInterface* TileNetworkInterface = Cast<ITileNetworkInterface>(PlayerController);
	if (!TileNetworkInterface)
	{
		UE_LOG(LogTemp, Warning, TEXT("Controller Doesnt inherit from ITileNetworkInterface"));
		return;
	}
	
    if (!ChunkPtr) 
    {
        UE_LOG(LogTemp, Warning, TEXT("SV_RequestChunkSync: Chunk at %s not found!"), *ChunkPosition.ToString());
        return;
    }
    
    TArray<FTileSyncPacket> DataBatch;
    int32 ApproximateSize = 0;
    int32 TotalObjectsSent = 0;
    int32 BatchCount = 0;

    UE_LOG(LogTemp, Log, TEXT("SV_RequestChunkSync: Starting sync for Chunk %s (Total Tiles: %d)"), *ChunkPosition.ToString(), ChunkPtr->Tiles.Num());

    for (auto It : ChunkPtr->Tiles)
    {
       FSquareTile* SquarePtr = GetSquareTilePtr(It.Key);
       if (!SquarePtr) continue;

       TArray<FTileObject> ObjectsOnSquare = SquarePtr->GetObjectsOnSquare();
       if (ObjectsOnSquare.Num() == 0) continue;

       DataBatch.Add(FTileSyncPacket(It.Key, ObjectsOnSquare));
       TotalObjectsSent += ObjectsOnSquare.Num();

       // ROUGH CALCULATION: 
       // 12 bytes (FIntVector) + (NumObjects * 200 bytes per FTileObject)
       ApproximateSize += 12 + (ObjectsOnSquare.Num() * 200);
       
       if (ApproximateSize > 45000) // 45KB safety threshold
       {
          BatchCount++;
          UE_LOG(LogTemp, Log, TEXT("SV_RequestChunkSync: Sending Batch %d for Chunk %s (~%d bytes, %d squares)"), 
                 BatchCount, *ChunkPosition.ToString(), ApproximateSize, DataBatch.Num());

          TileNetworkInterface->ReceiveChunkSyncBatch(ChunkPosition, DataBatch);
          
          DataBatch.Empty();
          ApproximateSize = 0;
       }
    }

    // Final sweep for any remaining data
    if (DataBatch.Num() > 0)
    {
       BatchCount++;
       UE_LOG(LogTemp, Log, TEXT("SV_RequestChunkSync: Sending Final Batch %d for Chunk %s (~%d bytes, %d squares)"), 
              BatchCount, *ChunkPosition.ToString(), ApproximateSize, DataBatch.Num());
              
       TileNetworkInterface->ReceiveChunkSyncBatch(ChunkPosition, DataBatch);
    }

    UE_LOG(LogTemp, Log, TEXT("SV_RequestChunkSync: Sync Finished for %s. Total Batches: %d, Total Objects: %d"), 
           *ChunkPosition.ToString(), BatchCount, TotalObjectsSent);

	TileNetworkInterface->FinishSync(ChunkPosition);
}

void ATileManager::MUL_ChunkRemoveObjectByID_Implementation(FVector WorldPosition, FIntVector SquarePosition, FName ID)
{
	if (!HasAuthority())
	{
		ATileChunk* ChunkPtr = GetChunkAtWorld(WorldPosition);
		if (!ChunkPtr)
		{
			PendingRemovals.Add(MakeTuple(WorldPosition, ID));
			return;
		}
	}
	
	RemoveObjectAtWorldByID(WorldPosition, ID);
}


void ATileManager::SV_RemoveObjectAtWorldByID_Implementation(FVector WorldPosition, FName ID)
{
	FIntVector SquarePosition = UTileLibrary::WorldToTilePosition(WorldPosition);
	MUL_ChunkRemoveObjectByID(WorldPosition, SquarePosition, ID);
}

void ATileManager::MUL_ChunkAddObject_Implementation(FIntVector2 ChunkPosition, FIntVector SquarePosition, FTileObject Object)
{
	Object.RenderInstanceIndex = -1;
    
	ATileChunk* ChunkPtr = GetChunkAt(ChunkPosition);
	if (!ChunkPtr)
	{
		if (!HasAuthority()) // only clients should ever hit this
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MUL_ChunkAddObject: Queuing for chunk %s"), *ChunkPosition.ToString());
			PendingChunkObjects.Add(MakeTuple(ChunkPosition, SquarePosition, Object));
		}
		else
		{
			UE_LOG(LogBarrelQuest, Error, TEXT("MUL_ChunkAddObject: Server couldn't find its own chunk!"));
		}
		return;
	}
    
	ChunkPtr->AddObject(SquarePosition, Object);
};

void ATileManager::SV_PlaceObjectAtWorld_Implementation(FVector Position, FTileObject newObject)
{
	PlaceObjectAtWorld(Position, newObject);
}
