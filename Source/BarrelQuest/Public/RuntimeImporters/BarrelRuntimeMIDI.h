// 

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "BarrelRuntimeMIDI.generated.h"

USTRUCT(BlueprintType)
struct FBarrelRuntimeMIDISettings
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="MIDI")
	bool bLooping = false;

	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="MIDI", meta=(ClampMin="0.1", UIMin="0.1"))
	float PlaybackSpeed = 1.0f;

	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="MIDI", meta=(ClampMin="0.0", ClampMax="1.0", UIMin="0.0", UIMax="1.0"))
	float Volume = 1.0f;
};

/**
 * Runtime Standard MIDI File playback through the OS MIDI device.
 *
 * This sends MIDI events to the platform MIDI output, so it does not return a USoundBase
 * and does not route through Unreal's audio mixer.
 */
UCLASS()
class BARRELQUEST_API UBarrelRuntimeMIDI : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category="UGC|MIDI")
	static bool PlayMIDIFromBytes(const TArray<uint8>& RawBytes, const FBarrelRuntimeMIDISettings& Settings);

	UFUNCTION(BlueprintCallable, Category="UGC|MIDI")
	static void StopMIDI();

	UFUNCTION(BlueprintPure, Category="UGC|MIDI")
	static bool IsMIDIPlaying();
};
