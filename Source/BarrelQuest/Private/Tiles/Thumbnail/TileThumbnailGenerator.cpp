#include "Tiles/Thumbnail/TileThumbnailGenerator.h"

#include "Components/InstancedStaticMeshComponent.h"
#include "Components/SceneCaptureComponent2D.h"
#include "Components/StaticMeshComponent.h"
#include "Engine/DataTable.h"
#include "Engine/Texture2DArray.h"
#include "Engine/TextureRenderTarget2D.h"
#include "Engine/World.h"
#include "EngineUtils.h"
#include "HAL/FileManager.h"
#include "Kismet/KismetRenderingLibrary.h"
#include "Materials/MaterialInstanceDynamic.h"
#include "Misc/Paths.h"
#include "RenderingThread.h"
#include "Tiles/TileManager.h"
#include "Tiles/Thumbnail/TileThumbnailSubsystem.h"
#include "Tiles/UserResources/TileTextureRegistry.h"
#include "TimerManager.h"

namespace
{
	bool IsThumbnailTileAssetHandleSet(const FTileSavedAssetHandle& Handle)
	{
		return Handle.Kind != ERegisteredAssetType::None || !Handle.Id.IsEmpty() || Handle.AssetPath.IsValid() || !Handle.Url.IsEmpty();
	}
}

ATileThumbnailGenerator::ATileThumbnailGenerator()
{
	PrimaryActorTick.bCanEverTick = true;
	PrimaryActorTick.bStartWithTickEnabled = true;

	SceneRoot = CreateDefaultSubobject<USceneComponent>(TEXT("Root"));
	SetRootComponent(SceneRoot);

	MeshComponent = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));
	MeshComponent->SetupAttachment(SceneRoot);
	MeshComponent->SetCollisionEnabled(ECollisionEnabled::NoCollision);
	MeshComponent->SetHiddenInGame(true);

	InstanceMeshComponent = CreateDefaultSubobject<UInstancedStaticMeshComponent>(TEXT("ThumbnailInstanceMesh"));
	InstanceMeshComponent->SetupAttachment(SceneRoot);
	InstanceMeshComponent->SetCollisionEnabled(ECollisionEnabled::NoCollision);
	InstanceMeshComponent->SetNumCustomDataFloats(static_cast<int32>(ETileInstanceDataIndex::MAX));

	SceneCaptureComponent = CreateDefaultSubobject<USceneCaptureComponent2D>(TEXT("SceneCapture"));
	SceneCaptureComponent->SetupAttachment(SceneRoot);
	SceneCaptureComponent->ProjectionType = ECameraProjectionMode::Orthographic;
	SceneCaptureComponent->CaptureSource = SCS_FinalColorLDR;
	SceneCaptureComponent->PrimitiveRenderMode = ESceneCapturePrimitiveRenderMode::PRM_UseShowOnlyList;
	SceneCaptureComponent->bCaptureEveryFrame = false;
	SceneCaptureComponent->bCaptureOnMovement = false;
	SceneCaptureComponent->ShowFlags.Lighting = false;
	SceneCaptureComponent->ShowFlags.PostProcessing = false;
	SceneCaptureComponent->ShowFlags.Atmosphere = false;
	SceneCaptureComponent->ShowFlags.Fog = false;
	SceneCaptureComponent->ShowFlags.SkyLighting = false;
	SceneCaptureComponent->SetRelativeRotation(FRotator(-25.0f, 45.0f, 0.0f));
	SceneCaptureComponent->ShowOnlyComponent(InstanceMeshComponent);

	static ConstructorHelpers::FObjectFinder<UDataTable> DefaultTileDataTable(TEXT("/Game/BarrelContent/Tiles/Data/New/CompositeTileDefinitions.CompositeTileDefinitions"));
	if (DefaultTileDataTable.Succeeded())
	{
		TileDataTable = DefaultTileDataTable.Object;
	}

	static ConstructorHelpers::FObjectFinder<UTextureRenderTarget2D> DefaultRenderTarget(TEXT("/Game/BarrelContent/Materials/RT/ThumbnailRT.ThumbnailRT"));
	if (DefaultRenderTarget.Succeeded())
	{
		RenderTarget = DefaultRenderTarget.Object;
	}

	static ConstructorHelpers::FObjectFinder<UMaterialInterface> DefaultMaterial(TEXT("/Game/BarrelContent/Materials/Shaders/ObscureMaterialBase.ObscureMaterialBase"));
	if (DefaultMaterial.Succeeded())
	{
		DefaultThumbnailMaterial = DefaultMaterial.Object;
	}
}

void ATileThumbnailGenerator::BeginPlay()
{
	Super::BeginPlay();

	if (RenderTarget)
	{
		EnsureRenderTarget();
	}
}

void ATileThumbnailGenerator::Tick(float DeltaSeconds)
{
	Super::Tick(DeltaSeconds);
}

void ATileThumbnailGenerator::GenerateTileThumbnails(bool bRegenerateExisting)
{
	SetActorTickEnabled(true);

	if (!TileDataTable)
	{
		TileDataTable = LoadObject<UDataTable>(nullptr, TEXT("/Game/BarrelContent/Tiles/Data/New/CompositeTileDefinitions.CompositeTileDefinitions"));
	}

	EnsureRenderTarget();

	if (!SceneCaptureComponent->TextureTarget || !TileDataTable)
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: Missing RenderTarget or TileDataTable. RenderTarget=%s TileDataTable=%s"),
			SceneCaptureComponent->TextureTarget ? *SceneCaptureComponent->TextureTarget->GetPathName() : TEXT("<null>"),
			TileDataTable ? *TileDataTable->GetPathName() : TEXT("<null>"));
		GeneratedThumbnailCount = 0;
		RegisteredThumbnailCount = 0;
		OnTileThumbnailGenerationFinished.Broadcast(GeneratedThumbnailCount, RegisteredThumbnailCount);
		return;
	}

	bGenerateMissingOnly = !bRegenerateExisting;

	IFileManager::Get().MakeDirectory(*GetThumbnailDirectory(), true);
	GeneratedThumbnailCount = 0;
	RegisteredThumbnailCount = 0;
	VerboseTileLogCount = 0;
	PreloadThumbnailAssets();
	BuildPendingTileList();

	UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: Generate started. Directory='%s' DataTable='%s' Rows=%d Pending=%d RegenerateExisting=%s"),
		*GetThumbnailDirectory(),
		*TileDataTable->GetPathName(),
		TileDataTable->GetRowMap().Num(),
		PendingTiles.Num(),
		bRegenerateExisting ? TEXT("true") : TEXT("false"));

	if (UTileThumbnailSubsystem* ThumbnailSubsystem = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileThumbnailSubsystem>() : nullptr)
	{
		ThumbnailSubsystem->ScanSavedTileThumbnails();
		RegisteredThumbnailCount = ThumbnailSubsystem->GetTileThumbnailPaths().Num();
	}

	if (PendingTiles.IsEmpty())
	{
		GenerationPhase = EGenerationPhase::Setup;
		ScheduleNextGenerationStep();
		return;
	}

	GenerationPhase = EGenerationPhase::Setup;
	ScheduleNextGenerationStep();
}

void ATileThumbnailGenerator::StopGeneratingTileThumbnails()
{
	if (UWorld* World = GetWorld())
	{
		World->GetTimerManager().ClearTimer(GenerationTimerHandle);
	}

	GenerationPhase = EGenerationPhase::Idle;
	PendingTiles.Empty();
	ActiveMID = nullptr;
}

bool ATileThumbnailGenerator::IsGeneratingTileThumbnails() const
{
	return GenerationPhase != EGenerationPhase::Idle;
}

int32 ATileThumbnailGenerator::GetRemainingThumbnailCount() const
{
	return PendingTiles.Num() + (GenerationPhase == EGenerationPhase::Idle ? 0 : 1);
}

void ATileThumbnailGenerator::PreloadThumbnailAssets()
{
	RetainedPreloadedAssets.Empty();

	const TCHAR* AssetPaths[] =
	{
		TEXT("/Game/BarrelContent/Materials/Tile/TileTextureAtlas.TileTextureAtlas"),
		TEXT("/Game/BarrelContent/Materials/Tile/TileTextureAtlasNormal.TileTextureAtlasNormal"),
		TEXT("/Game/BarrelContent/Materials/Tile/TileTextureAtlasORN.TileTextureAtlasORN"),
		TEXT("/Game/BarrelContent/Materials/Shaders/ObscureMaterialBase.ObscureMaterialBase")
	};

	for (const TCHAR* AssetPath : AssetPaths)
	{
		if (UObject* LoadedAsset = LoadObject<UObject>(nullptr, AssetPath))
		{
			RetainedPreloadedAssets.Add(LoadedAsset);
			if (bLogThumbnailGeneration)
			{
				UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: Preloaded asset '%s' as '%s'."), AssetPath, *LoadedAsset->GetPathName());
			}
			if (UTexture* Texture = Cast<UTexture>(LoadedAsset))
			{
				Texture->SetForceMipLevelsToBeResident(30.0f);
			}
		}
		else if (bLogThumbnailGeneration)
		{
			UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: Failed to preload asset '%s'."), AssetPath);
		}
	}

	for (const TPair<FName, uint8*>& RowPair : TileDataTable->GetRowMap())
	{
		const FTileDefinition* TileDefinition = reinterpret_cast<FTileDefinition*>(RowPair.Value);
		if (!TileDefinition)
		{
			continue;
		}

		if (TileDefinition->Mesh)
		{
			TileDefinition->Mesh->SetForceMipLevelsToBeResident(30.0f);
			RetainedPreloadedAssets.Add(TileDefinition->Mesh);
		}

		if (TileDefinition->ParentMaterial)
		{
			RetainedPreloadedAssets.Add(TileDefinition->ParentMaterial);
		}
	}

	if (bIncludeUserDefinedTiles)
	{
		if (const ATileManager* ResolvedTileManager = ResolveTileManager())
		{
			for (const TPair<FName, FTileDefinition>& UserDefinedTile : ResolvedTileManager->UserDefinedTileDefinitions)
			{
				if (UserDefinedTile.Value.Mesh)
				{
					UserDefinedTile.Value.Mesh->SetForceMipLevelsToBeResident(30.0f);
					RetainedPreloadedAssets.Add(UserDefinedTile.Value.Mesh);
				}

				if (UserDefinedTile.Value.ParentMaterial)
				{
					RetainedPreloadedAssets.Add(UserDefinedTile.Value.ParentMaterial);
				}
			}
		}
	}

	FlushRenderingCommands();
}

void ATileThumbnailGenerator::EnsureRenderTarget()
{
	const int32 ClampedSize = FMath::Max(ThumbnailSize, 1);
	if (!RuntimeRenderTarget || RuntimeRenderTarget->SizeX != ClampedSize || RuntimeRenderTarget->SizeY != ClampedSize)
	{
		RuntimeRenderTarget = NewObject<UTextureRenderTarget2D>(this, TEXT("RuntimeTileThumbnailRT"));
		RuntimeRenderTarget->RenderTargetFormat = RTF_RGBA8;
		RuntimeRenderTarget->ClearColor = ThumbnailBackgroundColor;
		RuntimeRenderTarget->bForceLinearGamma = false;
		RuntimeRenderTarget->TargetGamma = 2.2f;
		RuntimeRenderTarget->InitAutoFormat(ClampedSize, ClampedSize);
		RuntimeRenderTarget->UpdateResourceImmediate(true);
	}

	SceneCaptureComponent->TextureTarget = RuntimeRenderTarget;
}

void ATileThumbnailGenerator::BuildPendingTileList()
{
	PendingTiles.Empty();
	const FString ThumbnailDirectory = GetThumbnailDirectory();
	const UScriptStruct* RowStruct = TileDataTable ? TileDataTable->GetRowStruct() : nullptr;
	if (!RowStruct || !RowStruct->IsChildOf(FTileDefinition::StaticStruct()))
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: TileDataTable has wrong row struct. DataTable='%s' RowStruct='%s' Expected='%s'"),
			TileDataTable ? *TileDataTable->GetPathName() : TEXT("<null>"),
			RowStruct ? *RowStruct->GetPathName() : TEXT("<null>"),
			*FTileDefinition::StaticStruct()->GetPathName());
		return;
	}

	for (const TPair<FName, uint8*>& RowPair : TileDataTable->GetRowMap())
	{
		const FTileDefinition* TileDefinition = reinterpret_cast<FTileDefinition*>(RowPair.Value);
		if (!TileDefinition)
		{
			continue;
		}

		AddPendingTile(RowPair.Key, *TileDefinition, ThumbnailDirectory);
	}

	if (bIncludeUserDefinedTiles)
	{
		if (const ATileManager* ResolvedTileManager = ResolveTileManager())
		{
			for (const TPair<FName, FTileDefinition>& UserDefinedTile : ResolvedTileManager->UserDefinedTileDefinitions)
			{
				AddPendingTile(UserDefinedTile.Key, UserDefinedTile.Value, ThumbnailDirectory);
			}
		}
		else
		{
			UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: bIncludeUserDefinedTiles is true, but no TileManager was found."));
		}
	}
}

void ATileThumbnailGenerator::AddPendingTile(FName TileID, const FTileDefinition& TileDefinition, const FString& ThumbnailDirectory)
{
	FPendingTileThumbnail PendingTile;
	PendingTile.TileID = TileID;
	PendingTile.TileDefinition = TileDefinition;
	PendingTile.FileName = MakeThumbnailFileName(TileID);
	PendingTile.FullFilePath = FPaths::ConvertRelativePathToFull(FPaths::Combine(ThumbnailDirectory, PendingTile.FileName));

	if (bGenerateMissingOnly && FPaths::FileExists(PendingTile.FullFilePath))
	{
		if (UTileThumbnailSubsystem* ThumbnailSubsystem = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileThumbnailSubsystem>() : nullptr)
		{
			ThumbnailSubsystem->RegisterTileThumbnail(PendingTile.TileID, PendingTile.FullFilePath);
			++RegisteredThumbnailCount;
		}
		return;
	}

	PendingTiles.Add(MoveTemp(PendingTile));
}

ATileManager* ATileThumbnailGenerator::ResolveTileManager() const
{
	if (TileManager)
	{
		return TileManager.Get();
	}

	UWorld* World = GetWorld();
	if (!World)
	{
		return nullptr;
	}

	for (TActorIterator<ATileManager> It(World); It; ++It)
	{
		return *It;
	}

	return nullptr;
}

void ATileThumbnailGenerator::ScheduleNextGenerationStep(float DelaySeconds)
{
	UWorld* World = GetWorld();
	if (!World)
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: Cannot schedule generation step because World is null."));
		return;
	}

	World->GetTimerManager().ClearTimer(GenerationTimerHandle);

	if (DelaySeconds > 0.0f)
	{
		World->GetTimerManager().SetTimer(GenerationTimerHandle, this, &ATileThumbnailGenerator::AdvanceGenerationStep, DelaySeconds, false);
	}
	else
	{
		World->GetTimerManager().SetTimerForNextTick(this, &ATileThumbnailGenerator::AdvanceGenerationStep);
	}
}

void ATileThumbnailGenerator::AdvanceGenerationStep()
{
	if (GenerationPhase == EGenerationPhase::Idle)
	{
		return;
	}

	switch (GenerationPhase)
	{
	case EGenerationPhase::Setup:
		SetupNextTile();
		break;
	case EGenerationPhase::Capture:
		CaptureActiveTile();
		break;
	case EGenerationPhase::Export:
		ExportActiveTile();
		break;
	default:
		break;
	}
}

void ATileThumbnailGenerator::SetupNextTile()
{
	if (PendingTiles.IsEmpty())
	{
		FinishGeneration();
		return;
	}

	ActiveTile = PendingTiles[0];
	PendingTiles.RemoveAt(0, 1, EAllowShrinking::No);

	UStaticMesh* Mesh = ResolveMeshForDefinition(ActiveTile.TileDefinition);
	UMaterialInterface* SourceMaterial = ResolveMaterialForDefinition(ActiveTile.TileDefinition);
	if (!Mesh || !SourceMaterial)
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: Skipping TileID='%s'. Mesh=%s Material=%s"),
			*ActiveTile.TileID.ToString(),
			Mesh ? TEXT("valid") : TEXT("null"),
			SourceMaterial ? TEXT("valid") : TEXT("null"));
		GenerationPhase = EGenerationPhase::Setup;
		return;
	}

	InstanceMeshComponent->SetStaticMesh(Mesh);
	InstanceMeshComponent->ClearInstances();
	InstanceMeshComponent->SetNumCustomDataFloats(static_cast<int32>(ETileInstanceDataIndex::MAX));
	InstanceMeshComponent->AddInstance(FTransform::Identity);
	SceneCaptureComponent->ClearShowOnlyComponents();
	SceneCaptureComponent->ShowOnlyComponent(InstanceMeshComponent);
	InstanceMeshComponent->SetRelativeRotation(FRotator(0.0f, 180.0f, 0.0f));
	FitCaptureToMeshBounds(Mesh, ActiveTile.TileDefinition.Category);
	ApplyTileInstanceCustomData(ActiveTile.TileDefinition);

	ActiveMID = UMaterialInstanceDynamic::Create(SourceMaterial, this);
	if (ActiveMID)
	{
		if (UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr)
		{
			if (UTexture2DArray* UserDefinedAtlas = TileTextureRegistry->GetUserDefinedAtlas())
			{
				ActiveMID->SetTextureParameterValue(TEXT("UserDefinedAtlas"), UserDefinedAtlas);
			}
		}
		const int32 MaterialCount = FMath::Max(1, InstanceMeshComponent->GetNumMaterials());
		for (int32 MaterialIndex = 0; MaterialIndex < MaterialCount; ++MaterialIndex)
		{
			InstanceMeshComponent->SetMaterial(MaterialIndex, ActiveMID);
		}
	}
	else
	{
		const int32 MaterialCount = FMath::Max(1, InstanceMeshComponent->GetNumMaterials());
		for (int32 MaterialIndex = 0; MaterialIndex < MaterialCount; ++MaterialIndex)
		{
			InstanceMeshComponent->SetMaterial(MaterialIndex, SourceMaterial);
		}
	}

	UKismetRenderingLibrary::ClearRenderTarget2D(this, RuntimeRenderTarget, ThumbnailBackgroundColor);
	InstanceMeshComponent->PrestreamTextures(1.0f, true, 0);

	if (ShouldLogTileVerbose())
	{
		++VerboseTileLogCount;
		UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: Setup TileID='%s' Mesh='%s' SourceMaterial='%s' MID='%s' Category=%d Albedo=%d Metallic=%d Normal=%d Specular=%d BaseMetallic=%.3f BaseRoughness=%.3f Tint=(%.3f,%.3f,%.3f) MatSlots=%d Ortho=%.1f Offset=%s CustomDataFloats=%d"),
			*ActiveTile.TileID.ToString(),
			Mesh ? *Mesh->GetPathName() : TEXT("<null>"),
			SourceMaterial ? *SourceMaterial->GetPathName() : TEXT("<null>"),
			ActiveMID ? *ActiveMID->GetPathName() : TEXT("<null>"),
			static_cast<int32>(ActiveTile.TileDefinition.Category),
			static_cast<int32>(ActiveTile.TileDefinition.TextureProperties.Albedo),
			static_cast<int32>(ActiveTile.TileDefinition.TextureProperties.Metallic),
			static_cast<int32>(ActiveTile.TileDefinition.TextureProperties.Normal),
			static_cast<int32>(ActiveTile.TileDefinition.TextureProperties.Specular),
			ActiveTile.TileDefinition.TextureProperties.BaseMetallic,
			ActiveTile.TileDefinition.TextureProperties.BaseRoughness,
			ActiveTile.TileDefinition.tint.R,
			ActiveTile.TileDefinition.tint.G,
			ActiveTile.TileDefinition.tint.B,
			InstanceMeshComponent->GetNumMaterials(),
			SceneCaptureComponent->OrthoWidth,
			*InstanceMeshComponent->GetRelativeLocation().ToString(),
			InstanceMeshComponent->NumCustomDataFloats);
	}

	GenerationPhase = EGenerationPhase::Capture;
	ScheduleNextGenerationStep(CaptureDelaySeconds);
}

void ATileThumbnailGenerator::CaptureActiveTile()
{
	if (ShouldLogTileVerbose())
	{
		UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: Capture TileID='%s' RT='%s' RTFormat=%d CaptureSource=%d ShowOnlyComponents=%d Lighting=%s PostProcessing=%s"),
			*ActiveTile.TileID.ToString(),
			RuntimeRenderTarget ? *RuntimeRenderTarget->GetPathName() : TEXT("<null>"),
			RuntimeRenderTarget ? static_cast<int32>(RuntimeRenderTarget->RenderTargetFormat) : INDEX_NONE,
			static_cast<int32>(SceneCaptureComponent->CaptureSource.GetValue()),
			SceneCaptureComponent->ShowOnlyComponents.Num(),
			SceneCaptureComponent->ShowFlags.Lighting ? TEXT("true") : TEXT("false"),
			SceneCaptureComponent->ShowFlags.PostProcessing ? TEXT("true") : TEXT("false"));
	}
	SceneCaptureComponent->CaptureScene();
	GenerationPhase = EGenerationPhase::Export;
	ScheduleNextGenerationStep(CaptureDelaySeconds);
}

void ATileThumbnailGenerator::ExportActiveTile()
{
	UKismetRenderingLibrary::ExportRenderTarget(this, RuntimeRenderTarget, GetThumbnailDirectory(), ActiveTile.FileName);
	const bool bFileExistsAfterExport = FPaths::FileExists(ActiveTile.FullFilePath);

	if (!bFileExistsAfterExport)
	{
		UE_LOG(LogTemp, Warning, TEXT("ATileThumbnailGenerator: Export did not create file. TileID='%s' FilePath='%s' FileName='%s' RenderTarget='%s' RTFormat=%d"),
			*ActiveTile.TileID.ToString(),
			*GetThumbnailDirectory(),
			*ActiveTile.FileName,
			RuntimeRenderTarget ? *RuntimeRenderTarget->GetPathName() : TEXT("<null>"),
			RuntimeRenderTarget ? static_cast<int32>(RuntimeRenderTarget->RenderTargetFormat) : INDEX_NONE);
	}

	if (UTileThumbnailSubsystem* ThumbnailSubsystem = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileThumbnailSubsystem>() : nullptr)
	{
		if (bFileExistsAfterExport)
		{
			ThumbnailSubsystem->RegisterTileThumbnail(ActiveTile.TileID, ActiveTile.FullFilePath);
			++RegisteredThumbnailCount;
		}
	}
	if (bFileExistsAfterExport)
	{
		++GeneratedThumbnailCount;
		if (ShouldLogTileVerbose())
		{
			const int64 FileSize = IFileManager::Get().FileSize(*ActiveTile.FullFilePath);
			UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: Exported TileID='%s' Path='%s' SizeBytes=%lld"),
				*ActiveTile.TileID.ToString(),
				*ActiveTile.FullFilePath,
				FileSize);
		}
	}

	GenerationPhase = EGenerationPhase::Setup;
	ScheduleNextGenerationStep();
}

void ATileThumbnailGenerator::FinishGeneration()
{
	if (UWorld* World = GetWorld())
	{
		World->GetTimerManager().ClearTimer(GenerationTimerHandle);
	}

	GenerationPhase = EGenerationPhase::Idle;
	ActiveMID = nullptr;
	OnTileThumbnailGenerationFinished.Broadcast(GeneratedThumbnailCount, RegisteredThumbnailCount);
	UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: Finished generating tile thumbnails."));
}

UStaticMesh* ATileThumbnailGenerator::ResolveMeshForDefinition(const FTileDefinition& TileDefinition) const
{
	if (TileDefinition.Mesh)
	{
		return TileDefinition.Mesh;
	}

	if (UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr)
	{
		return TileTextureRegistry->ResolveMeshFromHandle(TileDefinition.UserDefinedMesh);
	}

	return nullptr;
}

void ATileThumbnailGenerator::ApplyTileInstanceCustomData(const FTileDefinition& TileDefinition)
{
	TArray<float> CustomData;
	CustomData.SetNumZeroed(static_cast<int32>(ETileInstanceDataIndex::MAX));

	CustomData[static_cast<int32>(ETileInstanceDataIndex::ALBEDO_TEX)] = static_cast<float>(TileDefinition.TextureProperties.Albedo);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::METALLIC_TEX)] = static_cast<float>(TileDefinition.TextureProperties.Metallic);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::NORMAL_TEX)] = static_cast<float>(TileDefinition.TextureProperties.Normal);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::SPECULAR_TEX)] = static_cast<float>(TileDefinition.TextureProperties.Specular);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::BASE_METALLIC)] = TileDefinition.TextureProperties.BaseMetallic;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::BASE_ROUGHNESS)] = TileDefinition.TextureProperties.BaseRoughness;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::OBJ_DIRECTION)] = 0.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::SHOULD_CUT)] = 0.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::FORCE_CUT)] = 0.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::TINT_R)] = TileDefinition.tint.R;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::TINT_G)] = TileDefinition.tint.G;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::TINT_B)] = TileDefinition.tint.B;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::HUE_SHIFT)] = 0.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::DARKENED)] = 0.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::MIRRORED)] = 0.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_ALBEDO_TEX)] = static_cast<float>(TileDefinition.TextureProperties.InteriorAlbedo);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_METALLIC_TEX)] = static_cast<float>(TileDefinition.TextureProperties.InteriorMetallic);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_NORMAL_TEX)] = static_cast<float>(TileDefinition.TextureProperties.InteriorNormal);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_SPECULAR_TEX)] = static_cast<float>(TileDefinition.TextureProperties.InteriorSpecular);
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_TINT_R)] = TileDefinition.InteriorTint.R;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_TINT_G)] = TileDefinition.InteriorTint.G;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::INT_TINT_B)] = TileDefinition.InteriorTint.B;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_ALBEDO)] = -1.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_NORMAL)] = -1.0f;
	CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_ORM)] = -1.0f;

	if (UTileTextureRegistry* TileTextureRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UTileTextureRegistry>() : nullptr)
	{
		const int32 UserAlbedoSlot = IsThumbnailTileAssetHandleSet(TileDefinition.TextureProperties.ConstantTexHandles.ConstAlbedo)
			? TileTextureRegistry->ResolveSlotFromHandle(TileDefinition.TextureProperties.ConstantTexHandles.ConstAlbedo)
			: INDEX_NONE;
		const int32 UserNormalSlot = IsThumbnailTileAssetHandleSet(TileDefinition.TextureProperties.ConstantTexHandles.ConstNormal)
			? TileTextureRegistry->ResolveSlotFromHandle(TileDefinition.TextureProperties.ConstantTexHandles.ConstNormal)
			: INDEX_NONE;
		const int32 UserORMSlot = IsThumbnailTileAssetHandleSet(TileDefinition.TextureProperties.ConstantTexHandles.ConstORM)
			? TileTextureRegistry->ResolveSlotFromHandle(TileDefinition.TextureProperties.ConstantTexHandles.ConstORM)
			: INDEX_NONE;

		if (UserAlbedoSlot != INDEX_NONE)
		{
			CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_ALBEDO)] = static_cast<float>(UserAlbedoSlot);
		}
		if (UserNormalSlot != INDEX_NONE)
		{
			CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_NORMAL)] = static_cast<float>(UserNormalSlot);
		}
		if (UserORMSlot != INDEX_NONE)
		{
			CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_ORM)] = static_cast<float>(UserORMSlot);
		}
	}

	for (int32 CustomDataIndex = 0; CustomDataIndex < CustomData.Num(); ++CustomDataIndex)
	{
		const bool bMarkRenderStateDirty = CustomDataIndex == CustomData.Num() - 1;
		InstanceMeshComponent->SetCustomDataValue(0, CustomDataIndex, CustomData[CustomDataIndex], bMarkRenderStateDirty);
	}

	if (ShouldLogTileVerbose())
	{
		UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: InstanceCustomData Tile Albedo=%.1f Metallic=%.1f Normal=%.1f Specular=%.1f UserAlbedo=%.1f UserNormal=%.1f UserORM=%.1f NumCustomDataFloats=%d InstanceCount=%d"),
			CustomData[static_cast<int32>(ETileInstanceDataIndex::ALBEDO_TEX)],
			CustomData[static_cast<int32>(ETileInstanceDataIndex::METALLIC_TEX)],
			CustomData[static_cast<int32>(ETileInstanceDataIndex::NORMAL_TEX)],
			CustomData[static_cast<int32>(ETileInstanceDataIndex::SPECULAR_TEX)],
			CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_ALBEDO)],
			CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_NORMAL)],
			CustomData[static_cast<int32>(ETileInstanceDataIndex::USERDEF_ORM)],
			InstanceMeshComponent->NumCustomDataFloats,
			InstanceMeshComponent->GetInstanceCount());
	}
}

void ATileThumbnailGenerator::FitCaptureToMeshBounds(UStaticMesh* Mesh, ETileCategory Category)
{
	if (!Mesh)
	{
		InstanceMeshComponent->SetRelativeLocation(FVector::ZeroVector);
		SceneCaptureComponent->OrthoWidth = MinimumOrthoWidth;
		SceneCaptureComponent->SetRelativeLocation(FVector(-550.0f, -550.0f, 450.0f));
		return;
	}

	const FBox LocalBox = Mesh->GetBoundingBox();
	const FVector LocalCenter = LocalBox.GetCenter();
	InstanceMeshComponent->SetRelativeLocation(FVector::ZeroVector);

	const FVector ViewRight = SceneCaptureComponent->GetRightVector();
	const FVector ViewUp = SceneCaptureComponent->GetUpVector();
	float MaxRightExtent = 0.0f;
	float MaxUpExtent = 0.0f;

	for (int32 CornerIndex = 0; CornerIndex < 8; ++CornerIndex)
	{
		const FVector Corner(
			(CornerIndex & 1) ? LocalBox.Max.X : LocalBox.Min.X,
			(CornerIndex & 2) ? LocalBox.Max.Y : LocalBox.Min.Y,
			(CornerIndex & 4) ? LocalBox.Max.Z : LocalBox.Min.Z);
		const FVector FromCenter = Corner - LocalCenter;
		MaxRightExtent = FMath::Max(MaxRightExtent, FMath::Abs(FVector::DotProduct(FromCenter, ViewRight)));
		MaxUpExtent = FMath::Max(MaxUpExtent, FMath::Abs(FVector::DotProduct(FromCenter, ViewUp)));
	}

	float DesiredOrthoWidth = FMath::Max(FMath::Max(MaxRightExtent, MaxUpExtent) * 2.0f, MinimumOrthoWidth) * BoundsPadding;

	if (Category == ETileCategory::WALL || Category == ETileCategory::DOORFRAME || Category == ETileCategory::WINDOW || Category == ETileCategory::ROOF_WALL)
	{
		DesiredOrthoWidth = FMath::Max(DesiredOrthoWidth, 500.0f);
	}
	else if (Category == ETileCategory::STAIR)
	{
		DesiredOrthoWidth = FMath::Max(DesiredOrthoWidth, 400.0f);
	}

	SceneCaptureComponent->OrthoWidth = DesiredOrthoWidth;

	const FVector CaptureDirection = SceneCaptureComponent->GetForwardVector();
	const float CameraDistance = FMath::Max(DesiredOrthoWidth * 2.0f, 500.0f);
	SceneCaptureComponent->SetRelativeLocation(LocalCenter - CaptureDirection * CameraDistance);

	if (ShouldLogTileVerbose())
	{
		UE_LOG(LogTemp, Display, TEXT("ATileThumbnailGenerator: FitBounds Mesh='%s' Min=%s Max=%s Center=%s ViewRightExtent=%.2f ViewUpExtent=%.2f Ortho=%.2f CameraLocation=%s"),
			*Mesh->GetPathName(),
			*LocalBox.Min.ToString(),
			*LocalBox.Max.ToString(),
			*LocalCenter.ToString(),
			MaxRightExtent,
			MaxUpExtent,
			SceneCaptureComponent->OrthoWidth,
			*SceneCaptureComponent->GetRelativeLocation().ToString());
	}
}

bool ATileThumbnailGenerator::ShouldLogTileVerbose() const
{
	return bLogThumbnailGeneration && (MaxVerboseTileLogs <= 0 || VerboseTileLogCount < MaxVerboseTileLogs);
}

UMaterialInterface* ATileThumbnailGenerator::ResolveMaterialForDefinition(const FTileDefinition& TileDefinition) const
{
	if (TileDefinition.Category == ETileCategory::DECAL && DefaultThumbnailMaterial)
	{
		return DefaultThumbnailMaterial.Get();
	}

	return TileDefinition.ParentMaterial ? TileDefinition.ParentMaterial : DefaultThumbnailMaterial.Get();
}

FString ATileThumbnailGenerator::GetThumbnailDirectory()
{
	return FPaths::ConvertRelativePathToFull(FPaths::Combine(FPaths::ProjectSavedDir(), TEXT("Thumbnails/Tiles")));
}

FString ATileThumbnailGenerator::MakeThumbnailFileName(FName TileID)
{
	return SanitizeTileIDForFileName(TileID.ToString()) + TEXT(".png");
}

FString ATileThumbnailGenerator::SanitizeTileIDForFileName(const FString& TileID)
{
	FString Sanitized = TileID;
	const TCHAR InvalidChars[] = TEXT("\\/:*?\"<>|");
	for (const TCHAR InvalidChar : InvalidChars)
	{
		if (InvalidChar == TEXT('\0'))
		{
			break;
		}
		Sanitized.ReplaceCharInline(InvalidChar, TEXT('_'));
	}
	return Sanitized;
}
