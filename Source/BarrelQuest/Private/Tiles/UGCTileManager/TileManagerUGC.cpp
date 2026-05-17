// 


#include "Tiles/UGCTileManager/TileManagerUGC.h"
#include "Tiles/TileChunk.h"
#include "BarrelUtilityLibrary.h"
#include "Kismet/GameplayStatics.h"
#include "Kismet/KismetSystemLibrary.h"
#include "MapEditorBase/MapEditorControllerBase.h"


// Sets default values
ATileManagerUGC::ATileManagerUGC()
{
	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
	UserResourceComponent = CreateDefaultSubobject<UUserResourceComponent>(TEXT("User Resource Component"));
}

// Called when the game starts or when spawned
void ATileManagerUGC::BeginPlay()
{
	Super::BeginPlay();
	TileTextureRegistry = GetOrCacheTileTextureRegistry();
	
	UserResourceComponent->OnDownloadFinished.AddDynamic(this, &ATileManagerUGC::HandleUGCDownloadFinished);
	UserResourceComponent->OnDownloadStarted.AddDynamic(this, &ATileManagerUGC::HandleUGCDownloadStarted);
	UserResourceComponent->OnDownloadFailed.AddDynamic(this, &ATileManagerUGC::HandleUGCDownloadFailed);
}

// Called every frame
void ATileManagerUGC::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
}

void ATileManagerUGC::LoadFromSave(UMapEditorWorldSaveGame* SaveGame)
{
	ClearEverything();
	
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Starting World Load From Save"));
	
	WorldLoadStartTime = FDateTime::Now();
	LFS_Stage_LoadDefaults(SaveGame);
}

void ATileManagerUGC::LFS_Stage_LoadDefaults(UMapEditorWorldSaveGame* SaveGame)
{
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Entering Load Stage: LoadDefaults"));
	
	WorldName = SaveGame->WorldName;
	WorldVersion = SaveGame->Version;
	
	UserDefinedTileDefinitions = SaveGame->UserDefinedTiles;
	
	WorldBGMData = SaveGame->BGMData;
	WorldEnvironmentData = SaveGame->EnvironmentData;
	
	if (!UserDefinedTileDefinitions.IsEmpty())
	{
		LFS_Stage_LoadUGC(SaveGame);
	}
	else
	{
		LFS_Stage_LoadTiles(SaveGame);
	}
	
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Exiting Load Stage: LoadDefaults"));
}

void ATileManagerUGC::LFS_Stage_LoadUGC(UMapEditorWorldSaveGame* SaveGame)
{
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Entering Load Stage: LoadUGC"));
	
	TArray<FTileDefinition> UserDefDefs;
	UserDefinedTileDefinitions.GenerateValueArray(UserDefDefs);
	
	CurrentLoadPendingSave = SaveGame;
	
	for (FTileDefinition& def : UserDefDefs)
	{
		RegisterTileDefinitionUGCItems(def);
		
		UE_LOG(LogBarrelQuestLoad, Verbose, TEXT("Registering Tile Def UGC Items for: %s"), *def.Name);
	}
	
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Exiting Load Stage: LoadUGC"));
}

void ATileManagerUGC::LFS_Stage_LoadTiles(UMapEditorWorldSaveGame* SaveGame)
{
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Entering Load Stage: LoadTiles"));
	
	for (TPair<FIntVector2, FSavedChunk>& pair : SaveGame->WorldChunks)
	{
		ATileChunk* ChunkPtr = SpawnChunk(pair.Key);
		if (!ChunkPtr)
		{
			UE_LOG(LogBarrelQuestLoad, Warning, TEXT("LFS_Stage_LoadTiles: ChunkPtr was null!"));
			return;
		}
		
		ChunkPtr->SetTiles(pair.Value.SquarePositions, pair.Value.ChunkSquares);
	}
	
	RoomIDToTiles = SaveGame->RoomIDToTiles;
	RoomTilesToID = SaveGame->TilesToRoomID;
	
	AMapEditorControllerBase* MapEditorController = Cast<AMapEditorControllerBase>(UGameplayStatics::GetActorOfClass(
															this, TSubclassOf<AMapEditorControllerBase>()));
	
	if (MapEditorController)
	{
		TObjectPtr<APawn> MEPawn = MapEditorController->GetPawn();
		if (!MEPawn)
		{
			UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Map Editor Controller had no pawn assigned. returning"));
			return;
		}
		
		MEPawn->SetActorLocation(SaveGame->MapEditorData.PawnLocation);
		MapEditorController->SetControlRotation(SaveGame->MapEditorData.CameraRotation);
		MapEditorController->SelectedTileID = SaveGame->MapEditorData.SelectedTileID;
	}
	else
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("No Map Editor Controller Found, Skipping."));
	}
	
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Exiting Load Stage: LoadTiles"));
	
	ExitWorldLoading(true, TEXT(""));
}

void ATileManagerUGC::ExitWorldLoading(bool success, FString msg)
{
	WorldLoadEndTime = FDateTime::Now();
	CurrentLoadPendingSave = nullptr;
	
	FTimespan LoadingTime = WorldLoadEndTime - WorldLoadStartTime;
	
	UE_LOG(LogBarrelQuestLoad, Display, TEXT("World Loading Finished in %f Seconds"), LoadingTime.GetTotalSeconds());
	OnWorldLoadExit.Broadcast(success, msg);
}

void ATileManagerUGC::HandleUGCDownloadFinished(FString ResourceURL, FString ResourceType, TArray<uint8> Bytes)
{
	FInterpretedResourceData Interpreted = UserResourceComponent->InterpretData(this, ResourceURL, ResourceType, Bytes);
	UTileTextureRegistry* Registry = GetOrCacheTileTextureRegistry();
	if (!Registry)
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("HandleUGCDownloadFinished: TileTextureRegistry was null. ResourceURL='%s' ResourceType='%s'"),
			*ResourceURL,
			*ResourceType);
		return;
	}
	
	FTileSavedAssetHandle* HandlePtr = PendingRegistryHandles.Find(ResourceURL);
	
	if (!HandlePtr)
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("UGC Handle not found, skipping for: %s"), *ResourceURL);
		return;
	}

	switch (HandlePtr->Kind)
	{
		default:
		UE_LOG(LogBarrelQuest, Warning, TEXT("Unknown UGC Type Passed into User Defined Tile Definition Registry"))
		break;
		
		case ERegisteredAssetType::RuntimeAsset:
		if (ResourceType == TEXT("mesh"))
		{
			Registry->RegisterRuntimeMeshBytesWithHandle(Bytes, *HandlePtr, 100.0f);
			PendingRegistryHandles.Remove(HandlePtr->Url);
		} else if (ResourceType == TEXT("texture"))
		{
			Registry->RegisterRuntimeTextureBytesWithHandle(Bytes, *HandlePtr);
			PendingRegistryHandles.Remove(HandlePtr->Url);
		}
			
		break;
	}
	
	if (PendingRegistryHandles.IsEmpty())
	{
		if (CurrentLoadPendingSave)
		{
			LFS_Stage_LoadTiles(CurrentLoadPendingSave);
		}
		else
		{
			UE_LOG(LogBarrelQuest, Verbose, TEXT("Pending Registry Handles is empty, but not pending save active."));
		}
	}
}

void ATileManagerUGC::HandleUGCDownloadFailed(FString ResourceURL, FString ResourceType, FString Error)
{
	UE_LOG(LogBarrelQuestTileManager, Warning, TEXT("UGC Download Failed: url: %s, resType: %s, err: %s"), *ResourceURL, *ResourceType, *Error);
}

void ATileManagerUGC::HandleUGCDownloadStarted(FString ResourceURL, FString ResourceType)
{
	UE_LOG(LogBarrelQuestTileManager, Warning, TEXT("UGC Download Failed: url: %s, resType: %s"), *ResourceURL, *ResourceType);
}

void ATileManagerUGC::RegisterTileDefinitionUGCItems(const FTileDefinition& TileDefinition)
{
	UTileTextureRegistry* Registry = GetOrCacheTileTextureRegistry();
	if (!Registry)
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("RegisterTileDefinitionUGCItems: TileTextureRegistry was null. TileName='%s'"),
			*TileDefinition.Name);
		return;
	}

	TArray<FTileSavedAssetHandle> HandlesToProcess;
	
	HandlesToProcess.Add(TileDefinition.UserDefinedMesh);
	HandlesToProcess.Add(TileDefinition.TextureProperties.ConstantTexHandles.ConstAlbedo);
	HandlesToProcess.Add(TileDefinition.TextureProperties.ConstantTexHandles.ConstNormal);
	HandlesToProcess.Add(TileDefinition.TextureProperties.ConstantTexHandles.ConstORM);
	
	for (FTileSavedAssetHandle& Handle : HandlesToProcess)
	{
		switch (Handle.Kind)
		{
			case ERegisteredAssetType::None:
			{
				break;
			}
			
			case ERegisteredAssetType::CookedAsset:
			{
					if (!Handle.AssetPath.IsValid())
					{
						UE_LOG(LogBarrelQuestLoad, Error, TEXT("Couldn't find a valid asset"));
						break;
					}
					
					TSoftObjectPtr<UObject> AssetSoftRef = UKismetSystemLibrary::Conv_SoftObjPathToSoftObjRef(Handle.AssetPath);
					UObject* Object = UKismetSystemLibrary::LoadAsset_Blocking(AssetSoftRef);
					
					if (!Object)
					{
						UE_LOG(LogBarrelQuestLoad, Error, TEXT("Loaded Asset was nullptr"));
						break;
					}
					
					if (UTexture2D* Texture = Cast<UTexture2D>(Object))
					{
						Registry->RegisterCookedTextureWithHandle(Texture, Handle);
						break;
					}
					
					if (UStaticMesh* Mesh = Cast<UStaticMesh>(Object))
					{
						Registry->RegisterCookedMeshWithHandle(Mesh, Handle);
						break;
					}
					break;
			}
			
			case ERegisteredAssetType::RuntimeAsset:
			{
				PendingRegistryHandles.Add(Handle.Url, Handle);
				UserResourceComponent->RequestResource(Handle.Id);
				UE_LOG(LogBarrelQuestLoad, Verbose, TEXT("Requesting Runtime asset for id: %s"), *Handle.Id);
				break;
			}
		}
	}
}

void ATileManagerUGC::CreateUserDefinedTile(const FName& ID, const FTileDefinition& Definition)
{
	UE_LOG(LogBarrelQuestTileManager, Display, TEXT("Registering User Defined Tile: %s"), *ID.ToString());
	
	RegisterTileDefinitionUGCItems(Definition);
	UserDefinedTileDefinitions.Add(ID, Definition);
}

void ATileManagerUGC::ClearEverything()
{
	WorldBGMData = FWorldBGMData();
	WorldEnvironmentData = FWorldEnvironmentData();
	WorldName = FString("Unnamed World");
	WorldVersion = 1;
	UserDefinedTileDefinitions.Empty();
	if (UTileTextureRegistry* Registry = GetOrCacheTileTextureRegistry())
	{
		Registry->PurgeRegisteredAssets();
	}
	else
	{
		UE_LOG(LogBarrelQuestTileManager, Warning, TEXT("ClearEverything: TileTextureRegistry was null; skipping registered asset purge."));
	}
	CurrentLoadPendingSave = nullptr;
	UserResourceComponent->ClearResourceCache();
	ResetCurrentState();
	
	UE_LOG(LogBarrelQuestTileManager, Warning, TEXT("Cleared Everything on UGC Tile Manager: %s"), *this->GetName());
}

UTileTextureRegistry* ATileManagerUGC::GetOrCacheTileTextureRegistry()
{
	if (!TileTextureRegistry && GetGameInstance())
	{
		TileTextureRegistry = GetGameInstance()->GetSubsystem<UTileTextureRegistry>();
	}

	return TileTextureRegistry;
}
