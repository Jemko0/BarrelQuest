

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/PlayerController.h"
#include "Tiles/TileManager.h"
#include "Tiles/Net/Interfaces/TileNetworkInterface.h"
#include "MapEditorControllerBase.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API AMapEditorControllerBase : public APlayerController, public ITileNetworkInterface
{
	GENERATED_BODY()
	
	ATileManager* TileManager = nullptr;
	FTimerDelegate TimerDelegate;
	virtual void ReceiveChunkSyncBatch(FIntVector2 ChunkPosition, const TArray<FTileSyncPacket>& Data) override;
	virtual void FinishSync(FIntVector2 ChunkPosition) override;

public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FName SelectedTileID;
	
	virtual void BeginPlay() override;
	
	void TryGetMgr();
};
