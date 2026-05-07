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
	FIntVector OwningTileIndex = FIntVector(-1, -1, -1); \
	int32 OwningObjectIndex = -1; \
	ATileManager* OwningTileManager = nullptr; \
	virtual void SetOwningTileIndex(const FIntVector& OwningTile, const int32 ObjectIdx) \
	{ \
		OwningTileIndex = OwningTile;\
		OwningObjectIndex = ObjectIdx; \
	} \
	virtual void SetTileManager(ATileManager* owner) \
	{\
		OwningTileManager = owner;\
	}\
	\
	virtual const FIntVector& GetOwningTileIndex() \
	{ \
		return OwningTileIndex;\
	} \
	virtual FTileObject* GetOwningObject() \
	{ \
	if (!OwningTileManager) return nullptr; \
	   FSquareTile* ptr = OwningTileManager->GetSquareTilePtr(OwningTileIndex); \
	if (!ptr || !ptr->GetObjectsOnSquare().IsValidIndex(OwningObjectIndex)) \
	{ \
		UE_LOG(LogBarrelQuest, Error, TEXT("Invalid OwningObjectIndex %d for tile %s"), OwningObjectIndex, *OwningTileIndex.ToString()); \
		return nullptr; \
	} \
	return &ptr->GetObjectsOnSquare()[OwningObjectIndex]; \
	} \
	virtual void ResetOwners()\
	{\
		OwningTileIndex = FIntVector(-1, -1, -1);\
		OwningObjectIndex = -1;\
		OwningTileManager = nullptr;\
	}\
	virtual void InitializeFromObject(FTileObject& object)\
	{\
		for(const FName& key : object.runtimeData.Keys())\
		{\
			FRuntimeDataQueryResult q = object.runtimeData.GetValue(key);\
			object.runtimeData.SetValue(key, q.data);\
		}\
	}

UCLASS()
class BARRELQUEST_API UTileFeatureLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
};