#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "ProceduralMeshComponent.h"
#include "KismetProceduralMeshLibrary.h"
#include "VoxelChunk.generated.h"

UENUM(BlueprintType)
enum class EVoxelType : uint8
{
	AIR,
	DIRT,
	GRASS,
	STONE,
};

static class MarchingCubes {

public:
	// Edge table for marching cubes - which edges are intersected
	static const int EdgeTable[256];

	// Triangle table - which triangles to generate for each configuration
	static const int TriTable[256][16];

	// Edge vertex positions (12 edges per cube)
	static const int32 EdgeVertices[12][2];
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

	float density = 0.0f;

	uint8 x;
	uint8 y;
	uint8 z;

	// Equality operator (required for TMap)
	bool operator==(const FVoxelPos& Other) const
	{
		return x == Other.x && y == Other.y && z == Other.z;
	}

	// Inequality operator
	bool operator!=(const FVoxelPos& Other) const
	{
		return !(*this == Other);
	}

	void SetDensity(float d)
	{
		density = d;
	}

	FString ToString() const
	{
		return FString::Printf(TEXT("(%d, %d, %d)"), x, y, z);
	}
};

// IMPORTANT: Add this GetTypeHash function OUTSIDE the struct definition
// This should be in the same header file as FVoxelPos, but outside the struct
FORCEINLINE uint32 GetTypeHash(const FVoxelPos& Pos)
{
	// Combine the hash values of x, y, z
	uint32 Hash = 0;
	Hash = HashCombine(Hash, GetTypeHash(Pos.x));
	Hash = HashCombine(Hash, GetTypeHash(Pos.y));
	Hash = HashCombine(Hash, GetTypeHash(Pos.z));
	return Hash;
};


USTRUCT(BlueprintType)
struct FVoxelData
{
	GENERATED_BODY()

	EVoxelType type;

	FVoxelData() {}

	void SetType(EVoxelType newType)
	{
		type = newType;
	}
};



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

	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float voxel_size = 48.0f;
	
	TMap<FVoxelPos, FVoxelData> voxelData;

	UFUNCTION(BlueprintCallable)
	bool IsVoxelPositionInBounds(FVoxelPos testPos);

	UFUNCTION()
	bool IsVoxelSolid(FVoxelPos pos);

	UFUNCTION(BlueprintCallable)
	bool AddVoxel(FVoxelPos position, EVoxelType type);

	UFUNCTION(BlueprintCallable)
	bool RemoveVoxel(FVoxelPos position);

	UFUNCTION(BlueprintCallable)
	void CreateMesh();

	float GetVoxelDensity(FVoxelPos pos);

	FVector CalculateGradient(FVector position);

	UFUNCTION(BlueprintCallable)
	void CreateSmoothMesh();

	virtual void Tick(float DeltaTime) override;
};