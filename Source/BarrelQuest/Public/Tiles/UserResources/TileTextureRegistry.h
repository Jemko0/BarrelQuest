// 

#pragma once

#include "CoreMinimal.h"
#include "Engine/Texture2D.h"
#include "Engine/Texture2DArray.h"
#include "Subsystems/GameInstanceSubsystem.h"
#include "TileTextureRegistry.generated.h"

UENUM(BlueprintType)
enum class ERegisteredAssetType : uint8
{
	None,
	CookedAsset,
	RuntimeTexture
};

USTRUCT(BlueprintType)
struct FTileSavedAssetHandle
{
	GENERATED_BODY()

	UPROPERTY(EditAnywhere, BlueprintReadWrite, SaveGame)
	FString Id;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, SaveGame)
	ERegisteredAssetType Kind = ERegisteredAssetType::None;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, SaveGame)
	FSoftObjectPath AssetPath;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, SaveGame)
	FString Url;
};

USTRUCT(BlueprintType)
struct FTileRegisteredTexture
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadOnly)
	ERegisteredAssetType Kind = ERegisteredAssetType::None;

	UPROPERTY(BlueprintReadOnly)
	TSoftObjectPtr<UTexture2D> CookedTexture;

	UPROPERTY(BlueprintReadOnly)
	int32 Slot = INDEX_NONE;

	bool IsValid() const
	{
		return Slot != INDEX_NONE && Kind != ERegisteredAssetType::None;
	}
};

UCLASS()
class BARRELQUEST_API UTileTextureRegistry : public UGameInstanceSubsystem
{
	GENERATED_BODY()

public:
	static constexpr int32 MaxUserTextureSlots = 32;
	static constexpr int32 UserTextureSize = 1024;

	virtual void Initialize(FSubsystemCollectionBase& Collection) override;

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	int32 RegisterRuntimeTextureBytesWithHandle(const TArray<uint8>& RawBytes, FTileSavedAssetHandle Handle);

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	int32 RegisterCookedTextureWithHandle(TSoftObjectPtr<UTexture2D> Texture, FTileSavedAssetHandle Handle);

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	bool ResolveTexture(int32 Slot);

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	void ReleaseTextureSlot(int32 Slot);

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	FTileRegisteredTexture GetTextureInfo(int32 Slot) const;
	
	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	bool ResolveFromHandle(FTileSavedAssetHandle handle);

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	int32 ResolveSlotFromHandle(FTileSavedAssetHandle handle);

	UFUNCTION(BlueprintCallable, Category="Tile Textures")
	UTexture2DArray* GetUserDefinedAtlas() const;

protected:
	UPROPERTY()
	TObjectPtr<UTexture2DArray> UserDefinedAtlas;

	UPROPERTY()
	TMap<int32, FTileRegisteredTexture> SlotToTexture;

	UPROPERTY()
	TMap<FSoftObjectPath, int32> CookedTextureToSlot;

	UPROPERTY()
	TMap<FString, int32> HandleIdToSlot;

	TArray<int32> FreeSlots;
	TMap<int32, TArray<uint8>> SlotPixels;

	int32 RegisterCookedTextureInternal(TSoftObjectPtr<UTexture2D> Texture);
	void CreateUserDefinedAtlas();
	bool DecodeImageBytesToBGRA8(const TArray<uint8>& RawBytes, TArray<uint8>& OutPixels, int32& OutWidth, int32& OutHeight) const;
	bool RebuildAtlasFromSlotPixels();
	void ResizeBGRA8(const TArray<uint8>& Src, int32 SrcWidth, int32 SrcHeight, TArray<uint8>& OutPixels) const;
};
