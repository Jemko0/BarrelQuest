#pragma once

#include "RightClickInterface.h"
#include "Components/HierarchicalInstancedStaticMeshComponent.h"
#include "Interactable/InteractableInterface.h"
#include "Net/TileNetworkLibrary.h"
#include "Tiles/TileLibrary.h"
#include "Types/TReplicatedMap.h"
#include "TileChunk.generated.h"

//DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnChunkError, FString, msg);

UCLASS()
class BARRELQUEST_API ATileChunk : public AActor, public IRightClickInterface, public IInteractableInterface
{
	GENERATED_BODY()
	
public:
	
	ATileChunk();
	
	struct FObjectReference
	{
		FIntVector TilePosition;
		int32 ObjectArrayIndex; // Index in FSquareTile::objects
	};
	
	/*RCM Interface*/
	virtual TArray<FRCMOption> GetRCMOptions_Implementation(FVector Location) override;
	virtual void SendRCMInvoke_Implementation(const FString& invokeID, TMap<FName, FRCMInvokeMessage>& payload) override;
	
	/*Interactable Interface*/
	virtual TArray<FIntVector> GetTileInteractionPoints_Implementation(FVector FromWorld, float Range) override;
	
	static constexpr int customDataFloats = (int)ETileInstanceDataIndex::MAX;
	
	TMap<FTileRenderKey, TArray<FObjectReference>> HISMReverseLookup;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FTileRenderKey, UHierarchicalInstancedStaticMeshComponent*> HISMMap;
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite, ReplicatedUsing=OnRep_TileKeys)
	TArray<FIntVector> TileKeys;
	
	UFUNCTION()
	void OnRep_TileKeys();
	
	UPROPERTY(Replicated, EditAnywhere, BlueprintReadWrite)
	TArray<FSquareTile> TileValues;
	
	TReplicatedMap<FIntVector, FSquareTile> Tiles{TileKeys, TileValues};
	
	//UPROPERTY(BlueprintReadOnly, EditAnywhere)
	//TMap<FIntVector, FSquareTile> Tiles;
	
	UPROPERTY(Replicated, BlueprintReadOnly, EditAnywhere)
	FIntVector2 ChunkPosition;
	
	UPROPERTY(BlueprintReadOnly)
	FVector TileSize = FVector(0, 0, 0);
	
	/*UPROPERTY(BlueprintAssignable, BlueprintReadOnly, EditAnywhere)
	FOnChunkError OnChunkError;*/
	
	static FIntVector ChunkSize;
	
	///MUST be initialized please
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<TObjectPtr<URuntimeVirtualTexture>> RVTOutputs;

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
	
	UFUNCTION(BlueprintCallable)
	void SetTiles(const TArray<FIntVector>& tilePositions, const TArray<FSquareTile>& tileSquares);
	
	UFUNCTION(BlueprintCallable, Category="Chunk Manipulation")
	FSquareTile& AddSquare(FIntVector Position, const FSquareTile& newSquare);
	
	UFUNCTION(BlueprintCallable, Category="Tile Objects")
	void SetObjectRuntimeData(FIntVector Position, int32 objectIndex, FName Key, const FString& Value);
	
	///Directly sets a square, with objects, does not rebuild chunk automatically
	UFUNCTION(BlueprintCallable, Category="Chunk Manipulation")
	void SetSquare(FIntVector Position, const FSquareTile& squareTile);
	
	UFUNCTION(BlueprintCallable)
	void AddObject(FIntVector Position, FTileObject& Object);
	
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
	void ReportError(FString msg);
	
	UFUNCTION(BlueprintCallable)
	bool HasSquare(FIntVector Position);
	
	UFUNCTION(BlueprintCallable)
	FStoredFeatureArray FindAllFeaturesForObject(FIntVector squareIdx, int32 objIdx);
	
	void ResetChunkState();

	UFUNCTION(BlueprintPure, Category="Memory")
	int64 GetEstimatedMemoryUsageBytes() const;
	
	static TStaticArray<float, customDataFloats> GetCustomDataArray(const FTileDefinition& tileDef, const FTileObject& tileObject, const FSquareTile& tileSquare, UTileTextureRegistry* TileTextureRegistry = nullptr);
	
	UStaticMesh* ResolveMeshForTileDefinition(const FTileDefinition& tileDef) const;
	
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
	
	TMap<FName, TFunction<void(FIntVector, int32, FName, FString)>> funcMap;
	
	void ApplyAllDataForObject(FIntVector position, int32 objectIndex, FTileObject& objectRef);
	void InitializeFuncMap();
	void OnTileObjectDataChanged(FIntVector squarePosition, int32 objectIndex, FName Key, const FString& Value);
	
	UFUNCTION(BlueprintNativeEvent)
	void OnObjectUnhandledDataChanged(FName Key, const FString& Value);
	
	UFUNCTION(BlueprintCallable)
	void SetObjectInstanceData(FIntVector square, int32 objectIndex, ETileInstanceDataIndex propIndex, float propValue);
	
	//runtime data functions
	void ApplyTintOverride(FIntVector square, int32 objectIndex, FName Key, const FString& Value);
	void ApplyInteriorTintOverride(FIntVector square, int32 objectIndex, FName Key, const FString& Value);
};
