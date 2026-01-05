#include "Tiles/TileManager.h"
#include "Tiles/TileChunk.h"
#include "BarrelUtilityLibrary.h"

// Sets default values
ATileManager::ATileManager()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
	bReplicates = true;
	bAlwaysRelevant = true;
}

// Called when the game starts or when spawned
void ATileManager::BeginPlay()
{
	Super::BeginPlay();
}

void ATileManager::AddRoomTile(FIntVector tilePosition, int roomID)
{
	FRoomValue* foundRoom = RoomIDToTiles.Find(roomID);
	if (!foundRoom)
	{
		RoomIDToTiles.Add(roomID, FRoomValue(tilePosition));
		return;
	}
	
	foundRoom->AddRoomTile(tilePosition);
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
		chunk->Destroy();
	}
	Chunks.Empty();
	ChunkLookup.Empty();
	RoomIDToTiles.Empty();
	RoomTilesToID.Empty();
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

void ATileManager::FindRoom(FVector worldPosition)
{
    static int nextRoomID = 1;
    bool bLeaked = false;
    
    FIntVector startCoord = UTileLibrary::WorldToTilePosition(worldPosition);
    
    UE_LOG(LogTemp, Warning, TEXT("=== Starting FindRoom at %s ==="), *startCoord.ToString());
    
    TArray<FIntVector> Queue;
    TSet<FIntVector> Visited;
    
    Queue.Add(startCoord);
    Visited.Add(startCoord);

    struct FDirCheck {
        FIntVector Offset;
        FString DirName;
    };

    TArray<FDirCheck> Checks = {
        { FIntVector(1, 0, 0), TEXT("NORTH") },
        { FIntVector(-1, 0, 0), TEXT("SOUTH") },
        { FIntVector(0, 1, 0), TEXT("EAST") },
        { FIntVector(0, -1, 0), TEXT("WEST") },
        { FIntVector(0, 0, 1), TEXT("UP") },
        { FIntVector(0, 0, -1), TEXT("DOWN") }
    };
    
    const int MAX_ROOM_SIZE = 1000;
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
       
       if (current.Z > maxZ) maxZ = current.Z;
       if (current.Z < minZ) minZ = current.Z;

       bool currentFound = false;
       const FSquareTile& currentSquare = GetSquareTileByTileIndex(current, currentFound);
       
       if (!currentFound)
       {
           continue;
       }

       for (const FDirCheck& check : Checks)
       {
          FIntVector neighborCoord = current + check.Offset;
          if (Visited.Contains(neighborCoord)) continue;

          bool canTraverse = false;
          
          // Horizontal movement (Z unchanged)
          if (check.Offset.Z == 0)
          {
              ETileDirection outDir, inDir;
          	  if (check.Offset.X == 1) {
          	  	  outDir = ETileDirection::NORTH;  // X+ -> NORTH in your system
          	  	  inDir = ETileDirection::SOUTH;
          	  } else if (check.Offset.X == -1) {
          	  	  outDir = ETileDirection::SOUTH;  // X- -> SOUTH in your system
          	  	  inDir = ETileDirection::NORTH;
          	  } else if (check.Offset.Y == 1) {
          	  	  outDir = ETileDirection::EAST;   // Y+ -> EAST in your system
          	  	  inDir = ETileDirection::WEST;
          	  } else {
          	  	  outDir = ETileDirection::WEST;   // Y- -> WEST in your system
          	  	  inDir = ETileDirection::EAST;
          	  }
               
              bool neighborFound = false;
              const FSquareTile& neighborSquare = GetSquareTileByTileIndex(neighborCoord, neighborFound);
                 
              if (!neighborFound)
              {
	              continue;
              }
          	
              bool hasOutWall = currentFound && currentSquare.HasWall(outDir);
              bool hasInWall = neighborFound && neighborSquare.HasWall(inDir);
      
          	  canTraverse = !hasOutWall && !hasInWall;
          }
			// Vertical movement UP
          else if (check.Offset.Z == 1)
          {
          	bool hasCeiling = currentSquare.HasCeiling();
          	if (hasCeiling)
          	{
          		//FIntVector ceilingTile = current + FIntVector(0, 0, 1);
          		//Visited.Add(ceilingTile); // add as part of room but never traverse it directly
          		
          		canTraverse = false; // blocked by ceiling
          	}
          	else
          	{
          		bool neighborFound = false;
          		GetSquareTileByTileIndex(neighborCoord, neighborFound);
          		canTraverse = neighborFound; // Only traverse if destination exists
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
          		bool neighborFound = false;
          		GetSquareTileByTileIndex(neighborCoord, neighborFound);
          		canTraverse = neighborFound; // Only traverse if destination exists
          	}
          }

          if (canTraverse)
          {
              Visited.Add(neighborCoord);
              Queue.Add(neighborCoord);
          }
       }
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
	
    for (const FIntVector& pos : Visited)
    {
        RoomTilesToID.Add(pos, roomIDToAssign);
    	AddRoomTile(pos, roomIDToAssign);
    }

    if (!bLeaked) nextRoomID++;
    
    UE_LOG(LogTemp, Warning, TEXT("=== Room assigned ID: %d ==="), roomIDToAssign);
}

int ATileManager::GetRoomAt(FVector worldPosition, FRoomValue& room)
{
	FIntVector tilePosition = UTileLibrary::WorldToTilePosition(worldPosition);

	//if we are standing on a tile that doesnt have a ceiling then we are not inside a room
	bool hasCeilingAbove = false;
	for (int zOffset = 0; zOffset < 31; zOffset++)
	{
		if (HasCeilingAt(tilePosition + FIntVector(0, 0, zOffset)))
		{
			hasCeilingAbove = true;
			break;
		}
	}

	if (!hasCeilingAbove)
	{
		return -1; //not inside a room
	}
	
	int* roomId = RoomTilesToID.Find(tilePosition);
	
	if (!roomId)
	{
		FindRoom(worldPosition);
		
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
	const FSquareTile& square = chunkPtr->GetSquareTile(tileIndex, found);
	
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
		ChunkLookup.Add(Chunk->ChunkPosition, Chunk);
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
		
		const FTileDefinition def = GetTileByID(Object.ID);
		
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

bool ATileManager::HasCeilingAt(FIntVector pos)
{
	bool found = false;
	const FSquareTile& tile = GetSquareTileByTileIndex(pos, found);
	
	return found && tile.HasCeiling();
}

bool ATileManager::PlaceObjectAtWorld(FVector WorldPosition, FTileObject NewObject)
{
	FIntVector2 ChunkPosition = UTileLibrary::WorldToChunkPosition(WorldPosition);

	ATileChunk* ChunkPtr = GetChunkAt(ChunkPosition);
	if (!ChunkPtr)
	{
		ChunkPtr = SpawnChunk(ChunkPosition);

		if (!ChunkPtr)
		{
			UE_LOG(LogBarrelQuest, Error, TEXT("PlaceObjectAtWorld: chunk was somehow null after spawning!"));
			return false;
		}
	}

	FIntVector TilePositionInChunk = UTileLibrary::WorldToLocalChunkTilePosition(WorldPosition, ChunkPtr);

	ChunkPtr->AddObject(TilePositionInChunk, NewObject);

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
    
	FActorSpawnParameters spawnParams = FActorSpawnParameters();
	spawnParams.Owner = this;
	
	ATileChunk* newChunk = GetWorld()->SpawnActor<ATileChunk>(
		ATileChunk::StaticClass(), 
		newChunkLocation, 
		FRotator(0.0f), 
		spawnParams
	);
    
	newChunk->ChunkPosition = Position;

	ChunkLookup.Add(newChunk->ChunkPosition, newChunk);
	Chunks.Add(newChunk);
    
	return newChunk;
}

FTileDefinition ATileManager::GetTileByID(FName ID)
{
	FTileDefinition* def = TileDataTable->FindRow<FTileDefinition>(ID, TEXT("Tile Manager"), true);
	if (!def)
	{
		const wchar_t* w = *ID.ToString();
		UE_LOG(LogBarrelQuest, Warning, TEXT("No Definition was found for %s"), w);
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
	
	bool hasCategory = square.HasObjectOfCategory(category, this);
	bool hasDirection = square.HasObjectOfDirection(rotation);
	
	return hasCategory && hasDirection;
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

TSet<FIntVector> ATileManager::GetObstructingAreaIndices(FIntVector CameraIdx, const TSet<FIntVector>& TargetArea)
{
    TSet<FIntVector> Results;
    if (TargetArea.Num() == 0) return Results;

    // 1. Get Room Bounds
    int32 MinX = INT_MAX, MaxX = INT_MIN, MinY = INT_MAX, MaxY = INT_MIN;
    int32 RoomMinZ = INT_MAX;
    
    for (const FIntVector& T : TargetArea)
    {
        MinX = FMath::Min(MinX, T.X); MaxX = FMath::Max(MaxX, T.X);
        MinY = FMath::Min(MinY, T.Y); MaxY = FMath::Max(MaxY, T.Y);
        RoomMinZ = FMath::Min(RoomMinZ, T.Z);
    }

    // Determine the vertical range to clear
    int32 LowerZ = FMath::Min(CameraIdx.Z, RoomMinZ);
    int32 UpperZ = FMath::Max(CameraIdx.Z, RoomMinZ);

    // 2. Define the Vision Cone (using 4 corners of the room)
    FVector2D Cam2D(CameraIdx.X, CameraIdx.Y);
    FVector2D LeftRay(0, 0), RightRay(0, 0);
    bool bInitialized = false;

    FVector2D Corners[4] = { FVector2D(MinX, MinY), FVector2D(MaxX, MinY), FVector2D(MaxX, MaxY), FVector2D(MinX, MaxY) };
    
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

    // 3. Scan the "Shadow" Rectangle
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
                // This is the "magic" fix for high cameras.
                // It ensures that even if a wall is on Z=2 and the room is Z=1, it gets hidden.
                for (int32 z = LowerZ; z <= UpperZ; ++z)
                {
                    Results.Add(FIntVector(x, y, z));
                }
            }
        }
    }
    return Results;
}