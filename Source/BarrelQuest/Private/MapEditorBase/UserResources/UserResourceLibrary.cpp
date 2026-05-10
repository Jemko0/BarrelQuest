#include "UserResourceLibrary.h"

#include "HttpModule.h"
#include "Interfaces/IHttpRequest.h"
#include "Interfaces/IHttpResponse.h"

void UUserResourceLibrary::UploadFileFromPath(const FString& URL, const FString& FilePath,
                                              const TMap<FString, FString>& Headers, FOnHttpRequestComplete OnComplete, FOnHttpUploadProgress OnProgress)
{
	TArray<uint8> FileBytes;
	if (!FFileHelper::LoadFileToArray(FileBytes, *FilePath))
	{
		OnComplete.ExecuteIfBound(0, TEXT("Failed to read file"), false);
		return;
	}

	TSharedRef<IHttpRequest, ESPMode::ThreadSafe> Request = FHttpModule::Get().CreateRequest();
	Request->SetURL(URL);
	Request->SetVerb(TEXT("POST"));
	Request->SetContent(FileBytes);
	
	Request->OnRequestProgress64().BindLambda(
	[OnProgress](FHttpRequestPtr Req, uint64 BytesSent, uint64 BytesReceived)
	{
		OnProgress.ExecuteIfBound((int64)BytesSent, (int64)Req->GetContentLength());
	});

	for (const TPair<FString, FString>& Header : Headers)
	{
		Request->SetHeader(Header.Key, Header.Value);
	}

	Request->OnProcessRequestComplete().BindLambda(
		[OnComplete](FHttpRequestPtr Req, FHttpResponsePtr Response, bool bSuccess)
		{
			if (bSuccess && Response.IsValid())
			{
				OnComplete.ExecuteIfBound(Response->GetResponseCode(), Response->GetContentAsString(), true);
			}
			else
			{
				OnComplete.ExecuteIfBound(0, TEXT("Request failed"), false);
			}
		});

	Request->ProcessRequest();
}
