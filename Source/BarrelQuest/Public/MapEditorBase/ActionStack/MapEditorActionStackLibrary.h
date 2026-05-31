// 

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "Tiles/TileLibrary.h"
#include "MapEditorActionStackLibrary.generated.h"

/**
 * 
 */

class ATileManager;

USTRUCT(BlueprintType)
struct FMapSquareSnapshot
{
	GENERATED_BODY()

public:
	UPROPERTY(BlueprintReadWrite)
	FIntVector Position = FIntVector::ZeroValue;

	UPROPERTY(BlueprintReadWrite)
	bool bExisted = false;

	UPROPERTY(BlueprintReadWrite)
	FSquareTile Square;
};

USTRUCT(BlueprintType)
struct FMapTileChange
{
	GENERATED_BODY()

public:
	UPROPERTY(BlueprintReadWrite)
	FMapSquareSnapshot Before;

	UPROPERTY(BlueprintReadWrite)
	FMapSquareSnapshot After;
};

USTRUCT(BlueprintType)
struct FMapEditAction
{
	GENERATED_BODY()

public:
	UPROPERTY(BlueprintReadWrite)
	FString Label;

	UPROPERTY(BlueprintReadWrite)
	TArray<FMapTileChange> Changes;
};


UCLASS()
class BARRELQUEST_API UMapEditorActionStackLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static FMapSquareSnapshot CaptureSquare(ATileManager* TileManager, FIntVector Position);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static TArray<FMapSquareSnapshot> CaptureSquares(ATileManager* TileManager, const TArray<FIntVector>& Positions);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static TArray<FIntVector> ExpandPositionsForTileSideEffects(const TArray<FIntVector>& Positions);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static bool MakeActionFromSnapshots(const FString& Label, const TArray<FMapSquareSnapshot>& BeforeSnapshots,
		const TArray<FMapSquareSnapshot>& AfterSnapshots, FMapEditAction& OutAction);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static bool RestoreSquare(ATileManager* TileManager, const FMapSquareSnapshot& Snapshot);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static bool ApplyAction(ATileManager* TileManager, const FMapEditAction& Action);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	static bool UndoAction(ATileManager* TileManager, const FMapEditAction& Action);

	UFUNCTION(BlueprintPure, Category="Map Editor|Action Stack")
	static bool SnapshotsEqual(const FMapSquareSnapshot& A, const FMapSquareSnapshot& B);
};
