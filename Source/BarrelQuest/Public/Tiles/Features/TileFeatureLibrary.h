// 

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "BarrelUtilityLibrary.h"
#include "Tiles/TileManager.h"
#include "TileFeatureLibrary.generated.h"

/**
 * 
 */

/*
 * General Macro for tile features, this belongs into the class body of a TileFeature header file.
 * This Macro handles automatic ownership transfer and adds new member variables
 * like:
 *	OwningTileIndex (FIntVector)
 *	OwningObjectIndex (int32)
 *	OwningTileManager (ATileManager*)
 */
#define TF_GENERATED_BODY() \
	protected: \
	FTileFeatureOwnerState OwnerState;\
	virtual void SetOwningTileIndex(const FIntVector& OwningTile, const int32 ObjectIdx) \
	{ \
		OwnerState.OwningTileIndex = OwningTile;\
		OwnerState.OwningObjectIndex = ObjectIdx; \
	} \
	virtual void SetTileManager(ATileManager* owner) \
	{\
		OwnerState.OwningTileManager = owner;\
	}\
	\
	virtual const FIntVector& GetOwningTileIndex() \
	{ \
		return OwnerState.OwningTileIndex;\
	} \
	virtual FTileObject* GetOwningObject() \
	{ \
	if (!OwnerState.OwningTileManager) return nullptr; \
	   FSquareTile* ptr = OwnerState.OwningTileManager->GetSquareTilePtr(OwnerState.OwningTileIndex); \
	if (!ptr || !ptr->GetObjectsOnSquare().IsValidIndex(OwnerState.OwningObjectIndex)) \
	{ \
		UE_LOG(LogBarrelQuest, Error, TEXT("Invalid OwningObjectIndex %d for tile %s"), OwnerState.OwningObjectIndex, *OwnerState.OwningTileIndex.ToString()); \
		return nullptr; \
	} \
	return &ptr->GetObjectsOnSquare()[OwnerState.OwningObjectIndex]; \
	} \
	virtual void ResetOwners()\
	{\
		OwnerState.OwningTileIndex = FIntVector(-1, -1, -1);\
		OwnerState.OwningObjectIndex = -1;\
		OwnerState.OwningTileManager = nullptr;\
	}\
	virtual void InitializeFromObject(FTileObject& object)\
	{\
		for(const FName& key : object.runtimeData.Keys())\
		{\
			FRuntimeDataQueryResult q = object.runtimeData.GetValue(key);\
			object.runtimeData.SetValue(key, q.data);\
		}\
	}\
	virtual FTileFeatureOwnerState GetOwnerState()\
	{\
		return OwnerState;\
	}\
	virtual void SetFeatureName(const FName& name)\
	{\
		OwnerState.FeatureName = name;\
	}\

USTRUCT(BlueprintType)
struct FTileFeatureOwnerState
{
	GENERATED_BODY()
public:
	UPROPERTY(BlueprintReadOnly)
	FIntVector OwningTileIndex = FIntVector(-1, -1, -1); 
	
	UPROPERTY(BlueprintReadOnly)
	int32 OwningObjectIndex = -1; 
	
	UPROPERTY(BlueprintReadOnly)
	TObjectPtr<ATileManager> OwningTileManager = nullptr;
	
	UPROPERTY(BlueprintReadOnly)
	FName FeatureName; 
};

UCLASS()
class BARRELQUEST_API UTileFeatureLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
};
