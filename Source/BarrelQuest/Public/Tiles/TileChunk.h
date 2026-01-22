#pragma once

#include "Components/HierarchicalInstancedStaticMeshComponent.h"
#include "Tiles/TileLibrary.h"
#include "TileChunk.generated.h"

UCLASS()
class BARRELQUEST_API ATileChunk : public AActor
{
	GENERATED_BODY()
	
public:
	
	ATileChunk();
	
	struct FObjectReference
	{
		FIntVector TilePosition;
		int32 ObjectArrayIndex; // Index in FSquareTile::objects
	};
	
	static constexpr int customDataFloats = (int)ETileInstanceDataIndex::MAX;
	
	TMap<FTileRenderKey, TArray<FObjectReference>> HISMReverseLookup;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FTileRenderKey, UHierarchicalInstancedStaticMeshComponent*> HISMMap;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FIntVector, FSquareTile> Tiles;
	
	UPROPERTY(BlueprintReadOnly, EditAnywhere)
	FIntVector2 ChunkPosition;
	
	UPROPERTY(BlueprintReadOnly)
	FVector TileSize = FVector(0, 0, 0);
	
	static FIntVector ChunkSize;
	
	UPROPERTY(ReplicatedUsing=OnRep_ReplicatedTiles)
	TArray<FTileEntry> ReplicatedTiles;
	
	///MUST be initialized please
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<TObjectPtr<URuntimeVirtualTexture>> RVTOutputs;
	
	// Called on clients when Tiles is updated
	UFUNCTION()
	void OnRep_ReplicatedTiles();
	
	void PrepareForReplication();

	virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;
protected:
	ATileManager* GetOwningTileManager() const;
public:
	
	UFUNCTION(BlueprintCallable, Category="Chunk Manipulation")
	void BuildChunk();
	
	void AddObjectInstance(const FIntVector& Position, int32 ObjectIndex, FTileObject& ObjectDef);
	void RemoveObjectInstance(const FTileObject& ObjectDef);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	FSquareTile& GetOrCreateSquareTile(FIntVector Position);
	
	UFUNCTION(BlueprintCallable, Category="Chunk Manipulation")
	FSquareTile& AddSquare(FIntVector Position, const FSquareTile& newSquare);
	
	///Directly sets a square, with objects, does not rebuild chunk automatically
	UFUNCTION(BlueprintCallable, Category="Chunk Manipulation")
	void SetSquare(FIntVector Position, const FSquareTile& squareTile);
	
	UFUNCTION(BlueprintCallable)
	void AddObject(FIntVector Position, const FTileObject& Object);
	
	UFUNCTION(BlueprintCallable)
	void RemoveObject(FIntVector Position, const FTileObject& Object);
	
	void AddObjectFeatures(FIntVector Position, FTileObject& Object, int32 NewObjectIndex);
	void RemoveObjectFeatures(FIntVector Position, int32 NewObjectIndex);
	
	void StoreNewFeature(const FStoredFeature& feature);

	TMap<FIntVector, FStoredFeatureArray> AttachedFeatures;
	
	UFUNCTION(BlueprintCallable)
	TArray<FTileObject>& GetObjectsOnSquare(FIntVector Position, bool& success);
	
	UFUNCTION(BlueprintCallable)
	FIntVector LocalToGlobalTileIndex(FIntVector LocalPosition);
	
	UFUNCTION(BlueprintCallable)
	const FSquareTile& GetSquareTile(FIntVector Position, bool& success);
	
	FSquareTile* GetSquareTilePtr(FIntVector Position, bool& success);
	
	UFUNCTION(BlueprintCallable)
	void RemoveSquareAt(FIntVector Position);
	
	UFUNCTION(BlueprintCallable)
	bool HasSquare(FIntVector Position);
	
	static TStaticArray<float, customDataFloats> GetCustomDataArray(const FTileDefinition& tileDef, const FTileObject& tileObject, const FSquareTile& tileSquare);
	
	UHierarchicalInstancedStaticMeshComponent* LazyCreateHISM(const FTileRenderKey& key, const FTileDefinition& tileDef);
	
	struct FRuntimeListenerObject
	{
		FIntVector squarePosition;
		int32 objectIndex;
		FDelegateHandle listenerHandle;
	};
	
	TMap<FIntVector, TArray<FRuntimeListenerObject>> perSquareHandles;
	
	void StoreRuntimeListener(FRuntimeListenerObject& listener);
	
	UFUNCTION(BlueprintCallable)
	void BindRuntimeData(FIntVector squarePosition, int32 objectIndex);
	
	UFUNCTION(BlueprintCallable)
	void UnbindRuntimeData(FIntVector squarePosition, int32 objectIndex);
	
	void OnTileObjectDataChanged(FIntVector squarePosition, int32 objectIndex, FName Key, const FString& Value);
};