#pragma once

#include "CoreMinimal.h"
#include "Subsystems/GameInstanceSubsystem.h"
#include "TileThumbnailSubsystem.generated.h"

UCLASS()
class BARRELQUEST_API UTileThumbnailSubsystem : public UGameInstanceSubsystem
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category="Tile Thumbnails")
	void ClearTileThumbnails();

	UFUNCTION(BlueprintCallable, Category="Tile Thumbnails")
	void RegisterTileThumbnail(FName TileID, const FString& FullFilePath);

	UFUNCTION(BlueprintPure, Category="Tile Thumbnails")
	bool GetTileThumbnailPath(FName TileID, FString& FullFilePath) const;

	UFUNCTION(BlueprintPure, Category="Tile Thumbnails")
	const TMap<FName, FString>& GetTileThumbnailPaths() const;

	UFUNCTION(BlueprintCallable, Category="Tile Thumbnails")
	void ScanSavedTileThumbnails();

private:
	UPROPERTY()
	TMap<FName, FString> TileThumbnailPaths;
};
