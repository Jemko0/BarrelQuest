#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "ProceduralMeshComponent.h"
#include "VoxelChunk.generated.h"

UENUM(BlueprintType)
enum class EVoxelType : uint8
{
	AIR,
	DIRT,
	GRASS,
	STONE,
};

USTRUCT(BlueprintType)
struct FVoxelPos
{
	GENERATED_BODY()

	FVoxelPos() {};

	FVoxelPos(uint8 newX, uint8 newY, uint8 newZ)
	{
		x = newX;
		y = newY;
		z = newZ;
	};

	uint8 x;
	uint8 y;
	uint8 z;
}

USTRUCT(BlueprintType)
struct FVoxelData
{
	GENERATED_BODY()

	EVoxelType type;

	FVoxelData(){}

	void SetType(EVoxelType newType)
	{
		type = newType;
	}
}



UCLASS()
class BARRELQUEST_API AVoxelChunk : public AActor
{
	GENERATED_BODY()

public:
	// Sets default values for this actor's properties
	AVoxelChunk();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

	// Procedural mesh component for rendering voxel geometry
	UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Voxel")
	class UProceduralMeshComponent* ProceduralMesh;

public:
	//Chunk size in Indices, 32 meaning xyz 0 to xyz 32
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	uint8 chunk_size = 32;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Voxel")
	TMap<FVoxelPos, FVoxelData> voxelData;

	UFUNCTION(BlueprintCallable)
	bool IsVoxelPositionInBounds(FVoxelPos testPos);

	UFUNCTION(BlueprintCallable)
	bool AddVoxel(FVoxelPos position, EVoxelType type);

	UFUNCTION(BlueprintCallable)
	bool RemoveVoxel(FVoxelPos position);

	UFUNCTION(BlueprintCallable)
	void CreateMesh();

	virtual void Tick(float DeltaTime) override;
};