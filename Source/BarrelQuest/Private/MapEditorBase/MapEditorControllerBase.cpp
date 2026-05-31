


#include "MapEditorBase/MapEditorControllerBase.h"
#include "InputKeyEventArgs.h"
#include "InputCoreTypes.h"
#include "Kismet/GameplayStatics.h"
#include "MapEditorBase/MapEditorActionStackContainerComponent.h"
#include "Tiles/TileChunk.h"
#include "Tiles/TileManager.h"

AMapEditorControllerBase::AMapEditorControllerBase()
{
	ActionStack = CreateDefaultSubobject<UMapEditorActionStackContainerComponent>(TEXT("ActionStack"));
}

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

bool AMapEditorControllerBase::InputKey(const FInputKeyEventArgs& Params)
{
	const bool bHandledBySuper = Super::InputKey(Params);

	if (ActiveTool && Params.Event != IE_Axis)
	{
		return ActiveTool->DispatchActionInput(Params.Key, Params.Event, PlayerInput) || bHandledBySuper;
	}

	return bHandledBySuper;
}

void AMapEditorControllerBase::PostProcessInput(const float DeltaTime, const bool bGamePaused)
{
	Super::PostProcessInput(DeltaTime, bGamePaused);

	if (ActiveTool)
	{
		ActiveTool->DispatchAxisInputs(PlayerInput);
	}
}
