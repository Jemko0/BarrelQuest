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
	
	UPROPERTY(EditAnywhere, ReplicatedUsing=OnRep_Chunks)
	TArray<ATileChunk*> Chunks;

	UPROPERTY(EditAnywhere)
	TMap<FIntVector2, ATileChunk*> ChunkLookup;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UDataTable* TileDataTable;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TMap<FIntVector, int> Rooms;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TMap<int, FRoomValue> RoomsLookup;
	
	virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;
public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;
	
	const FSquareTile constFallbackSquareTile = FSquareTile();
	FSquareTile fallbackSquareTile = FSquareTile();

	UFUNCTION(BlueprintCallable)
	ATileChunk* GetChunkAt(FIntVector2 Position);
	
	void FindRoom(FVector worldPosition);
	
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
	void AddRoomTile(FIntVector tilePosition, int roomID);
	
	UFUNCTION()
	void OnRep_Chunks();
	
	///Sets the instance data property for all objects on a square, returns true if succeeded
	UFUNCTION(BlueprintCallable)
	bool SetInstanceDataByTileIndex(FIntVector tilePosition, ETileInstanceDataIndex propertyIndex, float newPropValue);
	
	UFUNCTION(BlueprintCallable)
	bool HasCeilingAt(FIntVector pos);
	
	///Places a TileObject at the world position, if the square doesn't exist, it will create it.
	/// If the chunk doesn't exist, it will create it. If it cant be placed, will return false
	UFUNCTION(BlueprintCallable)
	bool PlaceObjectAtWorld(FVector worldPosition, FTileObject newObject);
	
	UFUNCTION(BlueprintCallable)
	ATileChunk* SpawnChunk(FIntVector2 Position);
	
	UFUNCTION(BlueprintCallable)
	FTileDefinition GetTileByID(FName ID);
	
	UFUNCTION(BlueprintCallable)
	bool SquareHasObjectOfCategory(FVector worldPosition, ETileCategory category);
	
	UFUNCTION(BlueprintCallable)
	bool SquareHasObjectOfCategoryAndRotation(FVector worldPosition, ETileCategory category, ETileDirection rotation);
};
