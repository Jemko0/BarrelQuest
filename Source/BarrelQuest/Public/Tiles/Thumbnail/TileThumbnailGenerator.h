#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "TimerManager.h"
#include "Tiles/TileLibrary.h"
#include "TileThumbnailGenerator.generated.h"

class USceneCaptureComponent2D;
class UStaticMeshComponent;
class UInstancedStaticMeshComponent;
class UTextureRenderTarget2D;
class ATileManager;

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FOnTileThumbnailGenerationFinished, int32, GeneratedCount, int32, RegisteredCount);

UCLASS()
class BARRELQUEST_API ATileThumbnailGenerator : public AActor
{
	GENERATED_BODY()

public:
	ATileThumbnailGenerator();

	virtual void Tick(float DeltaSeconds) override;

	UFUNCTION(BlueprintCallable, Category="Tile Thumbnails")
	void GenerateTileThumbnails(bool bRegenerateExisting = false);

	UFUNCTION(BlueprintCallable, Category="Tile Thumbnails")
	void StopGeneratingTileThumbnails();

	UFUNCTION(BlueprintPure, Category="Tile Thumbnails")
	bool IsGeneratingTileThumbnails() const;

	UFUNCTION(BlueprintPure, Category="Tile Thumbnails")
	int32 GetRemainingThumbnailCount() const;

	UPROPERTY(BlueprintAssignable, Category="Tile Thumbnails")
	FOnTileThumbnailGenerationFinished OnTileThumbnailGenerationFinished;

protected:
	virtual void BeginPlay() override;

private:
	enum class EGenerationPhase : uint8
	{
		Idle,
		Setup,
		Capture,
		Export
	};

	struct FPendingTileThumbnail
	{
		FName TileID;
		FTileDefinition TileDefinition;
		FString FileName;
		FString FullFilePath;
	};

	UPROPERTY(VisibleAnywhere)
	TObjectPtr<USceneComponent> SceneRoot;

	UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	TObjectPtr<UStaticMeshComponent> MeshComponent;

	UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	TObjectPtr<UInstancedStaticMeshComponent> InstanceMeshComponent;

	UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	TObjectPtr<USceneCaptureComponent2D> SceneCaptureComponent;

	UPROPERTY(EditAnywhere, Category="Tile Thumbnails")
	TObjectPtr<UDataTable> TileDataTable;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	TObjectPtr<ATileManager> TileManager;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	bool bIncludeUserDefinedTiles = true;

	UPROPERTY(EditAnywhere, Category="Tile Thumbnails")
	TObjectPtr<UTextureRenderTarget2D> RenderTarget;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	int32 ThumbnailSize = 512;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true"))
	FLinearColor ThumbnailBackgroundColor = FLinearColor::White;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true", ClampMin="1.0"))
	float BoundsPadding = 1.25f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails", meta=(AllowPrivateAccess="true", ClampMin="1.0"))
	float MinimumOrthoWidth = 250.0f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails|Debug", meta=(AllowPrivateAccess="true"))
	bool bLogThumbnailGeneration = true;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category="Tile Thumbnails|Debug", meta=(AllowPrivateAccess="true", ClampMin="0"))
	int32 MaxVerboseTileLogs = 25;

	UPROPERTY(EditAnywhere, Category="Tile Thumbnails")
	TObjectPtr<UMaterialInterface> DefaultThumbnailMaterial;

	UPROPERTY(EditAnywhere, Category="Tile Thumbnails")
	float CaptureDelaySeconds = 0.0f;

	UPROPERTY()
	TObjectPtr<UMaterialInstanceDynamic> ActiveMID;

	UPROPERTY()
	TObjectPtr<UTextureRenderTarget2D> RuntimeRenderTarget;

	UPROPERTY()
	TArray<TObjectPtr<UObject>> RetainedPreloadedAssets;

	TArray<FPendingTileThumbnail> PendingTiles;
	FPendingTileThumbnail ActiveTile;
	EGenerationPhase GenerationPhase = EGenerationPhase::Idle;
	float PhaseDelayRemaining = 0.0f;
	bool bGenerateMissingOnly = true;
	int32 GeneratedThumbnailCount = 0;
	int32 RegisteredThumbnailCount = 0;
	int32 VerboseTileLogCount = 0;
	FTimerHandle GenerationTimerHandle;

	void PreloadThumbnailAssets();
	void EnsureRenderTarget();
	void BuildPendingTileList();
	void AddPendingTile(FName TileID, const FTileDefinition& TileDefinition, const FString& ThumbnailDirectory);
	ATileManager* ResolveTileManager() const;
	void ApplyTileInstanceCustomData(const FTileDefinition& TileDefinition);
	void FitCaptureToMeshBounds(UStaticMesh* Mesh, ETileCategory Category);
	bool ShouldLogTileVerbose() const;
	void ScheduleNextGenerationStep(float DelaySeconds = 0.0f);
	void AdvanceGenerationStep();
	void SetupNextTile();
	void CaptureActiveTile();
	void ExportActiveTile();
	void FinishGeneration();
	void LoadDefaultThumbnailAssets();

	UStaticMesh* ResolveMeshForDefinition(const FTileDefinition& TileDefinition) const;
	UMaterialInterface* ResolveMaterialForDefinition(const FTileDefinition& TileDefinition) const;
	static FString GetThumbnailDirectory();
	static FString MakeThumbnailFileName(FName TileID);
	static FString SanitizeTileIDForFileName(const FString& TileID);
};
