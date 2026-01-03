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
        { FIntVector(1, 0, 0), TEXT("EAST") },
        { FIntVector(-1, 0, 0), TEXT("WEST") },
        { FIntVector(0, 1, 0), TEXT("NORTH") },
        { FIntVector(0, -1, 0), TEXT("SOUTH") },
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
          UE_LOG(LogTemp, Error, TEXT("LEAK: Room expanded beyond max size - %d tiles visited, Z range: %d to %d"), 
                 Visited.Num(), minZ, maxZ);
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
           UE_LOG(LogTemp, Error, TEXT("ERROR: Current tile not found at %s but was in queue!"), *current.ToString());
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
              	UE_LOG(LogTemp, Warning, TEXT("  %s BLOCKED: neighbor tile doesn't exist"), *neighborCoord.ToString());
              	continue;
              }
                 
              bool hasOutWall = currentFound && currentSquare.HasWall(outDir);
              bool hasInWall = neighborFound && neighborSquare.HasWall(inDir);
                 
              if (hasOutWall)
              {
              	UE_LOG(LogTemp, Warning, TEXT("  %s BLOCKED: current tile has outward wall"), *neighborCoord.ToString());
              }
              if (hasInWall)
              {
              	UE_LOG(LogTemp, Warning, TEXT("  %s BLOCKED: neighbor tile has inward wall"), *neighborCoord.ToString());
              }
              if (!hasOutWall && !hasInWall && Visited.Num() < 20)
              {
              	UE_LOG(LogTemp, Log, TEXT("  %s ADDED to queue"), *neighborCoord.ToString());
              }
      
          	  canTraverse = !hasOutWall && !hasInWall;
          }
			// Vertical movement UP
          else if (check.Offset.Z == 1)
          {
          	// First check: can we go up through current tile?
          	bool hasCeiling = currentSquare.HasCeiling();
          	if (hasCeiling)
          	{
          		canTraverse = false; // Blocked by ceiling
          	}
          	else
          	{
          		// Second check: does the tile above actually exist?
          		bool neighborFound = false;
          		GetSquareTileByTileIndex(neighborCoord, neighborFound);
          		canTraverse = neighborFound; // Only traverse if destination exists
          	}
          }
       	// Vertical movement DOWN
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
                UE_LOG(LogTemp, Error, TEXT("LEAK AT TOP: %s - No ceiling!"), *pos.ToString());
                bLeaked = true;
                break;
            }
        }
    }

    int roomIDToAssign = bLeaked ? -1 : nextRoomID;

    for (const FIntVector& pos : Visited)
    {
        Rooms.Add(pos, roomIDToAssign);
    }

    if (!bLeaked) nextRoomID++;
    
    UE_LOG(LogTemp, Warning, TEXT("=== Room assigned ID: %d ==="), roomIDToAssign);
}

int ATileManager::GetRoomAt(FVector worldPosition)
{
	FIntVector tilePosition = UTileLibrary::WorldToTilePosition(worldPosition);
	int* currentRoom = Rooms.Find(tilePosition);
    
	if (!currentRoom)
	{
		FindRoom(worldPosition);
		
		//re check
		currentRoom = Rooms.Find(tilePosition);
		return currentRoom ? *currentRoom : 0; //wont crash because of SCE
	}
    
	return *currentRoom;
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

