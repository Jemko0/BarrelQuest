#include "Tiles/Thumbnail/TileThumbnailSubsystem.h"

#include "HAL/FileManager.h"
#include "Misc/Paths.h"

void UTileThumbnailSubsystem::ClearTileThumbnails()
{
	TileThumbnailPaths.Empty();
}

void UTileThumbnailSubsystem::RegisterTileThumbnail(FName TileID, const FString& FullFilePath)
{
	if (TileID.IsNone() || FullFilePath.IsEmpty())
	{
		return;
	}

	TileThumbnailPaths.Add(TileID, FPaths::ConvertRelativePathToFull(FullFilePath));
}

bool UTileThumbnailSubsystem::GetTileThumbnailPath(FName TileID, FString& FullFilePath) const
{
	if (const FString* FoundPath = TileThumbnailPaths.Find(TileID))
	{
		FullFilePath = *FoundPath;
		return true;
	}

	FullFilePath.Reset();
	return false;
}

const TMap<FName, FString>& UTileThumbnailSubsystem::GetTileThumbnailPaths() const
{
	return TileThumbnailPaths;
}

void UTileThumbnailSubsystem::ScanSavedTileThumbnails()
{
	TileThumbnailPaths.Empty();

	const FString ThumbnailDirectory = FPaths::Combine(FPaths::ProjectSavedDir(), TEXT("Thumbnails/Tiles"));
	TArray<FString> Files;
	IFileManager::Get().FindFiles(Files, *FPaths::Combine(ThumbnailDirectory, TEXT("*.png")), true, false);

	for (const FString& FileName : Files)
	{
		const FString TileIDString = FPaths::GetBaseFilename(FileName);
		RegisterTileThumbnail(FName(*TileIDString), FPaths::Combine(ThumbnailDirectory, FileName));
	}
}
