


#include "MapEditorBase/UserResources/UserResourceComponent.h"
#include "HTTPModule.h"
#include "Interfaces/IHttpResponse.h"

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
	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> Request = FHttpModule::Get().CreateRequest();
    
	Request->SetURL("https://barrel-api.ratt.ing/userresources/get/" + ResourceID);
	Request->SetVerb("GET");
	Request->OnProcessRequestComplete().BindUObject(this, &UUserResourceComponent::OnResourceRequestComplete);
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

void UUserResourceComponent::OnResourceRequestComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool bSuccess)
{
	if (!bSuccess || !ResponsePtr.IsValid() || ResponsePtr->GetResponseCode() != 200)
	{
		OnDownloadFailed.Broadcast("", "", ResponsePtr->GetContentAsString());
		return;
	}

	TSharedPtr<FJsonObject> JsonObject;
	TSharedRef<TJsonReader<>> Reader = TJsonReaderFactory<>::Create(ResponsePtr->GetContentAsString());
	if (!FJsonSerializer::Deserialize(Reader, JsonObject) || !JsonObject.IsValid())
	{
		OnDownloadFailed.Broadcast("", "", "Failed to parse response");
		return;
	}

	TSharedPtr<FJsonObject> ResourceJson = JsonObject->GetObjectField("resource");
	FString URL = ResourceJson->GetStringField("url");
	FString Type = ResourceJson->GetStringField("type");
	FString Name = ResourceJson->GetStringField("name");

	if (ResourceCache.Contains(URL))
	{
		OnDownloadFinished.Broadcast(URL, Type, ResourceCache[URL].Bytes);
		return;
	}

	InProgressDownloads.Add(URL);
	OnDownloadStarted.Broadcast(URL, Type);

	// now fetch the actual file
	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> FileRequest = FHttpModule::Get().CreateRequest();
	FileRequest->SetURL(URL);
	FileRequest->SetVerb("GET");
	FileRequest->OnProcessRequestComplete().BindUObject(this, &UUserResourceComponent::OnFileDownloadComplete, URL, Type);
	FileRequest->ProcessRequest();
}

void UUserResourceComponent::OnFileDownloadComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool bSuccess, FString URL, FString Type)
{
	if (!bSuccess || !ResponsePtr.IsValid() || ResponsePtr->GetResponseCode() != 200)
	{
		InProgressDownloads.Remove(URL);
		OnDownloadFailed.Broadcast(URL, Type, "Failed to download file");
		return;
	}

	FCachedResource Cached;
	Cached.Bytes = ResponsePtr->GetContent();
	Cached.Type = Type;
	ResourceCache.Add(URL, Cached);
	InProgressDownloads.Remove(URL);

	OnDownloadFinished.Broadcast(URL, Type, Cached.Bytes);
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

