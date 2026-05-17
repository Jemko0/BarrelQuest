// 

#pragma once

#include "CoreMinimal.h"
#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "Tiles/TileManager.h"
#include "Tiles/SavingLoading/MapEditorWorldSaveGame.h"
#include "TileManagerUGC.generated.h"

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
	FWorldBGMData WorldBGMData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FWorldEnvironmentData WorldEnvironmentData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FString, FTileSavedAssetHandle> PendingRegistryHandles;
	
	UFUNCTION(BLueprintCallable)
	void LoadFromSave(UMapEditorWorldSaveGame* SaveGame);
	
	UPROPERTY()
	UMapEditorWorldSaveGame* CurrentLoadPendingSave;
	
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

private:
	UTileTextureRegistry* GetOrCacheTileTextureRegistry();
};

