#include "Tiles/UserResources/TileTextureRegistry.h"

#include "ImageUtils.h"

namespace
{
	const TCHAR* TileTextureKindToString(ETileRegisteredTextureKind Kind)
	{
		switch (Kind)
		{
		case ETileRegisteredTextureKind::CookedAsset:
			return TEXT("CookedAsset");
		case ETileRegisteredTextureKind::RuntimeTexture:
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

	FString DescribeHandle(const FTileSavedTextureHandle& Handle)
	{
		return FString::Printf(
			TEXT("Id='%s' Kind=%s AssetPath='%s' Url='%s'"),
			*Handle.Id,
			TileTextureKindToString(Handle.Kind),
			*Handle.AssetPath.ToString(),
			*Handle.Url);
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
			UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ExtractBGRA8Pixels: Unsupported pixel format %d for Texture=%s. Expected PF_B8G8R8A8=%d."),
				static_cast<int32>(PlatformData->PixelFormat),
				*DescribeTexture(Texture),
				static_cast<int32>(PF_B8G8R8A8));
			return false;
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

	SlotToTexture.Empty();
	CookedTextureToSlot.Empty();
	HandleIdToSlot.Empty();
	SlotPixels.Empty();
	FreeSlots.Empty();

	for (int32 Slot = MaxUserTextureSlots - 1; Slot >= 0; --Slot)
	{
		FreeSlots.Add(Slot);
	}

	CreateUserDefinedAtlas();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry: Initialized. MaxSlots=%d FreeSlots=%d Atlas=%s"),
		MaxUserTextureSlots,
		FreeSlots.Num(),
		UserDefinedAtlas ? *UserDefinedAtlas->GetPathName() : TEXT("<null>"));
}

bool UTileTextureRegistry::ResolveFromHandle(FTileSavedTextureHandle handle)
{
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveFromHandle: Handle={%s}"), *DescribeHandle(handle));
	const int32 Slot = ResolveSlotFromHandle(handle);
	const bool bResolved = ResolveTexture(Slot);
	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::ResolveFromHandle: Slot=%d Resolved=%s"), Slot, bResolved ? TEXT("true") : TEXT("false"));
	return bResolved;
}

int32 UTileTextureRegistry::ResolveSlotFromHandle(FTileSavedTextureHandle handle)
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
	case ETileRegisteredTextureKind::CookedAsset:
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

	case ETileRegisteredTextureKind::RuntimeTexture:
		UE_LOG(LogTemp, Warning, TEXT("UTileTextureRegistry::ResolveSlotFromHandle: Runtime texture is not registered yet. Register RawBytes with this handle first. Handle={%s}"), *DescribeHandle(handle));
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

void UTileTextureRegistry::CreateUserDefinedAtlas()
{
	UserDefinedAtlas = NewObject<UTexture2DArray>(this, TEXT("UserDefinedTileTextureArray"));
	if (!UserDefinedAtlas)
	{
		UE_LOG(LogTemp, Error, TEXT("UTileTextureRegistry::CreateUserDefinedAtlas: Failed to create UTexture2DArray."));
		return;
	}

	UserDefinedAtlas->Source.Init(UserTextureSize, UserTextureSize, MaxUserTextureSlots, 1, TSF_BGRA8);
	UserDefinedAtlas->UpdateResource();

	UE_LOG(LogTemp, Display, TEXT("UTileTextureRegistry::CreateUserDefinedAtlas: Created Atlas=%s Size=%dx%d Slices=%d Mips=1 Format=TSF_BGRA8"),
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

int32 UTileTextureRegistry::RegisterRuntimeTextureBytesWithHandle(const TArray<uint8>& RawBytes, FTileSavedTextureHandle Handle)
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
	Entry.Kind = ETileRegisteredTextureKind::RuntimeTexture;
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

int32 UTileTextureRegistry::RegisterCookedTextureWithHandle(TSoftObjectPtr<UTexture2D> Texture, FTileSavedTextureHandle Handle)
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
	Entry.Kind = ETileRegisteredTextureKind::CookedAsset;
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

	UserDefinedAtlas->Source.Init(UserTextureSize, UserTextureSize, MaxUserTextureSlots, 1, TSF_BGRA8, AtlasBytes.GetData());
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
