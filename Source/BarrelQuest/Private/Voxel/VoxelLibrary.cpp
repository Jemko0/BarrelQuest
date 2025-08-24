
#include "Voxel/VoxelLibrary.h"
#include "../Public/Voxel/VoxelLibrary.h"

FVoxelPos UVoxelLibrary::MakeVoxelPos(uint8 x, uint8 y, uint8 z)
{
	return FVoxelPos(x, y, z);
}

void UVoxelLibrary::BreakVoxelPos(FVoxelPos& s, uint8& x, uint8& y, uint8& z)
{
	x = s.x;
	y = s.y;
	z = s.z;
}
