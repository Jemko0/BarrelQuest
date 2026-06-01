


#include "MapEditorBase/UserResources/UserResourceComponent.h"

#include "BarrelUtilityLibrary.h"
#include "HTTPModule.h"
#include "Interfaces/IHttpResponse.h"
#include "Kismet/KismetRenderingLibrary.h"
#include "RuntimeImporters/BarrelUGCRuntimeImporter.h"

// Sets default values for this component's properties
UUserResourceComponent::UUserResourceComponent()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;

	// ...
}


void UUserResourceComponent::RequestResource(const FString& ResourceID)
{
	RequestResourceWithCallbacks(ResourceID, FOnResourceDownloadFinishedNative(), FOnResourceDownloadFailedNative());
}

void UUserResourceComponent::RequestResourceWithCallbacks(
	const FString& ResourceID,
	FOnResourceDownloadFinishedNative OnFinished,
	FOnResourceDownloadFailedNative OnFailed)
{
	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> Request = FHttpModule::Get().CreateRequest();
    
	Request->SetURL("https://barrel-api.ratt.ing/userresources/get/" + ResourceID);
	Request->SetVerb("GET");
	Request->OnProcessRequestComplete().BindUObject(
		this,
		&UUserResourceComponent::OnResourceRequestCompleteWithCallbacks,
		OnFinished,
		OnFailed,
		true);
	Request->ProcessRequest();
}

bool UUserResourceComponent::IsDownloading()
{
	return InProgressDownloads.Num() != 0;
}

bool UUserResourceComponent::IsCached(const FString& ResourceURL)
{
	return ResourceCache.Contains(ResourceURL);
}

void UUserResourceComponent::ClearResourceCache()
{
	UE_LOG(LogTemp, Display, TEXT("UUserResourceComponent::ClearResourceCache: Clearing Entries=%d Bytes=%lld InProgress=%d"),
		ResourceCache.Num(),
		GetCachedResourceBytes(),
		InProgressDownloads.Num());
	ResourceCache.Empty();
	InProgressDownloads.Empty();
}

int64 UUserResourceComponent::GetCachedResourceBytes() const
{
	int64 TotalBytes = 0;
	for (const TPair<FString, FCachedResource>& Pair : ResourceCache)
	{
		TotalBytes += Pair.Value.Bytes.Num();
	}
	return TotalBytes;
}

void UUserResourceComponent::OnResourceRequestComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool bSuccess)
{
	OnResourceRequestCompleteWithCallbacks(
		RequestPtr,
		ResponsePtr,
		bSuccess,
		FOnResourceDownloadFinishedNative(),
		FOnResourceDownloadFailedNative(),
		true);
}

void UUserResourceComponent::OnResourceRequestCompleteWithCallbacks(
	FHttpRequestPtr RequestPtr,
	FHttpResponsePtr ResponsePtr,
	bool bSuccess,
	FOnResourceDownloadFinishedNative OnFinished,
	FOnResourceDownloadFailedNative OnFailed,
	bool bBroadcastComponentDelegates)
{
	if (!bSuccess || !ResponsePtr.IsValid() || ResponsePtr->GetResponseCode() != 200)
	{
		const FString Error = ResponsePtr.IsValid() ? ResponsePtr->GetContentAsString() : TEXT("Resource request failed");
		if (bBroadcastComponentDelegates)
		{
			OnDownloadFailed.Broadcast("", "", Error);
		}
		OnFailed.ExecuteIfBound("", "", Error);
		return;
	}

	TSharedPtr<FJsonObject> JsonObject;
	TSharedRef<TJsonReader<>> Reader = TJsonReaderFactory<>::Create(ResponsePtr->GetContentAsString());
	if (!FJsonSerializer::Deserialize(Reader, JsonObject) || !JsonObject.IsValid())
	{
		if (bBroadcastComponentDelegates)
		{
			OnDownloadFailed.Broadcast("", "", TEXT("Failed to parse response"));
		}
		OnFailed.ExecuteIfBound("", "", TEXT("Failed to parse response"));
		return;
	}

	TSharedPtr<FJsonObject> ResourceJson = JsonObject->GetObjectField(TEXT("resource"));
	FString URL = ResourceJson->GetStringField(TEXT("url"));
	FString Type = ResourceJson->GetStringField(TEXT("type"));

	if (ResourceCache.Contains(URL))
	{
		if (bBroadcastComponentDelegates)
		{
			OnDownloadFinished.Broadcast(URL, Type, ResourceCache[URL].Bytes);
		}
		OnFinished.ExecuteIfBound(URL, Type, ResourceCache[URL].Bytes);
		return;
	}

	InProgressDownloads.Add(URL);
	if (bBroadcastComponentDelegates)
	{
		OnDownloadStarted.Broadcast(URL, Type);
	}

	// now fetch the actual file
	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> FileRequest = FHttpModule::Get().CreateRequest();
	FileRequest->SetURL(URL);
	FileRequest->SetVerb("GET");
	FileRequest->OnProcessRequestComplete().BindUObject(
		this,
		&UUserResourceComponent::OnFileDownloadCompleteWithCallbacks,
		URL,
		Type,
		OnFinished,
		OnFailed,
		bBroadcastComponentDelegates);
	FileRequest->ProcessRequest();
}

void UUserResourceComponent::OnFileDownloadComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool bSuccess, FString URL, FString Type)
{
	OnFileDownloadCompleteWithCallbacks(
		RequestPtr,
		ResponsePtr,
		bSuccess,
		URL,
		Type,
		FOnResourceDownloadFinishedNative(),
		FOnResourceDownloadFailedNative(),
		true);
}

void UUserResourceComponent::OnFileDownloadCompleteWithCallbacks(
	FHttpRequestPtr RequestPtr,
	FHttpResponsePtr ResponsePtr,
	bool bSuccess,
	FString URL,
	FString Type,
	FOnResourceDownloadFinishedNative OnFinished,
	FOnResourceDownloadFailedNative OnFailed,
	bool bBroadcastComponentDelegates)
{
	if (!bSuccess || !ResponsePtr.IsValid() || ResponsePtr->GetResponseCode() != 200)
	{
		InProgressDownloads.Remove(URL);
		if (bBroadcastComponentDelegates)
		{
			OnDownloadFailed.Broadcast(URL, Type, TEXT("Failed to download file"));
		}
		OnFailed.ExecuteIfBound(URL, Type, TEXT("Failed to download file"));
		return;
	}

	FCachedResource Cached;
	Cached.Bytes = ResponsePtr->GetContent();
	Cached.Type = Type;
	ResourceCache.Add(URL, Cached);
	InProgressDownloads.Remove(URL);

	if (bBroadcastComponentDelegates)
	{
		OnDownloadFinished.Broadcast(URL, Type, Cached.Bytes);
	}
	OnFinished.ExecuteIfBound(URL, Type, Cached.Bytes);
}

FInterpretedResourceData UUserResourceComponent::InterpretData(UObject* WorldContextObject, FString ResourceURL, FString ResourceType,
	TArray<uint8>& Buffer, bool loopAudio)
{
	UUGCAssetRegistry* UGCAssetRegistry = WorldContextObject->GetWorld()->GetGameInstance()->GetSubsystem<UUGCAssetRegistry>();
	FInterpretedResourceData result = FInterpretedResourceData();
	
	if (!UGCAssetRegistry)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("UGCAssetRegistry was nullptr!"));
		return result;
	}
	
	if (ResourceType == TEXT("texture"))
	{
		UE_LOG(LogBarrelQuest, Display, TEXT("Importing UGC Texture, Buf size: %i"), Buffer.Num());
		result.TexturePtr = UKismetRenderingLibrary::ImportBufferAsTexture2D(WorldContextObject, Buffer);
	}
	else if (ResourceType == TEXT("mesh"))
	{
		UE_LOG(LogBarrelQuest, Display, TEXT("Importing UGC Mesh, Buf size: %i"), Buffer.Num());
		result.MeshPtr = UGCAssetRegistry->GetOrLoadMesh(Buffer, ResourceURL, 100.0f);
	}
	else if (ResourceType == TEXT("audio"))
	{
		UE_LOG(LogBarrelQuest, Display, TEXT("Importing UGC Audio, Buf size: %i"), Buffer.Num());
		result.AudioPtr = UGCAssetRegistry->GetOrLoadSound(Buffer, ResourceURL, EUGCAudioFormat::Auto, loopAudio);
	}
	else if (ResourceType == TEXT("mid"))
	{
		UE_LOG(LogBarrelQuest, Display, TEXT("Importing UGC Midi File, Buf size: %i"), Buffer.Num());
		result.RawBytes = Buffer;
		result.IsMIDIBytes = true;
	}
	else
	{
		UE_LOG(LogBarrelQuest, Display, TEXT("Importing UGC Unknown Type File, Buf size: %i"), Buffer.Num());
		result.RawBytes = Buffer;
		result.IsMIDIBytes = false;
	}
	
	return result;
}

// Called when the game starts
void UUserResourceComponent::BeginPlay()
{
	Super::BeginPlay();

	// ...
	
}


// Called every frame
void UUserResourceComponent::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);

	// ...
}

URequestResourceAsyncAction* URequestResourceAsyncAction::RequestResource_Async(
	UUserResourceComponent* ResourceComponent,
	const FString& ResourceID)
{
	URequestResourceAsyncAction* Action = NewObject<URequestResourceAsyncAction>();
	Action->ResourceComponent = ResourceComponent;
	Action->ResourceID = ResourceID;

	if (ResourceComponent)
	{
		Action->RegisterWithGameInstance(ResourceComponent);
	}

	return Action;
}

void URequestResourceAsyncAction::Activate()
{
	if (!ResourceComponent)
	{
		HandleFailure("", "", TEXT("Invalid user resource component"));
		return;
	}

	ResourceComponent->RequestResourceWithCallbacks(
		ResourceID,
		FOnResourceDownloadFinishedNative::CreateUObject(this, &URequestResourceAsyncAction::HandleSuccess),
		FOnResourceDownloadFailedNative::CreateUObject(this, &URequestResourceAsyncAction::HandleFailure));
}

void URequestResourceAsyncAction::HandleSuccess(
	const FString& ResourceURL,
	const FString& ResourceType,
	const TArray<uint8>& Bytes)
{
	OnSuccess.Broadcast(ResourceURL, ResourceType, Bytes);
	SetReadyToDestroy();
}

void URequestResourceAsyncAction::HandleFailure(
	const FString& ResourceURL,
	const FString& ResourceType,
	const FString& Error)
{
	OnFailure.Broadcast(ResourceURL, ResourceType, Error);
	SetReadyToDestroy();
}

