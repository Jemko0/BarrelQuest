

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "Tiles/TileLibrary.h"
#include "TileManager.generated.h"

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
	
	virtual void GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const override;
public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;
	
	const FSquareTile fallbackSquareTile = FSquareTile();

	UFUNCTION(BlueprintCallable)
	ATileChunk* GetChunkAt(FIntVector2 Position);
	
	UFUNCTION(BlueprintCallable)
	const FSquareTile& GetSquareTile(FVector WorldPosition, bool& success);
	
	UFUNCTION(BlueprintCallable)
	ATileChunk* GetChunkAtWorld(FVector WorldPosition);
	
	UFUNCTION()
	void OnRep_Chunks();
	
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
