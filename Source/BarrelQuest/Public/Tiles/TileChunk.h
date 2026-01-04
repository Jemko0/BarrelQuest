#pragma once

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
	
	UFUNCTION(BlueprintCallable)
	void AddObject(FIntVector Position, const FTileObject& Object);
	
	UFUNCTION(BlueprintCallable)
	TArray<FTileObject>& GetObjectsOnSquare(FIntVector Position, bool& success);
	
	UFUNCTION(BlueprintCallable)
	FIntVector LocalToGlobalTileIndex(FIntVector LocalPosition);
	
	UFUNCTION(BlueprintCallable)
	const FSquareTile& GetSquareTile(FIntVector Position, bool& success);
	
	UFUNCTION(BlueprintCallable)
	bool HasSquare(FIntVector Position);
};