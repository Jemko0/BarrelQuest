#include "UserResourceLibrary.h"

#include "HttpModule.h"
#include "Interfaces/IHttpRequest.h"
#include "Interfaces/IHttpResponse.h"
#include "Misc/FileHelper.h"
#include "Misc/Paths.h"

namespace
{
void AppendStringAsUtf8(TArray<uint8>& Bytes, const FString& String)
{
	FTCHARToUTF8 Converted(*String);
	Bytes.Append(reinterpret_cast<const uint8*>(Converted.Get()), Converted.Length());
}

void SetRequestHeaders(TSharedRef<IHttpRequest, ESPMode::ThreadSafe> Request, const TMap<FString, FString>& Headers, bool& bHasContentType)
{
	bHasContentType = false;
	for (const TPair<FString, FString>& Header : Headers)
	{
		Request->SetHeader(Header.Key, Header.Value);
		if (Header.Key.Equals(TEXT("Content-Type"), ESearchCase::IgnoreCase))
		{
			bHasContentType = true;
		}
	}
}

TArray<uint8> BuildMultipartPayload(const FString& FilePath, const TArray<uint8>& FileBytes, const TMap<FString, FString>& MultipartFormData, const FString& FileFieldName, const FString& Boundary)
{
	TArray<uint8> Payload;
	const FString LineBreak = TEXT("\r\n");

	for (const TPair<FString, FString>& FormData : MultipartFormData)
	{
		AppendStringAsUtf8(Payload, FString::Printf(TEXT("--%s%s"), *Boundary, *LineBreak));
		AppendStringAsUtf8(Payload, FString::Printf(TEXT("Content-Disposition: form-data; name=\"%s\"%s%s"), *FormData.Key, *LineBreak, *LineBreak));
		AppendStringAsUtf8(Payload, FormData.Value);
		AppendStringAsUtf8(Payload, LineBreak);
	}

	const FString SafeFileFieldName = FileFieldName.IsEmpty() ? TEXT("file") : FileFieldName;
	const FString FileName = FPaths::GetCleanFilename(FilePath);
	AppendStringAsUtf8(Payload, FString::Printf(TEXT("--%s%s"), *Boundary, *LineBreak));
	AppendStringAsUtf8(Payload, FString::Printf(TEXT("Content-Disposition: form-data; name=\"%s\"; filename=\"%s\"%s"), *SafeFileFieldName, *FileName, *LineBreak));
	AppendStringAsUtf8(Payload, FString::Printf(TEXT("Content-Type: application/octet-stream%s%s"), *LineBreak, *LineBreak));
	Payload.Append(FileBytes);
	AppendStringAsUtf8(Payload, LineBreak);
	AppendStringAsUtf8(Payload, FString::Printf(TEXT("--%s--%s"), *Boundary, *LineBreak));

	return Payload;
}
}

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

	Request->OnRequestProgress64().BindLambda(
	[OnProgress](FHttpRequestPtr Req, uint64 BytesSent, uint64 BytesReceived)
	{
		OnProgress.ExecuteIfBound((int64)BytesSent, (int64)Req->GetContentLength());
	});

	bool bHasContentType = false;
	SetRequestHeaders(Request, Headers, bHasContentType);

	if (!bHasContentType)
	{
		Request->SetHeader(TEXT("Content-Type"), TEXT("application/octet-stream"));
	}
	Request->SetContent(FileBytes);

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

void UUserResourceLibrary::UploadFileFromPathWithFormData(const FString& URL, const FString& FilePath,
                                                          const TMap<FString, FString>& Headers, const TMap<FString, FString>& MultipartFormData,
                                                          const FString& FileFieldName, FOnHttpRequestComplete OnComplete, FOnHttpUploadProgress OnProgress)
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

	Request->OnRequestProgress64().BindLambda(
	[OnProgress](FHttpRequestPtr Req, uint64 BytesSent, uint64 BytesReceived)
	{
		OnProgress.ExecuteIfBound((int64)BytesSent, (int64)Req->GetContentLength());
	});

	bool bHasContentType = false;
	SetRequestHeaders(Request, Headers, bHasContentType);

	if (MultipartFormData.Num() > 0)
	{
		const FString Boundary = FString::Printf(TEXT("----BarrelQuestFormBoundary%s"), *FGuid::NewGuid().ToString(EGuidFormats::Digits));
		Request->SetHeader(TEXT("Content-Type"), FString::Printf(TEXT("multipart/form-data; boundary=%s"), *Boundary));
		Request->SetContent(BuildMultipartPayload(FilePath, FileBytes, MultipartFormData, FileFieldName, Boundary));
	}
	else
	{
		if (!bHasContentType)
		{
			Request->SetHeader(TEXT("Content-Type"), TEXT("application/octet-stream"));
		}
		Request->SetContent(FileBytes);
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
