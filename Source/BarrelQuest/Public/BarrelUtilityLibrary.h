#pragma once

#include "CoreMinimal.h"
#include "BarrelUtilityLibrary.generated.h"

DECLARE_LOG_CATEGORY_EXTERN(LogBarrelQuest, Log, All);
DECLARE_LOG_CATEGORY_EXTERN(LogBarrelQuestTileManager, Log, All);
DECLARE_LOG_CATEGORY_EXTERN(LogBarrelQuestTileChunk, Log, All);
DECLARE_LOG_CATEGORY_EXTERN(LogBarrelQuestLoad, Log, All);
DECLARE_LOG_CATEGORY_EXTERN(LogBarrelQuestSave, Log, All);

UENUM(BlueprintType)
enum class EClothingType : uint8
{
	Hat,
	Head,
	Neck,
	Torso,
	Legs,
	Feet
};

USTRUCT(BlueprintType)
struct FWearingClothingData : public FTableRowBase
{
	GENERATED_BODY()
    
	FWearingClothingData() : dirtLevel(0.0f), wearLevel(0.0f), wetLevel(0.0f), insulationLevel(0.0f), clothingType(EClothingType::Torso) {}
    
	FWearingClothingData(float newDirtLevel, float newWearLevel, float newWetLevel, float newInsulationLevel, EClothingType newClothingType) 
	: dirtLevel(newDirtLevel), wearLevel(newWearLevel), wetLevel(newWetLevel), insulationLevel(newInsulationLevel), clothingType(newClothingType) {}

public:
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float dirtLevel;
    
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float wearLevel;
    
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float wetLevel;
    
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	float insulationLevel;
    
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TArray<FName> holes;
    
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	EClothingType clothingType;
};

class BARRELQUEST_API BarrelUtilityLibrary
{
public:
	// Regular C++ class - no GENERATED_BODY() needed here
};