// 

#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "Tiles/TileLibrary.h"
#include "TileNetworkInterface.generated.h"

// This class does not need to be modified.
UINTERFACE()
class UTileNetworkInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API ITileNetworkInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	
	virtual void ReceiveChunkSyncBatch(FIntVector2 ChunkPosition, const TArray<FTileSyncPacket>& Data) = 0;
	virtual void FinishSync(FIntVector2 ChunkPosition) = 0;
};
