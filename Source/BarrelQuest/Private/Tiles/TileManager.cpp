#include "Tiles/TileManager.h"
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

const FSquareTile& ATileManager::GetSquareTile(FVector WorldPosition, bool& success)
{
	success = true;
	ATileChunk* chunkPtr = GetChunkAtWorld(WorldPosition);
	if (!chunkPtr)
	{
		success = false;
		return fallbackSquareTile;
	}
	
	FIntVector squarePos = UTileLibrary::WorldToLocalChunkTilePosition(WorldPosition, chunkPtr);
	return chunkPtr->GetSquareTile(squarePos);
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

	FSquareTile& TileRef = ChunkPtr->GetOrCreateSquareTile(TilePositionInChunk);

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

