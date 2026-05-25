// 

#pragma once

#include "CoreMinimal.h"
#include "Interfaces/IHttpRequest.h"
#include "Interfaces/IHttpResponse.h"
#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "Tiles/TileManager.h"
#include "Tiles/TileUGCLibrary.h"
#include "Tiles/TileSaveLoadLibrary.h"
#include "TileManagerUGC.generated.h"

class FJsonObject;

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FOnWorldLoadExit, bool, Success, FString, Message);

UCLASS()
class BARRELQUEST_API ATileManagerUGC : public ATileManager
{
	GENERATED_BODY()

public:
	// Sets default values for this actor's properties
	ATileManagerUGC();

	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	UUserResourceComponent* UserResourceComponent;
	
protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:
	// Called every frame
	virtual void Tick(float DeltaTime) override;
	
	FDateTime WorldLoadStartTime;
	FDateTime WorldLoadEndTime;
	
	UPROPERTY()
	UTileTextureRegistry* TileTextureRegistry;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	int32 CurrentWorldID = -1;

	UPROPERTY(BlueprintReadOnly, VisibleAnywhere)
	FDreamWorldMetadata CurrentDreamWorldMetadata;
	
	//key = the transition object id
	UPROPERTY(BlueprintReadOnly, VisibleAnywhere)
	TMap<int64, FDreamWorldConnection> WorldOutgoingConnections;

	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FWorldBGMData WorldBGMData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FWorldEnvironmentData WorldEnvironmentData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FString, FTileSavedAssetHandle> PendingRegistryHandles;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FName> AvailableTransitionTargetNames;

	UFUNCTION(BLueprintCallable)
	void LoadFromSave(UMapEditorWorldSaveGame* SaveGame);
	
	UPROPERTY()
	UMapEditorWorldSaveGame* CurrentLoadPendingSave;

	bool bIsRegisteringLoadUGC = false;
	bool bIsLoadingWorldFromAPI = false;
	
	UPROPERTY(BlueprintAssignable)
	FOnWorldLoadExit OnWorldLoadExit;
	
	void LFS_Stage_LoadDefaults(UMapEditorWorldSaveGame* SaveGame);
	void LFS_Stage_LoadUGC(UMapEditorWorldSaveGame* SaveGame);
	void LFS_Stage_LoadTiles(UMapEditorWorldSaveGame* SaveGame);
	void ExitWorldLoading(bool success, FString msg);
	
	UFUNCTION()
	void HandleUGCDownloadFinished(FString ResourceURL, FString ResourceType, TArray<uint8> Bytes);
	
	UFUNCTION()
	void HandleUGCDownloadFailed(FString ResourceURL, FString ResourceType, FString Error);
	
	UFUNCTION()
	void HandleUGCDownloadStarted(FString ResourceURL, FString ResourceType);
	
	UFUNCTION(BlueprintCallable)
	void RegisterTileDefinitionUGCItems(const FTileDefinition& TileDefinition);
	
	UFUNCTION(BlueprintCallable)
	void CreateUserDefinedTile(const FName& ID, const FTileDefinition& Definition);
	
	UFUNCTION(BlueprintCallable)
	void ClearEverything();

	UFUNCTION(BlueprintCallable)
	void LoadWorldFromAPI(int32 ID);

private:
	UTileTextureRegistry* GetOrCacheTileTextureRegistry();
	bool TryContinueLoadAfterUGC(const FString& Reason);
	FString DescribePendingRegistryHandlesForLog() const;
	void HandleWorldMetadataRequestComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool bSuccess, int32 RequestedWorldID);
	void HandleWorldSaveDownloadComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool bSuccess, int32 RequestedWorldID, FString MapFileURL);
	bool ParseDreamWorldMetadata(const FString& ResponseBody, FDreamWorldMetadata& OutMetadata, FString& OutError) const;
	bool TryParseDateTimeField(const TSharedPtr<FJsonObject>& JsonObject, const FString& FieldName, FDateTime& OutDateTime) const;
	FString GetDownloadedWorldSavePath(int32 WorldID) const;
};
