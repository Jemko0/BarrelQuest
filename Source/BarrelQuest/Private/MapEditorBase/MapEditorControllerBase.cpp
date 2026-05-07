


#include "MapEditorBase/MapEditorControllerBase.h"

#include "Kismet/GameplayStatics.h"
#include "Tiles/TileChunk.h"
#include "Tiles/TileManager.h"

void AMapEditorControllerBase::ReceiveChunkSyncBatch(FIntVector2 ChunkPosition, const TArray<FTileSyncPacket>& Data)
{
	/*
	ATileChunk* ChunkPtr = TileManager->GetChunkAt(ChunkPosition);
	if (!ChunkPtr) return;

	for (const FTileSyncPacket& Packet : Data)
	{
		FSquareTile& TargetSquare = ChunkPtr->Tiles.FindOrAdd(Packet.Position);
		
		TargetSquare.AddObjects(Packet.Objects);

		for (FTileObject& Obj : TargetSquare.GetObjectsOnSquare())
		{
			Obj.runtimeData.BuildLookup();
		}
	}
	*/
}

void AMapEditorControllerBase::FinishSync(FIntVector2 ChunkPosition)
{
	if(ATileChunk* Chunk = TileManager->GetChunkAt(ChunkPosition))
	{
		Chunk->BuildChunk();
	}
}

void AMapEditorControllerBase::BeginPlay()
{
	Super::BeginPlay();
	TryGetMgr();
}

void AMapEditorControllerBase::TryGetMgr()
{
	AActor* actorMgr = UGameplayStatics::GetActorOfClass(GetWorld(), TSubclassOf<ATileManager>());
	TileManager = static_cast<ATileManager*>(actorMgr);
	
	TimerDelegate.BindUObject(this, &AMapEditorControllerBase::TryGetMgr);
	
	FTimerHandle handle = GetWorld()->GetTimerManager().SetTimerForNextTick(TimerDelegate);
}
