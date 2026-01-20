#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "Tiles/TileLibrary.h"
#include "TileManager.generated.h"

class ATileChunk;

UCLASS()
class BARRELQUEST_API ATileManager : public AActor
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
	
	static UDataTable* TileDataTable;
	
protected:
	UPROPERTY(EditAnywhere)
	TMap<FIntVector2, ATileChunk*> ChunkLookup;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TMap<FIntVector, int> RoomTilesToID;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TMap<int, FRoomValue> RoomIDToTiles;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<TObjectPtr<URuntimeVirtualTexture>> ChunkRVTs;
	
	virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;
public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;
	
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
	bool PlaceObjectAtWorld(FVector worldPosition, FTileObject newObject);
	
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
	
	UFUNCTION(BlueprintCallable)
	static FTileDefinition GetTileByID(FName ID);
	
	UFUNCTION(BlueprintCallable)
	bool SquareHasObjectOfCategory(FVector worldPosition, ETileCategory category);
	
	UFUNCTION(BlueprintCallable)
	bool SquareHasObjectOfCategoryAndRotation(FVector worldPosition, ETileCategory category, ETileDirection rotation);
	
	UFUNCTION(BlueprintCallable)
	TArray<FIntVector> Raycast(FIntVector start, FIntVector end);
	
	UFUNCTION(BlueprintCallable)
	TArray<FIntVector> ThickRaycast(FIntVector start, FIntVector end, int32 thickness);
	
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
};
