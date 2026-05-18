


#include "RuntimeImporters/BarrelUGCRuntimeImporter.h"
#include "Audio.h"
#include "AudioDecompress.h"
#include "BarrelUtilityLibrary.h"
#include "Decoders/VorbisAudioInfo.h"
#include "Interfaces/IAudioFormat.h"
#include "Sound/SoundWaveProcedural.h"
#include "StaticMeshAttributes.h"

namespace
{
    void AppendInt16Sample(TArray<uint8>& PCMData, int16 Sample)
    {
        const int32 Offset = PCMData.AddUninitialized(sizeof(int16));
        FMemory::Memcpy(PCMData.GetData() + Offset, &Sample, sizeof(int16));
    }

    int16 FloatToInt16(float Value)
    {
        const float Clamped = FMath::Clamp(Value, -1.0f, 1.0f);
        return static_cast<int16>(Clamped * 32767.0f);
    }
}

UStaticMesh* UUGCAssetRegistry::GetOrLoadMesh(const TArray<uint8>& RawBytes, const FString& CacheKey, float ImportScale)
{
    const float SanitizedImportScale = ImportScale > 0.0f ? ImportScale : 100.0f;
    const FString ScaledCacheKey = FString::Printf(TEXT("%s:scale=%.6g"), *CacheKey, SanitizedImportScale);

	if (UStaticMesh** Found = MeshCache.Find(ScaledCacheKey))
	{
		return *Found; // already built, ignore bytes entirely
	}

	FParsedOBJMesh Parsed;
	if (!ParseOBJ(RawBytes, Parsed, SanitizedImportScale))
	{
		UE_LOG(LogTemp, Warning, TEXT("UGC: Failed to parse OBJ for key: %s"), *CacheKey);
		return nullptr;
	}

	UStaticMesh* Built = BuildStaticMesh(Parsed);
	if (Built)
	{
		MeshCache.Add(ScaledCacheKey, Built);
	}
	return Built;
}

USoundBase* UUGCAssetRegistry::GetOrLoadSound(const TArray<uint8>& RawBytes, const FString& CacheKey, EUGCAudioFormat Format, bool bLooping)
{
    const FString DecodedCacheKey = FString::Printf(TEXT("%s:%d"), *CacheKey, static_cast<int32>(Format));

    FDecodedUGCAudio Decoded;
    if (const FDecodedUGCAudio* Found = DecodedSoundCache.Find(DecodedCacheKey))
    {
        Decoded = *Found;
    }
    else
    {
        if (!DecodeSound(RawBytes, Format, Decoded))
        {
            UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: Failed to decode audio for key: %s"), *CacheKey);
            return nullptr;
        }

        DecodedSoundCache.Add(DecodedCacheKey, Decoded);
    }

    USoundBase* Built = BuildSoundWave(Decoded, bLooping);
    if (Built)
    {
        RuntimeSounds.Add(Built);
    }

    return Built;
}

void UUGCAssetRegistry::PurgeMeshCache()
{
	MeshCache.Empty();
    RuntimeSounds.Empty();
    DecodedSoundCache.Empty();
	// GC will clean up the UStaticMesh objects since UPROPERTY refs are gone
}

bool UUGCAssetRegistry::ParseOBJ(const TArray<uint8>& RawBytes, FParsedOBJMesh& Out, float ImportScale)
{
    if (RawBytes.Num() == 0)
    {
        return false;
    }

    FUTF8ToTCHAR ConvertedText(reinterpret_cast<const ANSICHAR*>(RawBytes.GetData()), RawBytes.Num());
    FString RawText(ConvertedText.Length(), ConvertedText.Get());

    TArray<FString> Lines;
    RawText.ParseIntoArrayLines(Lines);

    TArray<FVector>   RawPos;
    TArray<FVector2D> RawUV;
    TArray<FVector>   RawNorm;

    TMap<FString, int32> IndexMap; // "vi/ti/ni" -> final index

    for (const FString& Line : Lines)
    {
        TArray<FString> Tokens;
        Line.ParseIntoArray(Tokens, TEXT(" "), true);

        if (Tokens.Num() == 0) continue;

        if (Tokens[0] == "v" && Tokens.Num() >= 4)
        {
            RawPos.Add(FVector(
                FCString::Atof(*Tokens[1]),
                FCString::Atof(*Tokens[3]),
                FCString::Atof(*Tokens[2])
            ) * ImportScale);
        }
        else if (Tokens[0] == "vt" && Tokens.Num() >= 3)
        {
            RawUV.Add(FVector2D(
                FCString::Atof(*Tokens[1]),
                FCString::Atof(*Tokens[2])
            ));
        }
        else if (Tokens[0] == "vn" && Tokens.Num() >= 4)
        {
            RawNorm.Add(FVector(
                FCString::Atof(*Tokens[1]),
                FCString::Atof(*Tokens[3]),
                FCString::Atof(*Tokens[2])
            ));
            Out.bHasNormals = true;
        }
        else if (Tokens[0] == "f" && Tokens.Num() >= 4)
        {
            TArray<int32> FaceIndices;

            for (int32 i = 1; i < Tokens.Num(); i++)
            {
                if (int32* Found = IndexMap.Find(Tokens[i]))
                {
                    FaceIndices.Add(*Found);
                    continue;
                }

                TArray<FString> Components;
                Tokens[i].ParseIntoArray(Components, TEXT("/"), false);

                int32 pi = FCString::Atoi(*Components[0]) - 1;
                int32 ti = (Components.Num() > 1 && !Components[1].IsEmpty())
                               ? FCString::Atoi(*Components[1]) - 1 : -1;
                int32 ni = (Components.Num() > 2 && !Components[2].IsEmpty())
                               ? FCString::Atoi(*Components[2]) - 1 : -1;

                if (!RawPos.IsValidIndex(pi)) continue;

                Out.Positions.Add(RawPos[pi]);
                Out.UVs.Add(ti >= 0 && RawUV.IsValidIndex(ti)
                    ? RawUV[ti] : FVector2D::ZeroVector);
                Out.Normals.Add(ni >= 0 && RawNorm.IsValidIndex(ni)
                    ? RawNorm[ni] : FVector::UpVector);

                int32 FinalIdx = Out.Positions.Num() - 1;
                IndexMap.Add(Tokens[i], FinalIdx);
                FaceIndices.Add(FinalIdx);
            }

            // Fan triangulation. Preserve OBJ winding for this runtime mesh path.
            for (int32 i = 1; i < FaceIndices.Num() - 1; i++)
            {
                Out.Triangles.Add(FaceIndices[0]);
                Out.Triangles.Add(FaceIndices[i]);
                Out.Triangles.Add(FaceIndices[i + 1]);
            }
        }
    }

    return Out.Positions.Num() > 0 && Out.Triangles.Num() > 0;
}

UStaticMesh* UUGCAssetRegistry::BuildStaticMesh(const FParsedOBJMesh& Parsed)
{
    if (Parsed.Positions.Num() == 0 || Parsed.Triangles.Num() == 0)
    {
        return nullptr;
    }

    UStaticMesh* StaticMesh = NewObject<UStaticMesh>(this);
    StaticMesh->SetFlags(RF_Transient);

    FMeshDescription MeshDesc;
    FStaticMeshAttributes Attributes(MeshDesc);
    Attributes.Register();

    TVertexAttributesRef<FVector3f> VertPositions =
        Attributes.GetVertexPositions();

    TVertexInstanceAttributesRef<FVector2f> InstUVs =
        Attributes.GetVertexInstanceUVs();
    TVertexInstanceAttributesRef<FVector3f> InstNormals =
        Attributes.GetVertexInstanceNormals();

    InstUVs.SetNumChannels(1);

    // Create all vertices first
    TArray<FVertexID> VertexIDs;
    VertexIDs.Reserve(Parsed.Positions.Num());
    for (const FVector& Pos : Parsed.Positions)
    {
        FVertexID VID = MeshDesc.CreateVertex();
        VertPositions[VID] = FVector3f(Pos);
        VertexIDs.Add(VID);
    }

    FPolygonGroupID PolyGroup = MeshDesc.CreatePolygonGroup();

    // Build triangles
    for (int32 i = 0; i + 2 < Parsed.Triangles.Num(); i += 3)
    {
        TArray<FVertexInstanceID> Corners;
        Corners.Reserve(3);

        bool bValid = true;
        for (int32 c = 0; c < 3; c++)
        {
            int32 Idx = Parsed.Triangles[i + c];
            if (!VertexIDs.IsValidIndex(Idx))
            {
                bValid = false;
                break;
            }

            FVertexInstanceID VIID = MeshDesc.CreateVertexInstance(VertexIDs[Idx]);
            InstUVs.Set(VIID, 0, Parsed.UVs.IsValidIndex(Idx) ? FVector2f(Parsed.UVs[Idx]) : FVector2f::ZeroVector);
            if (Parsed.bHasNormals && Parsed.Normals.IsValidIndex(Idx))
            {
                InstNormals[VIID] = FVector3f(Parsed.Normals[Idx]);
            }
            Corners.Add(VIID);
        }

        if (bValid)
        {
            MeshDesc.CreatePolygon(PolyGroup, Corners);
        }
    }

    StaticMesh->GetStaticMaterials().Add(
        FStaticMaterial(UMaterial::GetDefaultMaterial(MD_Surface)));

    UStaticMesh::FBuildMeshDescriptionsParams BuildParams;
    BuildParams.bMarkPackageDirty = false;
    BuildParams.bFastBuild = true;
    BuildParams.bAllowCpuAccess = true;
    BuildParams.bCommitMeshDescription = false;

    TArray<const FMeshDescription*> MeshDescriptions;
    MeshDescriptions.Add(&MeshDesc);
    if (!StaticMesh->BuildFromMeshDescriptions(MeshDescriptions, BuildParams))
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: Failed to build runtime OBJ static mesh."));
        return nullptr;
    }

    StaticMesh->CalculateExtendedBounds();

    UE_LOG(LogBarrelQuest, Log, TEXT("UGC: Built runtime OBJ mesh with %d vertices and %d triangles"),
        Parsed.Positions.Num(),
        Parsed.Triangles.Num() / 3);

    return StaticMesh;
}

bool UUGCAssetRegistry::DecodeSound(const TArray<uint8>& RawBytes, EUGCAudioFormat Format, FDecodedUGCAudio& Out) const
{
    if (RawBytes.Num() == 0)
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: Audio import failed because RawBytes is empty."));
        return false;
    }

    if (Format == EUGCAudioFormat::Auto)
    {
        if (RawBytes.Num() >= 12
            && FMemory::Memcmp(RawBytes.GetData(), "RIFF", 4) == 0
            && FMemory::Memcmp(RawBytes.GetData() + 8, "WAVE", 4) == 0)
        {
            Format = EUGCAudioFormat::Wav;
        }
        else if (RawBytes.Num() >= 4 && FMemory::Memcmp(RawBytes.GetData(), "OggS", 4) == 0)
        {
            Format = EUGCAudioFormat::Ogg;
        }
        else
        {
            UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: Audio import failed because the file is neither RIFF/WAVE nor OggS. First bytes: %02x %02x %02x %02x"),
                RawBytes.Num() > 0 ? RawBytes[0] : 0,
                RawBytes.Num() > 1 ? RawBytes[1] : 0,
                RawBytes.Num() > 2 ? RawBytes[2] : 0,
                RawBytes.Num() > 3 ? RawBytes[3] : 0);
            return false;
        }
    }

    switch (Format)
    {
    case EUGCAudioFormat::Wav:
        return DecodeWav(RawBytes, Out);
    case EUGCAudioFormat::Ogg:
        return DecodeOgg(RawBytes, Out);
    default:
        return false;
    }
}

bool UUGCAssetRegistry::DecodeWav(const TArray<uint8>& RawBytes, FDecodedUGCAudio& Out) const
{
    FWaveModInfo WaveInfo;
    if (!WaveInfo.ReadWaveInfo(RawBytes.GetData(), RawBytes.Num()))
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because FWaveModInfo could not parse the file."));
        return false;
    }

    if (!WaveInfo.pChannels || !WaveInfo.pSamplesPerSec || !WaveInfo.pBitsPerSample || !WaveInfo.pFormatTag || !WaveInfo.SampleDataStart)
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because required WAV metadata is missing."));
        return false;
    }

    const uint16 FormatTag = *WaveInfo.pFormatTag;
    const uint16 BitsPerSample = *WaveInfo.pBitsPerSample;
    const int32 SampleDataSize = static_cast<int32>(WaveInfo.SampleDataSize);
    if (SampleDataSize <= 0)
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because it has no sample data."));
        return false;
    }

    Out.NumChannels = *WaveInfo.pChannels;
    Out.SampleRate = *WaveInfo.pSamplesPerSec;

    if (FormatTag == FWaveModInfo::WAVE_INFO_FORMAT_PCM && BitsPerSample == 16)
    {
        Out.PCMData.SetNumUninitialized(SampleDataSize);
        FMemory::Memcpy(Out.PCMData.GetData(), WaveInfo.SampleDataStart, SampleDataSize);
    }
    else if (FormatTag == FWaveModInfo::WAVE_INFO_FORMAT_PCM && BitsPerSample == 8)
    {
        Out.PCMData.Reserve(SampleDataSize * sizeof(int16));
        for (int32 i = 0; i < SampleDataSize; ++i)
        {
            const int16 Sample = (static_cast<int16>(WaveInfo.SampleDataStart[i]) - 128) << 8;
            AppendInt16Sample(Out.PCMData, Sample);
        }
    }
    else if (FormatTag == FWaveModInfo::WAVE_INFO_FORMAT_PCM && BitsPerSample == 24)
    {
        if ((SampleDataSize % 3) != 0)
        {
            UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because 24-bit sample data is not frame-aligned."));
            return false;
        }

        Out.PCMData.Reserve((SampleDataSize / 3) * sizeof(int16));
        for (int32 i = 0; i < SampleDataSize; i += 3)
        {
            int32 Sample24 =
                (static_cast<int32>(WaveInfo.SampleDataStart[i + 0]) << 8) |
                (static_cast<int32>(WaveInfo.SampleDataStart[i + 1]) << 16) |
                (static_cast<int32>(WaveInfo.SampleDataStart[i + 2]) << 24);
            Sample24 >>= 16;
            AppendInt16Sample(Out.PCMData, static_cast<int16>(Sample24));
        }
    }
    else if (FormatTag == FWaveModInfo::WAVE_INFO_FORMAT_PCM && BitsPerSample == 32)
    {
        if ((SampleDataSize % 4) != 0)
        {
            UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because 32-bit sample data is not frame-aligned."));
            return false;
        }

        Out.PCMData.Reserve((SampleDataSize / 4) * sizeof(int16));
        for (int32 i = 0; i < SampleDataSize; i += 4)
        {
            int32 Sample32 = 0;
            FMemory::Memcpy(&Sample32, WaveInfo.SampleDataStart + i, sizeof(int32));
            AppendInt16Sample(Out.PCMData, static_cast<int16>(Sample32 >> 16));
        }
    }
    else if (FormatTag == FWaveModInfo::WAVE_INFO_FORMAT_IEEE_FLOAT && BitsPerSample == 32)
    {
        if ((SampleDataSize % 4) != 0)
        {
            UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because float sample data is not frame-aligned."));
            return false;
        }

        Out.PCMData.Reserve((SampleDataSize / 4) * sizeof(int16));
        for (int32 i = 0; i < SampleDataSize; i += 4)
        {
            float SampleFloat = 0.0f;
            FMemory::Memcpy(&SampleFloat, WaveInfo.SampleDataStart + i, sizeof(float));
            AppendInt16Sample(Out.PCMData, FloatToInt16(SampleFloat));
        }
    }
    else
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: WAV import failed because format %u with %u bits per sample is unsupported."),
            FormatTag,
            BitsPerSample);
        return false;
    }

    const int32 BytesPerFrame = Out.NumChannels * sizeof(int16);
    Out.Duration = BytesPerFrame > 0 && Out.SampleRate > 0
        ? static_cast<float>(Out.PCMData.Num()) / static_cast<float>(BytesPerFrame * Out.SampleRate)
        : 0.0f;

    return Out.NumChannels > 0 && Out.SampleRate > 0 && Out.PCMData.Num() > 0;
}

bool UUGCAssetRegistry::DecodeOgg(const TArray<uint8>& RawBytes, FDecodedUGCAudio& Out) const
{
#if WITH_OGGVORBIS
    LoadVorbisLibraries();

    FVorbisAudioInfo AudioInfo;
    FSoundQualityInfo QualityInfo;

    if (!AudioInfo.ReadCompressedInfo(RawBytes.GetData(), RawBytes.Num(), &QualityInfo))
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: OGG import failed because Vorbis could not read compressed info."));
        return false;
    }

    if (QualityInfo.SampleDataSize == 0 || QualityInfo.NumChannels == 0 || QualityInfo.SampleRate == 0)
    {
        UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: OGG import failed because decoded metadata is invalid. Channels=%u SampleRate=%u Size=%u"),
            QualityInfo.NumChannels,
            QualityInfo.SampleRate,
            QualityInfo.SampleDataSize);
        return false;
    }

    Out.PCMData.SetNumUninitialized(QualityInfo.SampleDataSize);
    AudioInfo.ExpandFile(Out.PCMData.GetData(), &QualityInfo);

    Out.NumChannels = QualityInfo.NumChannels;
    Out.SampleRate = QualityInfo.SampleRate;
    Out.Duration = QualityInfo.Duration;

    return true;
#else
    UE_LOG(LogBarrelQuest, Warning, TEXT("UGC: OGG import is unavailable because this target was built without Ogg Vorbis support. Try WAV or enable Ogg Vorbis for this target."));
    return false;
#endif
}

USoundBase* UUGCAssetRegistry::BuildSoundWave(const FDecodedUGCAudio& Decoded, bool bLooping)
{
    if (Decoded.PCMData.Num() == 0 || Decoded.NumChannels <= 0 || Decoded.SampleRate <= 0)
    {
        return nullptr;
    }

    USoundWaveProcedural* SoundWave = NewObject<USoundWaveProcedural>(this);
    SoundWave->SetFlags(RF_Transient);
    SoundWave->NumChannels = Decoded.NumChannels;
    SoundWave->SetSampleRate(Decoded.SampleRate);
    SoundWave->Duration = Decoded.Duration;
    SoundWave->SoundGroup = SOUNDGROUP_Default;
    SoundWave->SampleByteSize = sizeof(int16);
    SoundWave->bLooping = bLooping;

    TSharedRef<TArray<uint8>, ESPMode::ThreadSafe> LoopPCM = MakeShared<TArray<uint8>, ESPMode::ThreadSafe>(Decoded.PCMData);
    SoundWave->QueueAudio(LoopPCM->GetData(), LoopPCM->Num());

    if (bLooping)
    {
        SoundWave->OnSoundWaveProceduralUnderflow.BindLambda(
            [LoopPCM](USoundWaveProcedural* UnderflowSoundWave, int32 SamplesRequired)
            {
                if (UnderflowSoundWave && LoopPCM->Num() > 0)
                {
                    UnderflowSoundWave->QueueAudio(LoopPCM->GetData(), LoopPCM->Num());
                }
            });
    }

    UE_LOG(LogBarrelQuest, Log, TEXT("UGC: Built runtime sound with %d channels at %d Hz, %.2f seconds, looping=%s"),
        Decoded.NumChannels,
        Decoded.SampleRate,
        Decoded.Duration,
        bLooping ? TEXT("true") : TEXT("false"));

    return SoundWave;
}
