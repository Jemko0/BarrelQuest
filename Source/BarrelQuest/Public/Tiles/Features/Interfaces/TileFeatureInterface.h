// 

#pragma once

#include "CoreMinimal.h"
#include "Tiles/TileLibrary.h"
#include "UObject/Interface.h"
#include "TileFeatureInterface.generated.h"

// This class does not need to be modified.
UINTERFACE()
class UTileFeatureInterface : public UInterface
{
	GENERATED_BODY()
};

/**
 * 
 */
class BARRELQUEST_API ITileFeatureInterface
{
	GENERATED_BODY()

	// Add interface functions to this class. This is the class that will be inherited to implement this interface.
public:
	virtual void BindRuntimeData(FTileRuntimeData& RuntimeData) = 0;
	virtual void SetOwningTileIndex(const FIntVector& OwningTile, const int32 ObjectIdx) = 0;
	virtual void SetTileManager(ATileManager* owner) = 0;
	virtual const FIntVector& GetOwningTileIndex() = 0;
	
	TArray<FDelegateHandle> InternalHandles;
	
protected:
	void BindKey(FTileRuntimeData& RuntimeData, FName Key, TFunction<void(const FString&)> Callback)
	{
		FDelegateHandle Handle = RuntimeData.OnChanged.AddLambda(
		   [Key, Callback](FName ChangedKey, const FString& Value)
		   {
			  if (ChangedKey == Key) Callback(Value);
		   }
		);
		InternalHandles.Add(Handle);
	}
public:
	virtual void UnbindFromData(FTileRuntimeData& RuntimeData)
	{
		for (FDelegateHandle& Handle : InternalHandles)
		{
			RuntimeData.OnChanged.Remove(Handle);
		}
		InternalHandles.Empty();
	}
};
