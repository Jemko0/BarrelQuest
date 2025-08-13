#include "Voxel/VoxelChunk.h"

// Sets default values
AVoxelChunk::AVoxelChunk()
{
	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

	// Create and register the procedural mesh component
	ProceduralMesh = CreateDefaultSubobject<UProceduralMeshComponent>(TEXT("ProceduralMesh"));
	RootComponent = ProceduralMesh;

	// Optional: Set default collision settings
	ProceduralMesh->SetCollisionEnabled(ECollisionEnabled::QueryAndPhysics);
	ProceduralMesh->SetCollisionResponseToAllChannels(ECR_Block);
}

// Called when the game starts or when spawned
void AVoxelChunk::BeginPlay()
{
	Super::BeginPlay();
}

bool AVoxelChunk::IsVoxelPositionInBounds(FVoxelPos testPos)
{
	return testPos.x < chunk_size && testPos.y < chunk_size && testPos.z < chunk_size;
}

bool AVoxelChunk::AddVoxel(FVoxelPos pos, EVoxelType type)
{
	if (!IsVoxelPositionInBounds(pos))
	{
		return false;
	}

	FVoxelData newVoxel = FVoxelData();
	newVoxel.SetType(type);
	voxelData.Add(pos, newVoxel);
	return true;
}

//same as AddVoxel() but it just sets the voxel to air
bool AVoxelChunk::RemoveVoxel(FVoxelPos pos)
{
	if (!IsVoxelPositionInBounds(pos))
	{
		return false;
	}

	FVoxelData newVoxel = FVoxelData();
	newVoxel.SetType(EVoxelType::AIR);
	voxelData.Add(pos, newVoxel);
	return true;
}

void AVoxelChunk::CreateMesh()
{
	TArray<FVector> vertices;
	TArray<int32>	triangles;

	for (int ix = 0; ix < chunk_size; ix++)
	{
		for (int iy = 0; iy < chunk_size; iy++)
		{
			for (int iz = 0; iz < chunk_size; iz++)
			{
				
			}
		}
	}
}

// Called every frame
void AVoxelChunk::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
}