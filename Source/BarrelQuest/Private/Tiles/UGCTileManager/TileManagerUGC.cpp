// 


#include "Tiles/UGCTileManager/TileManagerUGC.h"
#include "Tiles/TileChunk.h"
#include "BarrelUtilityLibrary.h"
#include "HTTPModule.h"
#include "Interfaces/IHttpResponse.h"
#include "Json.h"
#include "Kismet/GameplayStatics.h"
#include "Kismet/KismetSystemLibrary.h"
#include "MapEditorBase/MapEditorControllerBase.h"
#include "MapEditorBase/UserResources/UserResourceLibrary.h"
#include "Misc/Compression.h"
#include "Misc/FileHelper.h"
#include "Misc/Paths.h"
#include "Tiles/SavingLoading/MapEditorWorldSaveGame.h"
#include "Tiles/UGCTileManager/UGCApplierComponent.h"

namespace
{
FString NormalizeHttpURLForRequest(const FString& URL)
{
	FString NormalizedURL = URL;
	NormalizedURL.ReplaceInline(TEXT(" "), TEXT("%20"), ESearchCase::CaseSensitive);
	return NormalizedURL;
}

bool IsGzipData(const TArray<uint8>& Bytes)
{
	return Bytes.Num() >= 18 && Bytes[0] == 0x1f && Bytes[1] == 0x8b;
}

uint32 ReadGzipUncompressedSize(const TArray<uint8>& Bytes)
{
	const int32 SizeOffset = Bytes.Num() - 4;
	return static_cast<uint32>(Bytes[SizeOffset])
		| (static_cast<uint32>(Bytes[SizeOffset + 1]) << 8)
		| (static_cast<uint32>(Bytes[SizeOffset + 2]) << 16)
		| (static_cast<uint32>(Bytes[SizeOffset + 3]) << 24);
}

bool TryDecompressGzipSave(const TArray<uint8>& CompressedBytes, TArray<uint8>& OutBytes)
{
	if (!IsGzipData(CompressedBytes))
	{
		OutBytes = CompressedBytes;
		return true;
	}

	const uint32 UncompressedSize = ReadGzipUncompressedSize(CompressedBytes);
	if (UncompressedSize == 0 || UncompressedSize > static_cast<uint32>(MAX_int32))
	{
		return false;
	}

	OutBytes.SetNumUninitialized(static_cast<int32>(UncompressedSize));
	if (!FCompression::UncompressMemory(
		NAME_Gzip,
		OutBytes.GetData(),
		OutBytes.Num(),
		CompressedBytes.GetData(),
		CompressedBytes.Num()))
	{
		OutBytes.Reset();
		return false;
	}

	return true;
}

FString TruncateForLog(const FString& Value, int32 MaxChars = 1200)
{
	if (Value.Len() <= MaxChars)
	{
		return Value;
	}

	return Value.Left(MaxChars) + TEXT("... [truncated]");
}

FString GetRequestURLForLog(const FHttpRequestPtr& RequestPtr)
{
	return RequestPtr.IsValid() ? RequestPtr->GetURL() : TEXT("<no request>");
}

FString GetResponseSummaryForLog(const FHttpResponsePtr& ResponsePtr)
{
	if (!ResponsePtr.IsValid())
	{
		return TEXT("Response=<invalid>");
	}

	return FString::Printf(
		TEXT("Code=%d Bytes=%d"),
		ResponsePtr->GetResponseCode(),
		ResponsePtr->GetContent().Num());
}

void CountSaveGameContents(const UMapEditorWorldSaveGame* SaveGame, int32& OutChunks, int32& OutSquares, int32& OutObjects)
{
	OutChunks = 0;
	OutSquares = 0;
	OutObjects = 0;

	if (!SaveGame)
	{
		return;
	}

	OutChunks = SaveGame->WorldChunks.Num();
	for (const TPair<FIntVector2, FSavedChunk>& ChunkPair : SaveGame->WorldChunks)
	{
		OutSquares += ChunkPair.Value.ChunkSquares.Num();
		for (const FSquareTile& Square : ChunkPair.Value.ChunkSquares)
		{
			OutObjects += Square.GetReadOnlyObjects().Num();
		}
	}
}

FString DescribeSaveGameForLog(const UMapEditorWorldSaveGame* SaveGame)
{
	if (!SaveGame)
	{
		return TEXT("<null save game>");
	}

	int32 ChunkCount = 0;
	int32 SquareCount = 0;
	int32 ObjectCount = 0;
	CountSaveGameContents(SaveGame, ChunkCount, SquareCount, ObjectCount);

	return FString::Printf(
		TEXT("Name='%s' Version=%d Chunks=%d Squares=%d Objects=%d UserTiles=%d Rooms=%d TransitionTargets=%d"),
		*SaveGame->WorldName,
		SaveGame->Version,
		ChunkCount,
		SquareCount,
		ObjectCount,
		SaveGame->UserDefinedTiles.Num(),
		SaveGame->RoomIDToTiles.Num(),
		SaveGame->AvailableTransitionTargetNames.Num());
}

FString DescribeMetadataForLog(const FDreamWorldMetadata& Metadata)
{
	return FString::Printf(
		TEXT("ID=%lld Name='%s' Author='%s' MapFileURL='%s' Connections=%d TransitionTargets=%d"),
		Metadata.ID,
		*Metadata.Name,
		*Metadata.Author,
		*Metadata.MapFileURL,
		Metadata.Connections.Num(),
		Metadata.AvailableTransitionTargetNames.Num());
}
}

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
	if (!bIsLoadingWorldFromAPI)
	{
		WorldLoadStartTime = FDateTime::Now();
	}

	if (!SaveGame)
	{
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("LoadFromSave failed: SaveGame was null."));
		ExitWorldLoading(false, TEXT("Save game was null"));
		return;
	}

	ClearEverything();
	
	UE_LOG(LogBarrelQuestLoad, Display, TEXT("Starting world load from save. %s"), *DescribeSaveGameForLog(SaveGame));
	
	LFS_Stage_LoadDefaults(SaveGame);
}

void ATileManagerUGC::LFS_Stage_LoadDefaults(UMapEditorWorldSaveGame* SaveGame)
{
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Entering Load Stage: LoadDefaults"));

	if (!SaveGame)
	{
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("LoadDefaults failed: SaveGame was null."));
		ExitWorldLoading(false, TEXT("Save game was null in LoadDefaults"));
		return;
	}
	
	WorldName = SaveGame->WorldName;
	WorldVersion = SaveGame->Version;
	
	UserDefinedTileDefinitions = SaveGame->UserDefinedTiles;
	
	WorldBGMData = SaveGame->BGMData;
	WorldEnvironmentData = SaveGame->EnvironmentData;
	AvailableTransitionTargetNames = SaveGame->AvailableTransitionTargetNames;
	WorldOutgoingConnections = SaveGame->OutgoingConnections;

	UE_LOG(
		LogBarrelQuestLoad,
		Display,
		TEXT("Loaded save defaults. WorldName='%s' Version=%d UserTiles=%d TransitionTargets=%d HasBGM=%s"),
		*WorldName,
		WorldVersion,
		UserDefinedTileDefinitions.Num(),
		AvailableTransitionTargetNames.Num(),
		(!WorldBGMData.AudioResource.ResourcePath.IsEmpty() || WorldBGMData.AudioResource.AssetSoftObject.IsValid()) ? TEXT("true") : TEXT("false"));
	
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

	if (!SaveGame)
	{
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("LoadUGC failed: SaveGame was null."));
		ExitWorldLoading(false, TEXT("Save game was null in LoadUGC"));
		return;
	}
	
	TArray<FTileDefinition> UserDefDefs;
	UserDefinedTileDefinitions.GenerateValueArray(UserDefDefs);
	
	CurrentLoadPendingSave = SaveGame;
	bIsRegisteringLoadUGC = true;

	UE_LOG(LogBarrelQuestLoad, Display, TEXT("Loading UGC dependencies for save. UserTiles=%d"), UserDefDefs.Num());
	
	for (FTileDefinition& def : UserDefDefs)
	{
		RegisterTileDefinitionUGCItems(def);
		
		UE_LOG(LogBarrelQuestLoad, Verbose, TEXT("Registering Tile Def UGC Items for: %s"), *def.Name);
	}

	UE_LOG(LogBarrelQuestLoad, Display, TEXT("UGC dependency registration finished. PendingRuntimeResources=%d"), PendingRegistryHandles.Num());
	bIsRegisteringLoadUGC = false;
	TryContinueLoadAfterUGC(TEXT("UGC dependency registration finished"));
	
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Exiting Load Stage: LoadUGC"));
}

void ATileManagerUGC::LFS_Stage_LoadTiles(UMapEditorWorldSaveGame* SaveGame)
{
	UE_LOG(LogBarrelQuestLoad, Log, TEXT("Entering Load Stage: LoadTiles"));

	if (!SaveGame)
	{
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("LoadTiles failed: SaveGame was null."));
		ExitWorldLoading(false, TEXT("Save game was null in LoadTiles"));
		return;
	}

	int32 ExpectedChunks = 0;
	int32 ExpectedSquares = 0;
	int32 ExpectedObjects = 0;
	CountSaveGameContents(SaveGame, ExpectedChunks, ExpectedSquares, ExpectedObjects);
	UE_LOG(
		LogBarrelQuestLoad,
		Display,
		TEXT("Applying saved tiles. Chunks=%d Squares=%d Objects=%d Rooms=%d"),
		ExpectedChunks,
		ExpectedSquares,
		ExpectedObjects,
		SaveGame->RoomIDToTiles.Num());
	
	for (TPair<FIntVector2, FSavedChunk>& pair : SaveGame->WorldChunks)
	{
		if (pair.Value.SquarePositions.Num() != pair.Value.ChunkSquares.Num())
		{
			UE_LOG(
				LogBarrelQuestLoad,
				Warning,
				TEXT("Saved chunk has mismatched square data. Chunk=(%d,%d) Positions=%d Squares=%d"),
				pair.Key.X,
				pair.Key.Y,
				pair.Value.SquarePositions.Num(),
				pair.Value.ChunkSquares.Num());
		}

		ATileChunk* ChunkPtr = SpawnChunk(pair.Key);
		if (!ChunkPtr)
		{
			const FString Error = FString::Printf(TEXT("Could not spawn chunk at (%d,%d) while loading save"), pair.Key.X, pair.Key.Y);
			UE_LOG(LogBarrelQuestLoad, Error, TEXT("LoadTiles failed: %s"), *Error);
			ExitWorldLoading(false, Error);
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
		if (MEPawn)
		{
			MEPawn->SetActorLocation(SaveGame->MapEditorData.PawnLocation);
			MapEditorController->SetControlRotation(SaveGame->MapEditorData.CameraRotation);
			MapEditorController->SelectedTileID = SaveGame->MapEditorData.SelectedTileID;
		}
		else
		{
			UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Map Editor Controller had no pawn assigned; skipping saved editor camera restore."));
		}
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
	bIsRegisteringLoadUGC = false;
	bIsLoadingWorldFromAPI = false;
	
	FTimespan LoadingTime = WorldLoadEndTime - WorldLoadStartTime;
	
	if (success)
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Display,
			TEXT("World loading finished successfully. Duration=%.3fs WorldID=%d WorldName='%s' Message='%s'"),
			LoadingTime.GetTotalSeconds(),
			CurrentWorldID,
			*WorldName,
			*msg);
	}
	else
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Error,
			TEXT("World loading failed. Duration=%.3fs WorldID=%d WorldName='%s' Error='%s'"),
			LoadingTime.GetTotalSeconds(),
			CurrentWorldID,
			*WorldName,
			*msg);
	}

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
	
	FString PendingHandleKey = ResourceURL;
	FTileSavedAssetHandle* HandlePtr = PendingRegistryHandles.Find(PendingHandleKey);
	if (!HandlePtr)
	{
		for (TPair<FString, FTileSavedAssetHandle>& PendingPair : PendingRegistryHandles)
		{
			if (PendingPair.Value.Url == ResourceURL || NormalizeHttpURLForRequest(PendingPair.Value.Url) == ResourceURL)
			{
				PendingHandleKey = PendingPair.Key;
				HandlePtr = &PendingPair.Value;
				break;
			}
		}
	}
	
	if (!HandlePtr)
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Warning,
			TEXT("UGC Handle not found for completed download. URL=%s Type=%s Pending=%s"),
			*ResourceURL,
			*ResourceType,
			*DescribePendingRegistryHandlesForLog());
		return;
	}

	const FTileSavedAssetHandle Handle = *HandlePtr;

	switch (Handle.Kind)
	{
		default:
		UE_LOG(LogBarrelQuest, Warning, TEXT("Unknown UGC Type Passed into User Defined Tile Definition Registry"));
		break;
		
		case ERegisteredAssetType::RuntimeAsset:
		if (ResourceType == TEXT("mesh"))
		{
			Registry->RegisterRuntimeMeshBytesWithHandle(Bytes, Handle, 100.0f);
			PendingRegistryHandles.Remove(PendingHandleKey);
		} else if (ResourceType == TEXT("texture"))
		{
			Registry->RegisterRuntimeTextureBytesWithHandle(Bytes, Handle);
			PendingRegistryHandles.Remove(PendingHandleKey);
		}
		else
		{
			UE_LOG(
				LogBarrelQuestLoad,
				Warning,
				TEXT("UGC download finished with unsupported resource type. URL=%s Type=%s HandleID=%s"),
				*ResourceURL,
				*ResourceType,
				*Handle.Id);
			PendingRegistryHandles.Remove(PendingHandleKey);
		}

		break;
	}

	UE_LOG(
		LogBarrelQuestLoad,
		Display,
		TEXT("UGC runtime resource finished. URL=%s Type=%s RemainingPending=%d"),
		*ResourceURL,
		*ResourceType,
		PendingRegistryHandles.Num());
	TryContinueLoadAfterUGC(TEXT("UGC runtime resource finished"));
}

void ATileManagerUGC::HandleUGCDownloadFailed(FString ResourceURL, FString ResourceType, FString Error)
{
	if (!CurrentLoadPendingSave)
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Warning,
			TEXT("UGC download failed outside active save load. URL=%s Type=%s Error=%s"),
			*ResourceURL,
			*ResourceType,
			*Error);
		return;
	}

	bool bFailureMatchesPendingHandle = PendingRegistryHandles.Contains(ResourceURL);
	if (!bFailureMatchesPendingHandle)
	{
		for (const TPair<FString, FTileSavedAssetHandle>& PendingPair : PendingRegistryHandles)
		{
			if (PendingPair.Value.Url == ResourceURL || NormalizeHttpURLForRequest(PendingPair.Value.Url) == ResourceURL)
			{
				bFailureMatchesPendingHandle = true;
				break;
			}
		}
	}

	if (!bFailureMatchesPendingHandle)
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Warning,
			TEXT("Ignoring UGC download failure that does not match pending save-load handles. URL=%s Type=%s Error=%s Pending=%s"),
			*ResourceURL,
			*ResourceType,
			*Error,
			*DescribePendingRegistryHandlesForLog());
		return;
	}

	UE_LOG(
		LogBarrelQuestLoad,
		Error,
		TEXT("UGC download failed while loading save. URL=%s Type=%s Error=%s Pending=%s"),
		*ResourceURL,
		*ResourceType,
		*Error,
		*DescribePendingRegistryHandlesForLog());

	ExitWorldLoading(false, FString::Printf(TEXT("UGC download failed: %s"), *Error));
}

void ATileManagerUGC::HandleUGCDownloadStarted(FString ResourceURL, FString ResourceType)
{
	UE_LOG(LogBarrelQuestLoad, Display, TEXT("UGC download started. URL=%s Type=%s"), *ResourceURL, *ResourceType);
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
	AvailableTransitionTargetNames.Empty();
	WorldOutgoingConnections.Empty();

	if (UTileTextureRegistry* Registry = GetOrCacheTileTextureRegistry())
	{
		Registry->PurgeRegisteredAssets();
	}
	else
	{
		UE_LOG(LogBarrelQuestTileManager, Warning, TEXT("ClearEverything: TileTextureRegistry was null; skipping registered asset purge."));
	}
	CurrentLoadPendingSave = nullptr;
	bIsRegisteringLoadUGC = false;
	bIsLoadingWorldFromAPI = false;
	PendingRegistryHandles.Empty();
	UserResourceComponent->ClearResourceCache();
	ResetCurrentState();

	UUGCApplierComponent* ugc = Cast<UUGCApplierComponent>(GetComponentByClass(TSubclassOf<UUGCApplierComponent>(UUGCApplierComponent::StaticClass())));

	if (ugc)
	{
		ugc->ApplyEnvironmentSettings(WorldEnvironmentData);
		ugc->ApplyBGM(WorldBGMData);
	}

	UE_LOG(LogBarrelQuestTileManager, Warning, TEXT("Cleared Everything on UGC Tile Manager: %s"), *this->GetName());
}

bool ATileManagerUGC::TryContinueLoadAfterUGC(const FString& Reason)
{
	if (!CurrentLoadPendingSave)
	{
		UE_LOG(LogBarrelQuestLoad, Verbose, TEXT("UGC load continuation skipped: no pending save. Reason=%s"), *Reason);
		return false;
	}

	if (bIsRegisteringLoadUGC)
	{
		UE_LOG(LogBarrelQuestLoad, Verbose, TEXT("UGC load continuation deferred: registration still active. Reason=%s Pending=%d"), *Reason, PendingRegistryHandles.Num());
		return false;
	}

	if (!PendingRegistryHandles.IsEmpty())
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Display,
			TEXT("UGC load continuation waiting. Reason=%s Pending=%s"),
			*Reason,
			*DescribePendingRegistryHandlesForLog());
		return false;
	}

	UMapEditorWorldSaveGame* SaveGameToLoad = CurrentLoadPendingSave;
	CurrentLoadPendingSave = nullptr;

	UE_LOG(LogBarrelQuestLoad, Display, TEXT("UGC load continuation triggered. Reason=%s"), *Reason);
	LFS_Stage_LoadTiles(SaveGameToLoad);
	return true;
}

FString ATileManagerUGC::DescribePendingRegistryHandlesForLog() const
{
	if (PendingRegistryHandles.IsEmpty())
	{
		return TEXT("<none>");
	}

	TArray<FString> Parts;
	Parts.Reserve(PendingRegistryHandles.Num());
	for (const TPair<FString, FTileSavedAssetHandle>& PendingPair : PendingRegistryHandles)
	{
		Parts.Add(FString::Printf(
			TEXT("{Key='%s' Id='%s' Url='%s' Kind=%d}"),
			*PendingPair.Key,
			*PendingPair.Value.Id,
			*PendingPair.Value.Url,
			static_cast<int32>(PendingPair.Value.Kind)));
	}

	return FString::Join(Parts, TEXT(", "));
}

void ATileManagerUGC::LoadWorldFromAPI(int32 ID)
{
	WorldLoadStartTime = FDateTime::Now();
	bIsLoadingWorldFromAPI = true;

	if (ID <= 0)
	{
		const FString Error = FString::Printf(TEXT("Invalid world ID '%d'"), ID);
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("LoadWorldFromAPI failed before request: %s"), *Error);
		ExitWorldLoading(false, Error);
		return;
	}

	CurrentWorldID = ID;

	const FString URL = BarrelAPIURL + TEXT("dreamworlds/get/") + FString::FromInt(ID);
	UE_LOG(LogBarrelQuestLoad, Display, TEXT("Requesting dream world metadata: %s"), *URL);

	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> Request = FHttpModule::Get().CreateRequest();
	Request->SetURL(URL);
	Request->SetVerb(TEXT("GET"));
	Request->OnProcessRequestComplete().BindUObject(this, &ATileManagerUGC::HandleWorldMetadataRequestComplete, ID);
	Request->ProcessRequest();
}

UTileTextureRegistry* ATileManagerUGC::GetOrCacheTileTextureRegistry()
{
	if (!TileTextureRegistry && GetGameInstance())
	{
		TileTextureRegistry = GetGameInstance()->GetSubsystem<UTileTextureRegistry>();
	}

	return TileTextureRegistry;
}

void ATileManagerUGC::HandleWorldMetadataRequestComplete(
	FHttpRequestPtr RequestPtr,
	FHttpResponsePtr ResponsePtr,
	bool bSuccess,
	int32 RequestedWorldID)
{
	if (!bSuccess || !ResponsePtr.IsValid() || ResponsePtr->GetResponseCode() < 200 || ResponsePtr->GetResponseCode() >= 300)
	{
		const FString ResponseBody = ResponsePtr.IsValid() ? ResponsePtr->GetContentAsString() : TEXT("");
		const FString Error = ResponseBody.IsEmpty() ? TEXT("World metadata request failed") : TruncateForLog(ResponseBody);
		UE_LOG(
			LogBarrelQuestLoad,
			Error,
			TEXT("Dream world metadata request failed. WorldID=%d Success=%s URL=%s %s Body=%s"),
			RequestedWorldID,
			bSuccess ? TEXT("true") : TEXT("false"),
			*GetRequestURLForLog(RequestPtr),
			*GetResponseSummaryForLog(ResponsePtr),
			*Error);
		ExitWorldLoading(false, Error);
		return;
	}

	FDreamWorldMetadata Metadata;
	FString ParseError;
	if (!ParseDreamWorldMetadata(ResponsePtr->GetContentAsString(), Metadata, ParseError))
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Error,
			TEXT("Failed to parse dream world metadata. WorldID=%d URL=%s %s Error=%s Body=%s"),
			RequestedWorldID,
			*GetRequestURLForLog(RequestPtr),
			*GetResponseSummaryForLog(ResponsePtr),
			*ParseError,
			*TruncateForLog(ResponsePtr->GetContentAsString()));
		ExitWorldLoading(false, ParseError);
		return;
	}

	if (Metadata.MapFileURL.IsEmpty())
	{
		const FString Error = TEXT("Dream world metadata did not include map_file_url");
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("%s. WorldID=%d Metadata=%s"), *Error, RequestedWorldID, *DescribeMetadataForLog(Metadata));
		ExitWorldLoading(false, Error);
		return;
	}

	CurrentDreamWorldMetadata = Metadata;
	CurrentWorldID = static_cast<int32>(Metadata.ID);
	CurrentDreamWorldMetadata.LocalSavePath = GetDownloadedWorldSavePath(RequestedWorldID);
	UE_LOG(LogBarrelQuestLoad, Display, TEXT("Parsed dream world metadata. RequestedWorldID=%d %s"), RequestedWorldID, *DescribeMetadataForLog(Metadata));

	const FString DownloadURL = NormalizeHttpURLForRequest(Metadata.MapFileURL);
	if (DownloadURL != Metadata.MapFileURL)
	{
		UE_LOG(LogBarrelQuestLoad, Display, TEXT("Encoded dream world save URL for HTTP request. Original=%s Encoded=%s"), *Metadata.MapFileURL, *DownloadURL);
	}
	UE_LOG(LogBarrelQuestLoad, Display, TEXT("Downloading dream world save. WorldID=%lld URL=%s"), Metadata.ID, *DownloadURL);

	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> FileRequest = FHttpModule::Get().CreateRequest();
	FileRequest->SetURL(DownloadURL);
	FileRequest->SetVerb(TEXT("GET"));
	FileRequest->OnProcessRequestComplete().BindUObject(
		this,
		&ATileManagerUGC::HandleWorldSaveDownloadComplete,
		RequestedWorldID,
		DownloadURL);
	FileRequest->ProcessRequest();
}

void ATileManagerUGC::HandleWorldSaveDownloadComplete(
	FHttpRequestPtr RequestPtr,
	FHttpResponsePtr ResponsePtr,
	bool bSuccess,
	int32 RequestedWorldID,
	FString MapFileURL)
{
	if (!bSuccess || !ResponsePtr.IsValid() || ResponsePtr->GetResponseCode() < 200 || ResponsePtr->GetResponseCode() >= 300)
	{
		const FString ResponseBody = ResponsePtr.IsValid() ? ResponsePtr->GetContentAsString() : TEXT("");
		const FString Error = ResponseBody.IsEmpty() ? TEXT("World save download failed") : TruncateForLog(ResponseBody);
		UE_LOG(
			LogBarrelQuestLoad,
			Error,
			TEXT("Dream world save download failed. WorldID=%d Success=%s URL=%s RequestURL=%s %s Body=%s"),
			RequestedWorldID,
			bSuccess ? TEXT("true") : TEXT("false"),
			*MapFileURL,
			*GetRequestURLForLog(RequestPtr),
			*GetResponseSummaryForLog(ResponsePtr),
			*Error);
		ExitWorldLoading(false, Error);
		return;
	}

	const TArray<uint8>& DownloadedBytes = ResponsePtr->GetContent();
	if (DownloadedBytes.IsEmpty())
	{
		const FString Error = TEXT("Downloaded world save was empty");
		UE_LOG(LogBarrelQuestLoad, Error, TEXT("%s. WorldID=%d URL=%s %s"), *Error, RequestedWorldID, *MapFileURL, *GetResponseSummaryForLog(ResponsePtr));
		ExitWorldLoading(false, Error);
		return;
	}

	TArray<uint8> SaveBytes;
	if (!TryDecompressGzipSave(DownloadedBytes, SaveBytes))
	{
		UE_LOG(
			LogBarrelQuestLoad,
			Error,
			TEXT("Downloaded dream world save was gzip data but could not be decompressed. WorldID=%d URL=%s CompressedBytes=%d"),
			RequestedWorldID,
			*MapFileURL,
			DownloadedBytes.Num());
		ExitWorldLoading(false, TEXT("Downloaded world save could not be decompressed"));
		return;
	}

	if (SaveBytes.Num() != DownloadedBytes.Num())
	{
		UE_LOG(LogBarrelQuestLoad, Display, TEXT("Decompressed dream world save. CompressedBytes=%d UncompressedBytes=%d"), DownloadedBytes.Num(), SaveBytes.Num());
	}

	const FString SavePath = GetDownloadedWorldSavePath(RequestedWorldID);
	IFileManager::Get().MakeDirectory(*FPaths::GetPath(SavePath), true);
	if (!FFileHelper::SaveArrayToFile(SaveBytes, *SavePath))
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Downloaded dream world save could not be written locally: %s"), *SavePath);
	}
	else
	{
		UE_LOG(LogBarrelQuestLoad, Display, TEXT("Downloaded dream world save written to: %s"), *SavePath);
	}

	USaveGame* LoadedSaveGame = UGameplayStatics::LoadGameFromMemory(SaveBytes);
	UMapEditorWorldSaveGame* WorldSaveGame = Cast<UMapEditorWorldSaveGame>(LoadedSaveGame);
	if (!WorldSaveGame)
	{
		const FString LoadedClassName = LoadedSaveGame ? LoadedSaveGame->GetClass()->GetName() : TEXT("<null>");
		UE_LOG(
			LogBarrelQuestLoad,
			Error,
			TEXT("Downloaded file was not a MapEditorWorldSaveGame. WorldID=%d URL=%s LocalPath=%s SaveBytes=%d LoadedClass=%s"),
			RequestedWorldID,
			*MapFileURL,
			*SavePath,
			SaveBytes.Num(),
			*LoadedClassName);
		ExitWorldLoading(false, TEXT("Downloaded file was not a MapEditorWorldSaveGame"));
		return;
	}

	UE_LOG(LogBarrelQuestLoad, Display, TEXT("Downloaded world save loaded from memory. WorldID=%d %s"), RequestedWorldID, *DescribeSaveGameForLog(WorldSaveGame));

	LoadFromSave(WorldSaveGame);
}

bool ATileManagerUGC::ParseDreamWorldMetadata(const FString& ResponseBody, FDreamWorldMetadata& OutMetadata, FString& OutError) const
{
	TSharedPtr<FJsonObject> JsonObject;
	TSharedRef<TJsonReader<>> Reader = TJsonReaderFactory<>::Create(ResponseBody);
	if (!FJsonSerializer::Deserialize(Reader, JsonObject) || !JsonObject.IsValid())
	{
		OutError = TEXT("Failed to parse world metadata response");
		return false;
	}

	TSharedPtr<FJsonObject> WorldJson = JsonObject;
	if (JsonObject->HasTypedField<EJson::Object>(TEXT("world")))
	{
		WorldJson = JsonObject->GetObjectField(TEXT("world"));
	}

	if (!WorldJson.IsValid())
	{
		OutError = TEXT("World metadata response did not contain a valid world object");
		return false;
	}

	OutMetadata = FDreamWorldMetadata();
	WorldJson->TryGetNumberField(TEXT("id"), OutMetadata.ID);
	WorldJson->TryGetStringField(TEXT("name"), OutMetadata.Name);
	WorldJson->TryGetStringField(TEXT("author"), OutMetadata.Author);
	WorldJson->TryGetStringField(TEXT("map_file_url"), OutMetadata.MapFileURL);
	TryParseDateTimeField(WorldJson, TEXT("created_at"), OutMetadata.CreatedAt);
	TryParseDateTimeField(WorldJson, TEXT("updated_at"), OutMetadata.LastUpdatedAt);

	const TArray<TSharedPtr<FJsonValue>>* AvailableTargetsJson = nullptr;
	if (WorldJson->TryGetArrayField(TEXT("available_transition_target_names"), AvailableTargetsJson) && AvailableTargetsJson)
	{
		int32 TargetIndex = 0;
		for (const TSharedPtr<FJsonValue>& TargetValue : *AvailableTargetsJson)
		{
			if (!TargetValue.IsValid() || TargetValue->Type != EJson::String)
			{
				UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Skipping invalid available_transition_target_names entry at index %d; expected string."), TargetIndex);
				++TargetIndex;
				continue;
			}

			OutMetadata.AvailableTransitionTargetNames.Add(TargetValue->AsString());
			++TargetIndex;
		}
	}
	else if (WorldJson->HasField(TEXT("available_transition_target_names")))
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Metadata field available_transition_target_names exists but is not a JSON array."));
	}

	const TArray<TSharedPtr<FJsonValue>>* ConnectionsJson = nullptr;
	if (WorldJson->TryGetArrayField(TEXT("connections"), ConnectionsJson) && ConnectionsJson)
	{
		int32 ConnectionIndex = 0;
		for (const TSharedPtr<FJsonValue>& ConnectionValue : *ConnectionsJson)
		{
			const TSharedPtr<FJsonObject> ConnectionJson = ConnectionValue.IsValid() ? ConnectionValue->AsObject() : nullptr;
			if (!ConnectionJson.IsValid())
			{
				UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Skipping invalid connections entry at index %d; expected object."), ConnectionIndex);
				++ConnectionIndex;
				continue;
			}

			FDreamWorldConnection Connection;
			ConnectionJson->TryGetNumberField(TEXT("id"), Connection.ConnectionID);
			ConnectionJson->TryGetNumberField(TEXT("from_world_id"), Connection.FromWorldID);
			ConnectionJson->TryGetNumberField(TEXT("to_world_id"), Connection.ToWorldID);
			ConnectionJson->TryGetStringField(TEXT("transition_target_name"), Connection.TransitionTargetName);
			TryParseDateTimeField(ConnectionJson, TEXT("created_at"), Connection.CreatedAt);
			OutMetadata.Connections.Add(Connection);
			++ConnectionIndex;
		}
	}
	else if (WorldJson->HasField(TEXT("connections")))
	{
		UE_LOG(LogBarrelQuestLoad, Warning, TEXT("Metadata field connections exists but is not a JSON array."));
	}

	return true;
}

bool ATileManagerUGC::TryParseDateTimeField(const TSharedPtr<FJsonObject>& JsonObject, const FString& FieldName, FDateTime& OutDateTime) const
{
	if (!JsonObject.IsValid())
	{
		return false;
	}

	FString DateTimeString;
	if (!JsonObject->TryGetStringField(FieldName, DateTimeString))
	{
		return false;
	}

	return FDateTime::ParseIso8601(*DateTimeString, OutDateTime);
}

FString ATileManagerUGC::GetDownloadedWorldSavePath(int32 WorldID) const
{
	return FPaths::ProjectSavedDir() / TEXT("SaveGames") / TEXT("DownloadedWorlds") / FString::Printf(TEXT("World_%d.sav"), WorldID);
}
