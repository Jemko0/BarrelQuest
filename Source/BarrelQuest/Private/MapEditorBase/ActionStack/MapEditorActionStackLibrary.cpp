#include "MapEditorBase/ActionStack/MapEditorActionStackLibrary.h"

#include "Tiles/TileChunk.h"
#include "Tiles/TileManager.h"

namespace
{
bool FeaturesEqual(const TArray<FTileObjectFeature>& A, const TArray<FTileObjectFeature>& B)
{
	if (A.Num() != B.Num())
	{
		return false;
	}

	for (int32 Index = 0; Index < A.Num(); ++Index)
	{
		const FTileObjectFeature& Left = A[Index];
		const FTileObjectFeature& Right = B[Index];

		if (Left.FeatureClass != Right.FeatureClass
			|| Left.FeatureName != Right.FeatureName
			|| Left.AttachSocket != Right.AttachSocket
			|| !Left.RelativeTransform.Equals(Right.RelativeTransform))
		{
			return false;
		}
	}

	return true;
}

bool ObjectsEqual(const FTileObject& A, const FTileObject& B)
{
	return A.ID == B.ID
		&& A.Direction == B.Direction
		&& A.Mirrored == B.Mirrored
		&& A.runtimeData.Values() == B.runtimeData.Values()
		&& FeaturesEqual(A.Features, B.Features);
}

bool SquaresEqual(const FSquareTile& A, const FSquareTile& B)
{
	const TArray<FTileObject>& AObjects = A.GetReadOnlyObjects();
	const TArray<FTileObject>& BObjects = B.GetReadOnlyObjects();
	if (A.wallMask != B.wallMask
		|| A.flags != B.flags
		|| A.globalPosition != B.globalPosition
		|| AObjects.Num() != BObjects.Num())
	{
		return false;
	}

	for (int32 Index = 0; Index < AObjects.Num(); ++Index)
	{
		if (!ObjectsEqual(AObjects[Index], BObjects[Index]))
		{
			return false;
		}
	}

	return true;
}

void ResetRenderIndices(FSquareTile& Square)
{
	for (FTileObject& Object : Square.GetObjectsOnSquare())
	{
		Object.RenderInstanceIndex = -1;
		Object.runtimeData.OnChanged.Clear();
		Object.runtimeData.OnRemoved.Clear();
	}
}

void InvalidateRestoredArea(ATileManager* TileManager, const FIntVector& Position)
{
	if (!TileManager)
	{
		return;
	}

	TileManager->InvalidateRoomAt(Position);
	TileManager->InvalidateRoomAt(Position + FIntVector(1, 0, 0));
	TileManager->InvalidateRoomAt(Position + FIntVector(-1, 0, 0));
	TileManager->InvalidateRoomAt(Position + FIntVector(0, 1, 0));
	TileManager->InvalidateRoomAt(Position + FIntVector(0, -1, 0));
	TileManager->InvalidateRoomAt(Position + FIntVector(0, 0, 1));
	TileManager->InvalidateRoomAt(Position + FIntVector(0, 0, -1));
}

TMap<FIntVector, FMapSquareSnapshot> SnapshotArrayToMap(const TArray<FMapSquareSnapshot>& Snapshots, bool bKeepFirst)
{
	TMap<FIntVector, FMapSquareSnapshot> Result;
	for (const FMapSquareSnapshot& Snapshot : Snapshots)
	{
		if (bKeepFirst && Result.Contains(Snapshot.Position))
		{
			continue;
		}

		Result.Add(Snapshot.Position, Snapshot);
	}
	return Result;
}
}

FMapSquareSnapshot UMapEditorActionStackLibrary::CaptureSquare(ATileManager* TileManager, FIntVector Position)
{
	FMapSquareSnapshot Snapshot;
	Snapshot.Position = Position;
	Snapshot.Square = FSquareTile(Position);

	if (!TileManager)
	{
		return Snapshot;
	}

	bool bFound = false;
	const FSquareTile& Square = TileManager->GetSquareTileByTileIndex(Position, bFound);
	Snapshot.bExisted = bFound;
	if (bFound)
	{
		Snapshot.Square = Square;
		Snapshot.Square.globalPosition = Position;
		ResetRenderIndices(Snapshot.Square);
	}

	return Snapshot;
}

TArray<FMapSquareSnapshot> UMapEditorActionStackLibrary::CaptureSquares(ATileManager* TileManager, const TArray<FIntVector>& Positions)
{
	TArray<FMapSquareSnapshot> Snapshots;
	TSet<FIntVector> UniquePositions;
	UniquePositions.Append(Positions);
	Snapshots.Reserve(UniquePositions.Num());

	for (const FIntVector& Position : UniquePositions)
	{
		Snapshots.Add(CaptureSquare(TileManager, Position));
	}

	return Snapshots;
}

TArray<FIntVector> UMapEditorActionStackLibrary::ExpandPositionsForTileSideEffects(const TArray<FIntVector>& Positions)
{
	TSet<FIntVector> Expanded;

	for (const FIntVector& Position : Positions)
	{
		Expanded.Add(Position);
		Expanded.Add(Position + FIntVector(1, 0, 0));
		Expanded.Add(Position + FIntVector(-1, 0, 0));
		Expanded.Add(Position + FIntVector(0, 1, 0));
		Expanded.Add(Position + FIntVector(0, -1, 0));
		Expanded.Add(Position + FIntVector(0, 0, 1));
		Expanded.Add(Position + FIntVector(0, 0, -1));
	}

	return Expanded.Array();
}

bool UMapEditorActionStackLibrary::MakeActionFromSnapshots(const FString& Label,
	const TArray<FMapSquareSnapshot>& BeforeSnapshots, const TArray<FMapSquareSnapshot>& AfterSnapshots,
	FMapEditAction& OutAction)
{
	OutAction = FMapEditAction();
	OutAction.Label = Label;

	const TMap<FIntVector, FMapSquareSnapshot> BeforeByPosition = SnapshotArrayToMap(BeforeSnapshots, true);
	const TMap<FIntVector, FMapSquareSnapshot> AfterByPosition = SnapshotArrayToMap(AfterSnapshots, false);

	TSet<FIntVector> Positions;
	for (const TPair<FIntVector, FMapSquareSnapshot>& Pair : BeforeByPosition)
	{
		Positions.Add(Pair.Key);
	}
	for (const TPair<FIntVector, FMapSquareSnapshot>& Pair : AfterByPosition)
	{
		Positions.Add(Pair.Key);
	}

	for (const FIntVector& Position : Positions)
	{
		const FMapSquareSnapshot* Before = BeforeByPosition.Find(Position);
		const FMapSquareSnapshot* After = AfterByPosition.Find(Position);

		FMapSquareSnapshot EmptyBefore;
		EmptyBefore.Position = Position;
		EmptyBefore.Square = FSquareTile(Position);
		FMapSquareSnapshot EmptyAfter;
		EmptyAfter.Position = Position;
		EmptyAfter.Square = FSquareTile(Position);

		const FMapSquareSnapshot& BeforeRef = Before ? *Before : EmptyBefore;
		const FMapSquareSnapshot& AfterRef = After ? *After : EmptyAfter;

		if (!SnapshotsEqual(BeforeRef, AfterRef))
		{
			FMapTileChange Change;
			Change.Before = BeforeRef;
			Change.After = AfterRef;
			OutAction.Changes.Add(Change);
		}
	}

	return OutAction.Changes.Num() > 0;
}

bool UMapEditorActionStackLibrary::RestoreSquare(ATileManager* TileManager, const FMapSquareSnapshot& Snapshot)
{
	if (!TileManager)
	{
		return false;
	}

	const FVector WorldPosition = UTileLibrary::TileToWorldPosition(Snapshot.Position);
	const FIntVector2 ChunkPosition = UTileLibrary::WorldToChunkPosition(WorldPosition);
	ATileChunk* Chunk = TileManager->GetChunkAt(ChunkPosition);

	if (!Snapshot.bExisted)
	{
		if (Chunk)
		{
			Chunk->ClearSquareForRestore(Snapshot.Position);
			InvalidateRestoredArea(TileManager, Snapshot.Position);
		}
		return true;
	}

	if (!Chunk)
	{
		Chunk = TileManager->SpawnChunk(ChunkPosition);
	}

	if (!Chunk)
	{
		return false;
	}

	FSquareTile RestoredSquare = Snapshot.Square;
	RestoredSquare.globalPosition = Snapshot.Position;
	ResetRenderIndices(RestoredSquare);

	Chunk->ReplaceSquare(Snapshot.Position, RestoredSquare);
	InvalidateRestoredArea(TileManager, Snapshot.Position);
	return true;
}

bool UMapEditorActionStackLibrary::ApplyAction(ATileManager* TileManager, const FMapEditAction& Action)
{
	bool bAppliedAny = false;
	for (const FMapTileChange& Change : Action.Changes)
	{
		bAppliedAny |= RestoreSquare(TileManager, Change.After);
	}
	return bAppliedAny;
}

bool UMapEditorActionStackLibrary::UndoAction(ATileManager* TileManager, const FMapEditAction& Action)
{
	bool bUndidAny = false;
	for (const FMapTileChange& Change : Action.Changes)
	{
		bUndidAny |= RestoreSquare(TileManager, Change.Before);
	}
	return bUndidAny;
}

bool UMapEditorActionStackLibrary::SnapshotsEqual(const FMapSquareSnapshot& A, const FMapSquareSnapshot& B)
{
	if (A.Position != B.Position || A.bExisted != B.bExisted)
	{
		return false;
	}

	if (!A.bExisted && !B.bExisted)
	{
		return true;
	}

	return SquaresEqual(A.Square, B.Square);
}
