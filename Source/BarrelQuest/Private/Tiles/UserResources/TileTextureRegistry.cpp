#include "Tiles/UserResources/TileTextureRegistry.h"

#include "CanvasItem.h"
#include "CanvasTypes.h"
#include "Engine/TextureRenderTarget2D.h"
#include "HAL/FileManager.h"
#include "ImageUtils.h"
#include "Misc/Crc.h"
#include "Misc/FileHelper.h"
#include "Misc/Paths.h"
#include "RuntimeImporters/BarrelUGCRuntimeImporter.h"
#include "TextureResource.h"

namespace
{
	const TCHAR* TileTextureKindToString(ERegisteredAssetType Kind)
	{
		switch (Kind)
		{
		case ERegisteredAssetType::CookedAsset:
			return TEXT("CookedAsset");
		case ERegisteredAssetType::RuntimeAsset:
			return TEXT("RuntimeTexture");
		default:
			return TEXT("None");
		}
	}

	FString DescribeTexture(UTexture2D* Texture)
	{
		if (!Texture)
		{
			return TEXT("<null>");
		}

		return FString::Printf(
			TEXT("%s Path=%s Size=%dx%d Transient=%s"),
			*Texture->GetName(),
			*Texture->GetPathName(),
			Texture->GetSizeX(),
			Texture->GetSizeY(),
			Texture->GetPackage() && Texture->GetPackage()->HasAnyPackageFlags(PKG_TransientFlags) ? TEXT("true") : TEXT("false"));
	}

	FString DescribeHandle(const FTileSavedAssetHandle& Handle)
	{
		return FString::Printf(
			TEXT("Id='%s' Kind=%s AssetPath='%s' Url='%s'"),
			*Handle.Id,
			TileTextureKindToString(Handle.Kind),
			*Handle.AssetPath.ToString(),
			*Handle.Url);
	}

	bool RenderTextureToBGRA8(UTexture2D* Texture, TArray<uint8>& OutPixels, int32& OutWidth, int32& OutHeight)
	{
		if (!Texture)
		{
			return false;
		}

		OutWidth = Texture->GetSizeX();
		OutHeight = Texture->GetSizeY();
		const int32 ExpectedPixels = OutWidth * OutHeight;
		if (ExpectedPixels <= 0)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RenderTextureToBGRA8: Invalid texture size. Texture=%s"), *DescribeTexture(Texture));
			return false;
		}

		UTextureRenderTarget2D* RenderTarget = NewObject<UTextureRenderTarget2D>(GetTransientPackage());
		if (!RenderTarget)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RenderTextureToBGRA8: Failed to create render target. Texture=%s"), *DescribeTexture(Texture));
			return false;
		}

		RenderTarget->ClearColor = FLinearColor::Transparent;
		RenderTarget->RenderTargetFormat = RTF_RGBA8;
		RenderTarget->bAutoGenerateMips = false;
		RenderTarget->SRGB = Texture->SRGB;
		RenderTarget->InitAutoFormat(OutWidth, OutHeight);
		RenderTarget->UpdateResourceImmediate(true);

		FTextureRenderTargetResource* RenderTargetResource = RenderTarget->GameThread_GetRenderTargetResource();
		if (!RenderTargetResource)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RenderTextureToBGRA8: Missing render target resource. Texture=%s"), *DescribeTexture(Texture));
			return false;
		}

		FCanvas Canvas(RenderTargetResource, nullptr, FGameTime::GetTimeSinceAppStart(), GMaxRHIFeatureLevel);
		FCanvasTileItem TileItem(FVector2D::ZeroVector, Texture->GetResource(), FVector2D(OutWidth, OutHeight), FLinearColor::White);
		TileItem.BlendMode = SE_BLEND_Opaque;
		Canvas.DrawItem(TileItem);
		Canvas.Flush_GameThread();

		TArray<FColor> RenderedPixels;
		FReadSurfaceDataFlags ReadFlags(RCM_UNorm, CubeFace_MAX);
		ReadFlags.SetLinearToGamma(false);
		if (!RenderTargetResource->ReadPixels(RenderedPixels, ReadFlags) || RenderedPixels.Num() != ExpectedPixels)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RenderTextureToBGRA8: ReadPixels failed or returned bad count. Got=%d Expected=%d Texture=%s"),
				RenderedPixels.Num(),
				ExpectedPixels,
				*DescribeTexture(Texture));
			return false;
		}

		OutPixels.SetNumUninitialized(ExpectedPixels * 4);
		for (int32 PixelIndex = 0; PixelIndex < RenderedPixels.Num(); ++PixelIndex)
		{
			const FColor& Pixel = RenderedPixels[PixelIndex];
			const int32 ByteIndex = PixelIndex * 4;
			OutPixels[ByteIndex + 0] = Pixel.B;
			OutPixels[ByteIndex + 1] = Pixel.G;
			OutPixels[ByteIndex + 2] = Pixel.R;
			OutPixels[ByteIndex + 3] = Pixel.A;
		}

		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RenderTextureToBGRA8: Rendered Texture=%s Size=%dx%d OutBytes=%d"),
			*DescribeTexture(Texture),
			OutWidth,
			OutHeight,
			OutPixels.Num());
		return true;
	}

	bool ExtractBGRA8Pixels(UTexture2D* Texture, TArray<uint8>& OutPixels, int32& OutWidth, int32& OutHeight)
	{
		if (!Texture || !Texture->GetPlatformData() || Texture->GetPlatformData()->Mips.Num() == 0)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: Missing texture/platform data/mips. Texture=%s"), *DescribeTexture(Texture));
			return false;
		}

		FTexturePlatformData* PlatformData = Texture->GetPlatformData();
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: Texture=%s PixelFormat=%d ExpectedPixelFormat=%d MipCount=%d PlatformSize=%dx%d"),
			*DescribeTexture(Texture),
			static_cast<int32>(PlatformData->PixelFormat),
			static_cast<int32>(PF_B8G8R8A8),
			PlatformData->Mips.Num(),
			PlatformData->SizeX,
			PlatformData->SizeY);

		if (PlatformData->PixelFormat != PF_B8G8R8A8)
		{
			UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: Pixel format %d is not CPU-copyable BGRA8 for Texture=%s. Falling back to render-target conversion."),
				static_cast<int32>(PlatformData->PixelFormat),
				*DescribeTexture(Texture));
			return RenderTextureToBGRA8(Texture, OutPixels, OutWidth, OutHeight);
		}

		FTexture2DMipMap& Mip = PlatformData->Mips[0];
		OutWidth = Mip.SizeX;
		OutHeight = Mip.SizeY;

		const int64 ExpectedBytes = static_cast<int64>(OutWidth) * static_cast<int64>(OutHeight) * 4;
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: Mip0 Size=%dx%d ExpectedBytes=%lld BulkDataSize=%lld"),
			OutWidth,
			OutHeight,
			ExpectedBytes,
			static_cast<int64>(Mip.BulkData.GetBulkDataSize()));

		if (ExpectedBytes <= 0 || ExpectedBytes > MAX_int32)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: Invalid expected byte count %lld."), ExpectedBytes);
			return false;
		}

		const void* MipData = Mip.BulkData.LockReadOnly();
		if (!MipData)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: LockReadOnly returned null."));
			return false;
		}

		OutPixels.SetNumUninitialized(static_cast<int32>(ExpectedBytes));
		FMemory::Memcpy(OutPixels.GetData(), MipData, ExpectedBytes);
		Mip.BulkData.Unlock();

		if (OutPixels.Num() >= 4)
		{
			UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: FirstPixel BGRA=(%d,%d,%d,%d) OutBytes=%d"),
				OutPixels[0],
				OutPixels[1],
				OutPixels[2],
				OutPixels[3],
				OutPixels.Num());
		}

		return true;
	}
}

void UTileTextureRegistry::Initialize(FSubsystemCollectionBase& Collection)
{
	Super::Initialize(Collection);

	PurgeRegisteredAssets();
}

void UTileTextureRegistry::PurgeRegisteredAssets()
{
	const int64 PreviousBytes = GetEstimatedRetainedBytes();

	SlotToTexture.Empty();
	CookedTextureToSlot.Empty();
	HandleIdToSlot.Empty();
	HandleIdToMesh.Empty();
	CookedMeshToInfo.Empty();
	SlotPixels.Empty();
	FreeSlots.Empty();
	UserDefinedAtlas = nullptr;

	for (int32 Slot = MaxUserTextureSlots - 1; Slot >= 0; --Slot)
	{
		FreeSlots.Add(Slot);
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry: Purged registered assets. PreviousEstimatedBytes=%lld MaxSlots=%d FreeSlots=%d Atlas=%s"),
		PreviousBytes,
		MaxUserTextureSlots,
		FreeSlots.Num(),
		UserDefinedAtlas ? *UserDefinedAtlas->GetPathName() : TEXT("<null>"));
}

int64 UTileTextureRegistry::GetEstimatedRetainedBytes() const
{
	int64 TotalBytes = 0;
	for (const TPair<int32, TArray<uint8>>& Pair : SlotPixels)
	{
		TotalBytes += Pair.Value.Num();
	}

	if (UserDefinedAtlas)
	{
		TotalBytes += static_cast<int64>(UserTextureSize) * UserTextureSize * MaxUserTextureSlots * 4;
	}

	return TotalBytes;
}

bool UTileTextureRegistry::ResolveFromHandle(FTileSavedAssetHandle handle)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveFromHandle: Handle={%s}"), *DescribeHandle(handle));
	const int32 Slot = ResolveSlotFromHandle(handle);
	const bool bResolved = ResolveTexture(Slot);
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveFromHandle: Slot=%d Resolved=%s"), Slot, bResolved ? TEXT("true") : TEXT("false"));
	return bResolved;
}

int32 UTileTextureRegistry::ResolveSlotFromHandle(FTileSavedAssetHandle handle)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Begin Handle={%s} RegisteredSlots=%d HandleMappings=%d FreeSlots=%d PixelSlots=%d"),
		*DescribeHandle(handle),
		SlotToTexture.Num(),
		HandleIdToSlot.Num(),
		FreeSlots.Num(),
		SlotPixels.Num());

	if (!handle.Id.IsEmpty())
	{
		if (const int32* ExistingSlot = HandleIdToSlot.Find(handle.Id))
		{
			UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Found HandleId mapping Id='%s' Slot=%d"), *handle.Id, *ExistingSlot);
			if (ResolveTexture(*ExistingSlot))
			{
				UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Returning existing Slot=%d for Id='%s'"), *ExistingSlot, *handle.Id);
				return *ExistingSlot;
			}

			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: HandleId mapping Id='%s' pointed to Slot=%d, but atlas pixels failed to resolve."), *handle.Id, *ExistingSlot);
		}
		else
		{
			UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: No HandleId mapping for Id='%s'."), *handle.Id);
		}
	}
	else
	{
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Handle has empty Id."));
	}

	int32 Slot = INDEX_NONE;

	switch (handle.Kind)
	{
	case ERegisteredAssetType::CookedAsset:
		if (handle.AssetPath.IsValid())
		{
			UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Registering cooked asset from AssetPath='%s'."), *handle.AssetPath.ToString());
			TSoftObjectPtr<UTexture2D> TexturePtr(handle.AssetPath);
			Slot = RegisterCookedTextureInternal(TexturePtr);
			if (!ResolveTexture(Slot))
			{
				UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Cooked asset failed to resolve. Releasing Slot=%d Handle={%s}"), Slot, *DescribeHandle(handle));
				ReleaseTextureSlot(Slot);
				Slot = INDEX_NONE;
			}
		}
		else
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: CookedAsset handle has invalid AssetPath. Handle={%s}"), *DescribeHandle(handle));
		}
		break;

	case ERegisteredAssetType::RuntimeAsset:
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Runtime asset is not registered yet. Register RawBytes with this handle first. Handle={%s}"), *DescribeHandle(handle));
		break;

	default:
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Handle kind is None. Returning INDEX_NONE."));
		break;
	}

	if (Slot != INDEX_NONE && !handle.Id.IsEmpty())
	{
		HandleIdToSlot.Add(handle.Id, Slot);
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Added HandleId mapping Id='%s' Slot=%d"), *handle.Id, Slot);
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: End Slot=%d Handle={%s}"), Slot, *DescribeHandle(handle));
	return Slot;
}

UStaticMesh* UTileTextureRegistry::ResolveMeshFromHandle(FTileSavedAssetHandle handle)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveMeshFromHandle: Begin Handle={%s} RegisteredMeshes=%d CookedMeshes=%d"),
		*DescribeHandle(handle),
		HandleIdToMesh.Num(),
		CookedMeshToInfo.Num());

	if (!handle.Id.IsEmpty())
	{
		if (FTileRegisteredMesh* ExistingMesh = HandleIdToMesh.Find(handle.Id))
		{
			if (ExistingMesh->RuntimeMesh)
			{
				UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveMeshFromHandle: Found runtime mesh by Id='%s' Mesh='%s'"),
					*handle.Id,
					*ExistingMesh->RuntimeMesh->GetPathName());
				return ExistingMesh->RuntimeMesh;
			}

			UStaticMesh* LoadedCookedMesh = ExistingMesh->CookedMesh.Get();
			if (!LoadedCookedMesh && !ExistingMesh->CookedMesh.IsNull())
			{
				LoadedCookedMesh = ExistingMesh->CookedMesh.LoadSynchronous();
			}

			if (LoadedCookedMesh)
			{
				ExistingMesh->RuntimeMesh = LoadedCookedMesh;
				UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveMeshFromHandle: Loaded cooked mesh by Id='%s' Mesh='%s'"),
					*handle.Id,
					*LoadedCookedMesh->GetPathName());
				return LoadedCookedMesh;
			}
		}
	}

	switch (handle.Kind)
	{
	case ERegisteredAssetType::CookedAsset:
		if (handle.AssetPath.IsValid())
		{
			TSoftObjectPtr<UStaticMesh> MeshPtr(handle.AssetPath);
			return RegisterCookedMeshWithHandle(MeshPtr, handle);
		}

		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveMeshFromHandle: CookedAsset handle has invalid AssetPath. Handle={%s}"), *DescribeHandle(handle));
		break;

	case ERegisteredAssetType::RuntimeAsset:
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveMeshFromHandle: Runtime mesh is not registered yet. Register RawBytes with this handle first. Handle={%s}"), *DescribeHandle(handle));
		break;

	default:
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveMeshFromHandle: Handle kind is not a mesh kind. Returning null."));
		break;
	}

	return nullptr;
}

void UTileTextureRegistry::CreateUserDefinedAtlas()
{
	UserDefinedAtlas = NewObject<UTexture2DArray>(this, TEXT("UserDefinedTileTextureArray"));
	if (!UserDefinedAtlas)
	{
		UE_LOG(LogTemp, Error, TEXT("UTileTextureRegistry::CreateUserDefinedAtlas: Failed to create UTexture2DArray."));
		return;
	}

	UserDefinedAtlas->Filter = TF_Bilinear;
	UserDefinedAtlas->AddressX = TA_Clamp;
	UserDefinedAtlas->AddressY = TA_Clamp;
	UserDefinedAtlas->SRGB = true;

	// Initialize platform data for runtime use
	FTexturePlatformData* PlatformData = new FTexturePlatformData();
	PlatformData->SizeX = UserTextureSize;
	PlatformData->SizeY = UserTextureSize;
	PlatformData->SetNumSlices(MaxUserTextureSlots);
	PlatformData->PixelFormat = PF_B8G8R8A8;

	// Add a mip level
	FTexture2DMipMap* Mip = new FTexture2DMipMap(UserTextureSize, UserTextureSize, MaxUserTextureSlots);
	Mip->BulkData.Lock(LOCK_READ_WRITE);
	uint8* MipData = (uint8*)Mip->BulkData.Realloc(UserTextureSize * UserTextureSize * MaxUserTextureSlots * 4);
	FMemory::Memzero(MipData, UserTextureSize * UserTextureSize * MaxUserTextureSlots * 4);
	Mip->BulkData.Unlock();
	PlatformData->Mips.Add(Mip);

	UserDefinedAtlas->SetPlatformData(PlatformData);
	UserDefinedAtlas->UpdateResource();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::CreateUserDefinedAtlas: Created Atlas=%s Size=%dx%d Slices=%d"),
		*UserDefinedAtlas->GetPathName(),
		UserTextureSize,
		UserTextureSize,
		MaxUserTextureSlots);
}

UTexture2DArray* UTileTextureRegistry::GetUserDefinedAtlas() const
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::GetUserDefinedAtlas: Atlas=%s"),
		UserDefinedAtlas ? *UserDefinedAtlas->GetPathName() : TEXT("<null>"));
	return UserDefinedAtlas;
}

FString UTileTextureRegistry::ExportUserDefinedTileAtlas()
{
	int32 Columns = 1;
	while (Columns * Columns < MaxUserTextureSlots)
	{
		Columns *= 2;
	}

	const int32 Rows = FMath::DivideAndRoundUp(MaxUserTextureSlots, Columns);
	const int32 SheetWidth = Columns * UserTextureSize;
	const int32 SheetHeight = Rows * UserTextureSize;
	const int32 ExpectedSlotBytes = UserTextureSize * UserTextureSize * 4;

	if (SheetWidth <= 0 || SheetHeight <= 0)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExportUserDefinedTileAtlas: Invalid sheet size. Columns=%d Rows=%d TileSize=%d"), Columns, Rows, UserTextureSize);
		return FString();
	}

	TArray<FColor> SheetPixels;
	SheetPixels.SetNumZeroed(SheetWidth * SheetHeight);

	for (int32 Slot = 0; Slot < MaxUserTextureSlots; ++Slot)
	{
		const TArray<uint8>* SlotPixelBytes = SlotPixels.Find(Slot);
		if (!SlotPixelBytes)
		{
			continue;
		}

		if (SlotPixelBytes->Num() != ExpectedSlotBytes)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExportUserDefinedTileAtlas: Skipping slot with unexpected byte count. Slot=%d Bytes=%d Expected=%d"),
				Slot,
				SlotPixelBytes->Num(),
				ExpectedSlotBytes);
			continue;
		}

		const int32 SlotColumn = Slot % Columns;
		const int32 SlotRow = Slot / Columns;
		const int32 DestBaseX = SlotColumn * UserTextureSize;
		const int32 DestBaseY = SlotRow * UserTextureSize;

		for (int32 Y = 0; Y < UserTextureSize; ++Y)
		{
			for (int32 X = 0; X < UserTextureSize; ++X)
			{
				const int32 SourceIndex = (Y * UserTextureSize + X) * 4;
				const int32 DestIndex = (DestBaseY + Y) * SheetWidth + DestBaseX + X;
				SheetPixels[DestIndex] = FColor(
					(*SlotPixelBytes)[SourceIndex + 2],
					(*SlotPixelBytes)[SourceIndex + 1],
					(*SlotPixelBytes)[SourceIndex + 0],
					(*SlotPixelBytes)[SourceIndex + 3]);
			}
		}
	}

	TArray64<uint8> CompressedPng;
	FImageUtils::PNGCompressImageArray(SheetWidth, SheetHeight, TArrayView64<const FColor>(SheetPixels.GetData(), SheetPixels.Num()), CompressedPng);
	if (CompressedPng.Num() == 0)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExportUserDefinedTileAtlas: PNG compression produced no data. Sheet=%dx%d"), SheetWidth, SheetHeight);
		return FString();
	}

	const FString OutputDirectory = FPaths::ProjectSavedDir() / TEXT("Debug") / TEXT("TileAtlases");
	IFileManager::Get().MakeDirectory(*OutputDirectory, true);

	const FString OutputPath = OutputDirectory / FString::Printf(
		TEXT("UserDefinedTileAtlas_%s_%dx%d_%dslots.png"),
		*FDateTime::Now().ToString(TEXT("%Y%m%d_%H%M%S")),
		SheetWidth,
		SheetHeight,
		MaxUserTextureSlots);

	if (!FFileHelper::SaveArrayToFile(CompressedPng, *OutputPath))
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExportUserDefinedTileAtlas: Failed to write file. Path='%s' Bytes=%lld"), *OutputPath, CompressedPng.Num());
		return FString();
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ExportUserDefinedTileAtlas: Wrote atlas contact sheet. Path='%s' Sheet=%dx%d Slots=%d RegisteredSlots=%d"),
		*OutputPath,
		SheetWidth,
		SheetHeight,
		MaxUserTextureSlots,
		SlotPixels.Num());

	return OutputPath;
}

int32 UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle(const TArray<uint8>& RawBytes, FTileSavedAssetHandle Handle)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Begin RawBytes=%d Handle={%s}"), RawBytes.Num(), *DescribeHandle(Handle));

	if (!Handle.Id.IsEmpty())
	{
		if (const int32* ExistingSlot = HandleIdToSlot.Find(Handle.Id))
		{
			UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Handle already registered. Id='%s' Slot=%d"), *Handle.Id, *ExistingSlot);
			return *ExistingSlot;
		}
	}
	else
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Handle.Id is empty. Tile defs cannot resolve this runtime texture after reload."));
	}

	if (RawBytes.IsEmpty())
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: RawBytes was empty. Handle={%s}"), *DescribeHandle(Handle));
		return INDEX_NONE;
	}

	if (FreeSlots.IsEmpty())
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Out of user texture slots."));
		return INDEX_NONE;
	}

	TArray<uint8> SrcPixels;
	int32 SrcWidth = 0;
	int32 SrcHeight = 0;
	if (!DecodeImageBytesToBGRA8(RawBytes, SrcPixels, SrcWidth, SrcHeight))
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Failed to decode RawBytes=%d Handle={%s}"), RawBytes.Num(), *DescribeHandle(Handle));
		return INDEX_NONE;
	}

	TArray<uint8> AtlasPixels;
	if (SrcWidth == UserTextureSize && SrcHeight == UserTextureSize)
	{
		AtlasPixels = MoveTemp(SrcPixels);
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Decoded source already matches atlas size. Size=%dx%d Bytes=%d"),
			SrcWidth,
			SrcHeight,
			AtlasPixels.Num());
	}
	else
	{
		ResizeBGRA8(SrcPixels, SrcWidth, SrcHeight, AtlasPixels);
	}

	const int32 ExpectedAtlasBytes = UserTextureSize * UserTextureSize * 4;
	if (AtlasPixels.Num() != ExpectedAtlasBytes)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Bad atlas byte count. Got=%d Expected=%d"), AtlasPixels.Num(), ExpectedAtlasBytes);
		return INDEX_NONE;
	}

	const int32 Slot = FreeSlots.Pop(EAllowShrinking::No);

	FTileRegisteredTexture Entry;
	Entry.Kind = ERegisteredAssetType::RuntimeAsset;
	Entry.Slot = Slot;

	SlotToTexture.Add(Slot, Entry);
	SlotPixels.Add(Slot, MoveTemp(AtlasPixels));

	if (!Handle.Id.IsEmpty())
	{
		HandleIdToSlot.Add(Handle.Id, Slot);
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: Added HandleId mapping Id='%s' Slot=%d"), *Handle.Id, Slot);
	}

	RebuildAtlasFromSlotPixels();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle: End Slot=%d RegisteredSlots=%d PixelSlots=%d FreeSlots=%d"),
		Slot,
		SlotToTexture.Num(),
		SlotPixels.Num(),
		FreeSlots.Num());

	return Slot;
}

int32 UTileTextureRegistry::RegisterCookedTextureWithHandle(TSoftObjectPtr<UTexture2D> Texture, FTileSavedAssetHandle Handle)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureWithHandle: TexturePath='%s' Handle={%s}"), *Texture.ToSoftObjectPath().ToString(), *DescribeHandle(Handle));
	const int32 Slot = RegisterCookedTextureInternal(Texture);
	if (Slot != INDEX_NONE && !Handle.Id.IsEmpty())
	{
		HandleIdToSlot.Add(Handle.Id, Slot);
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureWithHandle: Added HandleId mapping Id='%s' Slot=%d"), *Handle.Id, Slot);
	}
	else if (Slot != INDEX_NONE)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterCookedTextureWithHandle: Texture registered in Slot=%d but Handle.Id was empty."), Slot);
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureWithHandle: End Slot=%d"), Slot);
	return Slot;
}

UStaticMesh* UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle(const TArray<uint8>& RawBytes, FTileSavedAssetHandle Handle, float ImportScale)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle: Begin RawBytes=%d Handle={%s} ImportScale=%f"),
		RawBytes.Num(),
		*DescribeHandle(Handle),
		ImportScale);

	if (!Handle.Id.IsEmpty())
	{
		if (FTileRegisteredMesh* ExistingMesh = HandleIdToMesh.Find(Handle.Id))
		{
			if (ExistingMesh->RuntimeMesh)
			{
				return ExistingMesh->RuntimeMesh;
			}
		}
	}
	else
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle: Handle.Id is empty. Tile defs cannot resolve this runtime mesh after reload."));
	}

	if (RawBytes.IsEmpty())
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle: RawBytes was empty. Handle={%s}"), *DescribeHandle(Handle));
		return nullptr;
	}

	UUGCAssetRegistry* UGCRegistry = GetGameInstance() ? GetGameInstance()->GetSubsystem<UUGCAssetRegistry>() : nullptr;
	if (!UGCRegistry)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle: UUGCAssetRegistry subsystem was null. Handle={%s}"), *DescribeHandle(Handle));
		return nullptr;
	}

	FString CacheKey = Handle.Id;
	if (CacheKey.IsEmpty())
	{
		CacheKey = !Handle.Url.IsEmpty() ? Handle.Url : Handle.AssetPath.ToString();
	}
	if (CacheKey.IsEmpty())
	{
		CacheKey = FString::Printf(TEXT("runtime-mesh:%u:%d"), FCrc::MemCrc32(RawBytes.GetData(), RawBytes.Num()), RawBytes.Num());
	}

	UStaticMesh* Mesh = UGCRegistry->GetOrLoadMesh(RawBytes, CacheKey, ImportScale);
	if (!Mesh)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle: Failed to build mesh. Handle={%s}"), *DescribeHandle(Handle));
		return nullptr;
	}

	FTileRegisteredMesh Entry;
	Entry.Kind = ERegisteredAssetType::RuntimeAsset;
	Entry.RuntimeMesh = Mesh;

	if (!Handle.Id.IsEmpty())
	{
		HandleIdToMesh.Add(Handle.Id, Entry);
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterRuntimeMeshBytesWithHandle: End Mesh='%s' Handle={%s}"),
		*Mesh->GetPathName(),
		*DescribeHandle(Handle));

	return Mesh;
}

UStaticMesh* UTileTextureRegistry::RegisterCookedMeshWithHandle(TSoftObjectPtr<UStaticMesh> Mesh, FTileSavedAssetHandle Handle)
{
	const FSoftObjectPath MeshPath = Mesh.ToSoftObjectPath();
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedMeshWithHandle: MeshPath='%s' Handle={%s}"), *MeshPath.ToString(), *DescribeHandle(Handle));

	if (Mesh.IsNull())
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterCookedMeshWithHandle: Mesh soft pointer was null. Handle={%s}"), *DescribeHandle(Handle));
		return nullptr;
	}

	if (FTileRegisteredMesh* ExistingMesh = CookedMeshToInfo.Find(MeshPath))
	{
		UStaticMesh* LoadedExistingMesh = ExistingMesh->RuntimeMesh;
		if (!LoadedExistingMesh)
		{
			LoadedExistingMesh = ExistingMesh->CookedMesh.Get();
		}
		if (!LoadedExistingMesh && !ExistingMesh->CookedMesh.IsNull())
		{
			LoadedExistingMesh = ExistingMesh->CookedMesh.LoadSynchronous();
		}
		ExistingMesh->RuntimeMesh = LoadedExistingMesh;
		if (!Handle.Id.IsEmpty())
		{
			HandleIdToMesh.Add(Handle.Id, *ExistingMesh);
		}
		return LoadedExistingMesh;
	}

	UStaticMesh* LoadedMesh = Mesh.Get();
	if (!LoadedMesh)
	{
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedMeshWithHandle: Loading cooked mesh Path='%s'"), *MeshPath.ToString());
		LoadedMesh = Mesh.LoadSynchronous();
	}

	if (!LoadedMesh)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterCookedMeshWithHandle: Failed to load cooked mesh Path='%s'"), *MeshPath.ToString());
		return nullptr;
	}

	FTileRegisteredMesh Entry;
	Entry.Kind = ERegisteredAssetType::CookedAsset;
	Entry.CookedMesh = Mesh;
	Entry.RuntimeMesh = LoadedMesh;

	CookedMeshToInfo.Add(MeshPath, Entry);
	if (!Handle.Id.IsEmpty())
	{
		HandleIdToMesh.Add(Handle.Id, Entry);
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedMeshWithHandle: End Mesh='%s' Handle={%s}"),
		*LoadedMesh->GetPathName(),
		*DescribeHandle(Handle));

	return LoadedMesh;
}

int32 UTileTextureRegistry::RegisterCookedTextureInternal(TSoftObjectPtr<UTexture2D> Texture)
{
	if (Texture.IsNull())
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Texture soft pointer was null."));
		return INDEX_NONE;
	}

	const FSoftObjectPath TexturePath = Texture.ToSoftObjectPath();
	if (const int32* ExistingSlot = CookedTextureToSlot.Find(TexturePath))
	{
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Texture already registered. Slot=%d Path='%s'"), *ExistingSlot, *TexturePath.ToString());
		return *ExistingSlot;
	}

	if (FreeSlots.IsEmpty())
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Out of user texture slots."));
		return INDEX_NONE;
	}

	UTexture2D* LoadedTexture = Texture.Get();
	if (!LoadedTexture)
	{
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Loading cooked texture Path='%s'"), *TexturePath.ToString());
		LoadedTexture = Texture.LoadSynchronous();
	}

	TArray<uint8> SrcPixels;
	int32 SrcWidth = 0;
	int32 SrcHeight = 0;
	if (!ExtractBGRA8Pixels(LoadedTexture, SrcPixels, SrcWidth, SrcHeight))
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Failed to extract cooked texture pixels. Path='%s' Texture=%s"), *TexturePath.ToString(), *DescribeTexture(LoadedTexture));
		return INDEX_NONE;
	}

	TArray<uint8> AtlasPixels;
	if (SrcWidth == UserTextureSize && SrcHeight == UserTextureSize)
	{
		AtlasPixels = MoveTemp(SrcPixels);
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Cooked source already matches atlas size. Size=%dx%d Bytes=%d"),
			SrcWidth,
			SrcHeight,
			AtlasPixels.Num());
	}
	else
	{
		ResizeBGRA8(SrcPixels, SrcWidth, SrcHeight, AtlasPixels);
	}

	const int32 Slot = FreeSlots.Pop(EAllowShrinking::No);

	FTileRegisteredTexture Entry;
	Entry.Kind = ERegisteredAssetType::CookedAsset;
	Entry.CookedTexture = Texture;
	Entry.Slot = Slot;

	SlotToTexture.Add(Slot, Entry);
	CookedTextureToSlot.Add(TexturePath, Slot);
	SlotPixels.Add(Slot, MoveTemp(AtlasPixels));

	RebuildAtlasFromSlotPixels();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RegisterCookedTextureInternal: Registered Slot=%d Path='%s' Texture=%s Atlas=%s RegisteredSlots=%d PixelSlots=%d FreeSlots=%d"),
		Slot,
		*TexturePath.ToString(),
		*DescribeTexture(LoadedTexture),
		UserDefinedAtlas ? *UserDefinedAtlas->GetPathName() : TEXT("<null>"),
		SlotToTexture.Num(),
		SlotPixels.Num(),
		FreeSlots.Num());

	return Slot;
}

bool UTileTextureRegistry::ResolveTexture(int32 Slot)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveTexture: Begin Slot=%d"), Slot);

	const FTileRegisteredTexture* Entry = SlotToTexture.Find(Slot);
	if (!Entry)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveTexture: No entry for Slot=%d"), Slot);
		return false;
	}

	if (!SlotPixels.Contains(Slot))
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveTexture: Slot=%d has entry Kind=%s but no atlas pixels."), Slot, TileTextureKindToString(Entry->Kind));
		return false;
	}

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveTexture: Slot=%d resolved. Kind=%s Atlas=%s PixelBytes=%d"),
		Slot,
		TileTextureKindToString(Entry->Kind),
		UserDefinedAtlas ? *UserDefinedAtlas->GetPathName() : TEXT("<null>"),
		SlotPixels.FindChecked(Slot).Num());

	return true;
}

void UTileTextureRegistry::ReleaseTextureSlot(int32 Slot)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ReleaseTextureSlot: Begin Slot=%d"), Slot);

	FTileRegisteredTexture Entry;
	if (!SlotToTexture.RemoveAndCopyValue(Slot, Entry))
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ReleaseTextureSlot: No entry for Slot=%d"), Slot);
		return;
	}

	if (!Entry.CookedTexture.IsNull())
	{
		CookedTextureToSlot.Remove(Entry.CookedTexture.ToSoftObjectPath());
	}

	for (auto It = HandleIdToSlot.CreateIterator(); It; ++It)
	{
		if (It.Value() == Slot)
		{
			It.RemoveCurrent();
		}
	}

	SlotPixels.Remove(Slot);
	FreeSlots.AddUnique(Slot);
	RebuildAtlasFromSlotPixels();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ReleaseTextureSlot: Released Slot=%d Kind=%s FreeSlots=%d RegisteredSlots=%d PixelSlots=%d"),
		Slot,
		TileTextureKindToString(Entry.Kind),
		FreeSlots.Num(),
		SlotToTexture.Num(),
		SlotPixels.Num());
}

FTileRegisteredTexture UTileTextureRegistry::GetTextureInfo(int32 Slot) const
{
	if (const FTileRegisteredTexture* Entry = SlotToTexture.Find(Slot))
	{
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::GetTextureInfo: Slot=%d Kind=%s CookedPath='%s' HasPixels=%s PixelBytes=%d"),
			Slot,
			TileTextureKindToString(Entry->Kind),
			*Entry->CookedTexture.ToSoftObjectPath().ToString(),
			SlotPixels.Contains(Slot) ? TEXT("true") : TEXT("false"),
			SlotPixels.Contains(Slot) ? SlotPixels.FindChecked(Slot).Num() : 0);
		return *Entry;
	}

	UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::GetTextureInfo: No entry for Slot=%d"), Slot);
	return FTileRegisteredTexture();
}

bool UTileTextureRegistry::DecodeImageBytesToBGRA8(const TArray<uint8>& RawBytes, TArray<uint8>& OutPixels, int32& OutWidth, int32& OutHeight) const
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::DecodeImageBytesToBGRA8: Begin RawBytes=%d"), RawBytes.Num());

	UTexture2D* DecodedTexture = FImageUtils::ImportBufferAsTexture2D(RawBytes);
	if (!DecodedTexture)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::DecodeImageBytesToBGRA8: ImportBufferAsTexture2D failed. RawBytes=%d"), RawBytes.Num());
		return false;
	}

	const bool bExtracted = ExtractBGRA8Pixels(DecodedTexture, OutPixels, OutWidth, OutHeight);
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::DecodeImageBytesToBGRA8: End Success=%s Texture=%s Size=%dx%d OutBytes=%d"),
		bExtracted ? TEXT("true") : TEXT("false"),
		*DescribeTexture(DecodedTexture),
		OutWidth,
		OutHeight,
		OutPixels.Num());

	return bExtracted;
}

bool UTileTextureRegistry::RebuildAtlasFromSlotPixels()
{
	if (!UserDefinedAtlas)
	{
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RebuildAtlasFromSlotPixels: Atlas was null, recreating."));
		CreateUserDefinedAtlas();
	}

	if (!UserDefinedAtlas)
	{
		UE_LOG(LogTemp, Error, TEXT("UTileTextureRegistry::RebuildAtlasFromSlotPixels: Atlas is still null."));
		return false;
	}

	const int32 SliceBytes = UserTextureSize * UserTextureSize * 4;
	TArray<uint8> AtlasBytes;
	AtlasBytes.SetNumZeroed(SliceBytes * MaxUserTextureSlots);

	for (const TPair<int32, TArray<uint8>>& Pair : SlotPixels)
	{
		const int32 Slot = Pair.Key;
		const TArray<uint8>& Pixels = Pair.Value;
		if (Slot < 0 || Slot >= MaxUserTextureSlots)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RebuildAtlasFromSlotPixels: Skipping invalid Slot=%d"), Slot);
			continue;
		}

		if (Pixels.Num() != SliceBytes)
		{
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::RebuildAtlasFromSlotPixels: Skipping Slot=%d due to bad byte count. Got=%d Expected=%d"), Slot, Pixels.Num(), SliceBytes);
			continue;
		}

		FMemory::Memcpy(AtlasBytes.GetData() + Slot * SliceBytes, Pixels.GetData(), SliceBytes);
	}

	FTexturePlatformData* PlatformData = UserDefinedAtlas->GetPlatformData();
	if (PlatformData && PlatformData->Mips.Num() > 0)
	{
		FTexture2DMipMap& Mip = PlatformData->Mips[0];
		Mip.BulkData.Lock(LOCK_READ_WRITE);
		uint8* MipData = (uint8*)Mip.BulkData.Realloc(AtlasBytes.Num());
		FMemory::Memcpy(MipData, AtlasBytes.GetData(), AtlasBytes.Num());
		Mip.BulkData.Unlock();
	}
	UserDefinedAtlas->UpdateResource();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::RebuildAtlasFromSlotPixels: Rebuilt Atlas=%s Size=%dx%d Slices=%d ActivePixelSlots=%d TotalBytes=%d SliceBytes=%d"),
		*UserDefinedAtlas->GetPathName(),
		UserTextureSize,
		UserTextureSize,
		MaxUserTextureSlots,
		SlotPixels.Num(),
		AtlasBytes.Num(),
		SliceBytes);

	return true;
}

void UTileTextureRegistry::ResizeBGRA8(const TArray<uint8>& Src, int32 SrcWidth, int32 SrcHeight, TArray<uint8>& OutPixels) const
{
	OutPixels.SetNumUninitialized(UserTextureSize * UserTextureSize * 4);
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResizeBGRA8: Nearest-neighbor resize From=%dx%d To=%dx%d SrcBytes=%d OutBytes=%d"),
		SrcWidth,
		SrcHeight,
		UserTextureSize,
		UserTextureSize,
		Src.Num(),
		OutPixels.Num());

	for (int32 DstY = 0; DstY < UserTextureSize; ++DstY)
	{
		for (int32 DstX = 0; DstX < UserTextureSize; ++DstX)
		{
			const int32 SrcX = FMath::Clamp(FMath::FloorToInt(static_cast<float>(DstX) * static_cast<float>(SrcWidth) / static_cast<float>(UserTextureSize)), 0, SrcWidth - 1);
			const int32 SrcY = FMath::Clamp(FMath::FloorToInt(static_cast<float>(DstY) * static_cast<float>(SrcHeight) / static_cast<float>(UserTextureSize)), 0, SrcHeight - 1);

			const int32 SrcIndex = (SrcY * SrcWidth + SrcX) * 4;
			const int32 DstIndex = (DstY * UserTextureSize + DstX) * 4;
			OutPixels[DstIndex + 0] = Src[SrcIndex + 0];
			OutPixels[DstIndex + 1] = Src[SrcIndex + 1];
			OutPixels[DstIndex + 2] = Src[SrcIndex + 2];
			OutPixels[DstIndex + 3] = Src[SrcIndex + 3];
		}
	}

	if (OutPixels.Num() >= 4)
	{
		UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResizeBGRA8: FirstPixel BGRA=(%d,%d,%d,%d)"),
			OutPixels[0],
			OutPixels[1],
			OutPixels[2],
			OutPixels[3]);
	}
}
