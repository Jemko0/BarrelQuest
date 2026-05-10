

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "Sound/SoundBase.h"
#include "BarrelUGCRuntimeImporter.generated.h"

struct FParsedOBJMesh
{
	TArray<FVector> Positions;
	TArray<FVector> Normals;
	TArray<FVector2D> UVs;
	TArray<int32> Triangles;
	bool bHasNormals = false;
};

UENUM(BlueprintType)
enum class EUGCAudioFormat : uint8
{
	Auto,
	Wav,
	Ogg
};

struct FDecodedUGCAudio
{
	TArray<uint8> PCMData;
	int32 NumChannels = 0;
	int32 SampleRate = 0;
	float Duration = 0.0f;
};

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UUGCAssetRegistry : public UGameInstanceSubsystem
{
	GENERATED_BODY()

public:
	// Blueprint-callable entry point
	UFUNCTION(BlueprintCallable, Category="UGC")
	UStaticMesh* GetOrLoadMesh(const TArray<uint8>& RawBytes, const FString& CacheKey);

	UFUNCTION(BlueprintCallable, Category="UGC")
	USoundBase* GetOrLoadSound(const TArray<uint8>& RawBytes, const FString& CacheKey, EUGCAudioFormat Format = EUGCAudioFormat::Auto, bool bLooping = false);

	UFUNCTION(BlueprintCallable, Category="UGC")
	void PurgeMeshCache(); // call when unloading a user map

	// Future
	// UTexture2D* GetOrLoadTexture(const FString& Path);
	// USoundWave* GetOrLoadAudio(const FString& Path);

private:
	UPROPERTY()
	TMap<FString, UStaticMesh*> MeshCache; // UPROPERTY keeps GC from eating them

	UPROPERTY()
	TArray<USoundBase*> RuntimeSounds;

	TMap<FString, FDecodedUGCAudio> DecodedSoundCache;

	UStaticMesh* ParseAndBuild(const FString& Path);
	bool ParseOBJ(const TArray<uint8>& RawBytes, FParsedOBJMesh& Out);
	UStaticMesh* BuildStaticMesh(const FParsedOBJMesh& Parsed);

	bool DecodeSound(const TArray<uint8>& RawBytes, EUGCAudioFormat Format, FDecodedUGCAudio& Out) const;
	bool DecodeWav(const TArray<uint8>& RawBytes, FDecodedUGCAudio& Out) const;
	bool DecodeOgg(const TArray<uint8>& RawBytes, FDecodedUGCAudio& Out) const;
	USoundBase* BuildSoundWave(const FDecodedUGCAudio& Decoded, bool bLooping);
};
