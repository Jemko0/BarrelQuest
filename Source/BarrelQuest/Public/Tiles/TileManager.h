#pragma once

#include "CoreMinimal.h"
#include "RightClickLibrary.h"
#include "GameFramework/Actor.h"
#include "Interactable/InteractableInterface.h"
#include "Net/TileNetworkLibrary.h"
#include "Tiles/TileLibrary.h"
#include "Types/TReplicatedMap.h"
#include "TileManager.generated.h"


class ATileChunk;

DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnTileManagerLog, FString, msg);
DECLARE_DYNAMIC_MULTICAST_DELEGATE(FOnTileManagerFlushLog);

USTRUCT(BlueprintType)
struct FTileMapMemoryEstimate
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadOnly)
	int64 TotalBytes = 0;

	UPROPERTY(BlueprintReadOnly)
	int64 ChunkBytes = 0;

	UPROPERTY(BlueprintReadOnly)
	int64 UserAssetBytes = 0;

	UPROPERTY(BlueprintReadOnly)
	int64 UserResourceBytes = 0;

	UPROPERTY(BlueprintReadOnly)
	int32 ChunkCount = 0;

	UPROPERTY(BlueprintReadOnly)
	int32 SquareCount = 0;

	UPROPERTY(BlueprintReadOnly)
	int32 ObjectCount = 0;

	UPROPERTY(BlueprintReadOnly)
	int32 InstanceCount = 0;
};

UCLASS()
class BARRELQUEST_API ATileManager : public AActor //, public IInteractableInterface
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	ATileManager();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;
public:
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, ReplicatedUsing=OnRep_Chunks)
	TArray<ATileChunk*> Chunks;
	
	TArray<TTuple<FIntVector2, FIntVector, FTileObject>> PendingChunkObjects;
	TArray<TTuple<FVector, FName>> PendingRemovals;
	
	static UDataTable* TileDataTable;
	
protected:
	UPROPERTY(EditAnywhere)
	TMap<FIntVector2, ATileChunk*> ChunkLookup;
public:
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TMap<FIntVector, int> RoomTilesToID;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TMap<int, FRoomValue> RoomIDToTiles;
	
protected:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<TObjectPtr<URuntimeVirtualTexture>> ChunkRVTs;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, BlueprintAssignable)
	FOnTileManagerLog OnTileManagerLog;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, BlueprintAssignable)
	FOnTileManagerFlushLog OnTileManagerFlushLog;
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FName, FTileDefinition> UserDefinedTileDefinitions;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	FString WorldName = FString(TEXT("Unnamed World"));
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	int32 WorldVersion = 1;
	
	virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;

	// Called every frame
	virtual void Tick(float DeltaTime) override;
	
	//virtual void InteractWithTileObject_Implementation(AActor* InteractionOwner, FIntVector TileIndex, int32 ObjectIndex) override;
	
	const FSquareTile constFallbackSquareTile = FSquareTile(FIntVector(0,0,0));
	FSquareTile fallbackSquareTile = FSquareTile(FIntVector(0,0,0));
	
	FRoomValue fallbackRoomValue = FRoomValue();

	UFUNCTION(BlueprintCallable)
	ATileChunk* GetChunkAt(FIntVector2 Position);
	
	void FindNewRoom(FVector worldPosition);
	
	UFUNCTION(BlueprintCallable)
	int GetRoomAt(FVector worldPosition, FRoomValue& room);
	
	UFUNCTION(BlueprintCallable)
	const FSquareTile& GetSquareTile(FVector WorldPosition, bool& success);
	
	UFUNCTION(BlueprintCallable)
	const FSquareTile& GetSquareTileByTileIndex(FIntVector tileIndex, bool& success);
	
	UFUNCTION(BlueprintCallable)
	FSquareTile& GetSquareTileRefByIndex(FIntVector tileIndex, bool& success);
	
	UFUNCTION(BlueprintCallable)
	ATileChunk* GetChunkAtWorld(FVector WorldPosition);
	
	UFUNCTION(BlueprintCallable)
	void AddRoomTile(FIntVector tilePosition, int roomID, bool isExit);
	
	UFUNCTION(BlueprintCallable)
	FRoomValue& GetRoomRefByID(int roomID, bool& found);
	
	UFUNCTION(BlueprintCallable)
	void InvalidateRoomAt(FIntVector tilePosition);
	
	UFUNCTION(BlueprintCallable)
	void ResetCurrentState();

	UFUNCTION(BlueprintPure, Category="Memory")
	FTileMapMemoryEstimate GetEstimatedMapMemoryUsage(bool bIncludeUserResources = true) const;

	UFUNCTION(BlueprintPure, Category="Memory")
	float GetEstimatedMapMemoryUsageMB(bool bIncludeUserResources = true) const;
	
	UFUNCTION()
	void OnRep_Chunks();
	
	///Sets the instance data property for all objects on a square, returns true if succeeded,
	///can be filtered using FTileSearchFilter
	///Do not use this for long lasting changes, (will not save!!)
	UFUNCTION(BlueprintCallable)
	bool SetInstanceDataByTileIndex(FIntVector tilePosition, ETileInstanceDataIndex propertyIndex, float newPropValue, 
		FTileSearchFilter searchFilter = FTileSearchFilter());
	
	///Sets the instance data property for a specific object on a square, returns true if succeeded
	///Do not use this for long lasting changes, (will not save!!)
	UFUNCTION(BlueprintCallable)
	bool SetObjectInstanceData(FIntVector squareTilePosition, int32 targetObjectIndex, ETileInstanceDataIndex propertyIndex, float newPropValue);
	
	UFUNCTION(BlueprintCallable)
	bool HasCeilingAt(FIntVector pos);
	
	UFUNCTION(BlueprintCallable)
	int GetRoomIDAt(FIntVector tilePosition);
	
	UFUNCTION(BlueprintCallable)
	bool HasCeilingAbove(FIntVector pos);

	UFUNCTION(BlueprintCallable)
	bool HasFloorBelow(FIntVector pos);
	
	UFUNCTION(BlueprintCallable)
	FRoomValue GetRoomByID(int id);
	
	///Places a TileObject at the world position, if the square doesn't exist, it will create it.
	/// If the chunk doesn't exist, it will create it. If it cant be placed, will return false
	UFUNCTION(BlueprintCallable)
	void PlaceObjectAtWorld(FVector worldPosition, FTileObject newObject);
	
	UFUNCTION(BlueprintCallable)
	bool RemoveObjectAtWorldByID(FVector worldPosition, FName ID);
	
	UFUNCTION(BlueprintCallable)
	bool HasSquareAtWorld(FVector worldPosition);

	UFUNCTION(BlueprintCallable)
	bool HasSquareAtTileIndex(const FIntVector& tilePos);
	
	UFUNCTION(BlueprintCallable)
	bool RemoveSquareAtWorld(FVector worldPosition);
	
	UFUNCTION(BlueprintCallable)
	ATileChunk* SpawnChunk(FIntVector2 Position);
	
	UFUNCTION(BlueprintCallable, meta=(WorldContext = "WorldContextObject"))
	static FTileDefinition GetTileByID(UObject* WorldContextObject, FName ID);
	
	UFUNCTION(BlueprintCallable)
	bool SquareHasObjectOfCategory(FVector worldPosition, ETileCategory category);
	
	UFUNCTION(BlueprintCallable)
	bool SquareHasObjectOfCategoryAndRotation(FVector worldPosition, ETileCategory category, ETileDirection rotation);
	
	UFUNCTION(BlueprintCallable)
	TArray<FIntVector> Raycast(FIntVector start, FIntVector end);
	
	UFUNCTION(BlueprintCallable)
	TArray<FIntVector> ThickRaycast(FIntVector start, FIntVector end, int32 thickness);
	
	UFUNCTION(BlueprintCallable)
	TArray<FRCMOption> TryGetRightClickOptions(FVector worldPosition);
	
	UFUNCTION(BlueprintCallable)
	static TSet<FIntVector> GetObstructingAreaIndices(FIntVector CameraIdx, const TSet<FIntVector>& TargetArea);
	
	UFUNCTION(BlueprintCallable)
	void SetObjectRuntimeProperty(FIntVector tilePosition, int32 objectIdx, UPARAM(ref) FName& Key, UPARAM(ref) FString& Value);
	
	UFUNCTION(BlueprintCallable)
	FRuntimeDataQueryResult GetObjectRuntimeProperty(FIntVector tilePosition, int32 objectIdx, FName& Key);
	
	UFUNCTION(BlueprintCallable)
	bool RemoveObjectRuntimeProperty(FIntVector tilePosition, int32 objectIdx, FName& Key);
	
	FSquareTile* GetSquareTilePtr(FIntVector tilePos);
	
	void ConvertRuntimeDataToInstanceData(FIntVector tilePosition, int32 objectIdx);
	
	UFUNCTION(BlueprintCallable, BlueprintNativeEvent)
	AActor* CreateNewChunk(FVector chunkLocation);
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TArray<FString> Logs;
	
	UFUNCTION(BlueprintCallable)
	void AddError(UObject* Source, FString Message);
	void FlushLogs();
	
	//Networking codeeeeee
	UFUNCTION(Server, Reliable, BlueprintCallable)
	void SV_PlaceObjectAtWorld(FVector Position, FTileObject newObject);
	
	UFUNCTION(Server, Reliable, BlueprintCallable)
	void SV_RemoveObjectAtWorldByID(FVector WorldPosition, FName ID);
	
	UFUNCTION(NetMulticast, Reliable, BlueprintCallable)
	void MUL_ChunkAddObject(FIntVector2 ChunkPosition, FIntVector SquarePosition, FTileObject Object);
	
	UFUNCTION(NetMulticast, Reliable, BlueprintCallable)
	void MUL_ChunkRemoveObjectByID(FVector WorldPosition, FIntVector SquarePosition, FName ID);
	
	UFUNCTION(Server, Reliable, BlueprintCallable)
    void SV_RequestChunkSync(FIntVector2 ChunkPosition, APlayerController* PlayerController);
};
