

#pragma once

#include "CoreMinimal.h"
#include "MapEditorTool.h"
#include "GameFramework/PlayerController.h"
#include "Tiles/TileManager.h"
#include "Tiles/Net/Interfaces/TileNetworkInterface.h"
#include "MapEditorControllerBase.generated.h"

struct FInputKeyEventArgs;

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
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Instanced, Category = "Map Editor|Tool")
	UMapEditorTool* ActiveTool;
	
	virtual void BeginPlay() override;
	
	void TryGetMgr();
	
	virtual bool InputKey(const FInputKeyEventArgs& Params) override;
	virtual void PostProcessInput(const float DeltaTime, const bool bGamePaused) override;
};
