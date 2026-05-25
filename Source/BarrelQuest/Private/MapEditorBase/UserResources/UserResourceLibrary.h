#pragma once

#include "CoreMinimal.h"
#include "UserResourceLibrary.generated.h"

USTRUCT(BlueprintType)
struct FUserResource
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadOnly) int32 ID;
	UPROPERTY(BlueprintReadOnly) FString UploaderUserID;
	UPROPERTY(BlueprintReadOnly) FString Name;
	UPROPERTY(BlueprintReadOnly) FString URL;
	UPROPERTY(BlueprintReadOnly) FString Type;
	UPROPERTY(BlueprintReadOnly) int32 Downloads;
	UPROPERTY(BlueprintReadOnly) FString CreatedAt;
};

USTRUCT(BlueprintType)
struct FSavedUserResource
{
	GENERATED_BODY()
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FString ResourceURL;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FString ResourceType;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<uint8> DataBytes;
};

DECLARE_DYNAMIC_DELEGATE_ThreeParams(FOnHttpRequestComplete,
	int32, StatusCode,
	FString, ResponseBody,
	bool, bSuccess);

DECLARE_DYNAMIC_DELEGATE_TwoParams(FOnHttpUploadProgress, int64, BytesSent, int64, TotalBytes);

const FString BarrelAPIURL = "https://barrel-api.ratt.ing/";

UCLASS()
class BARRELQUEST_API UUserResourceLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
	public:
	UFUNCTION(BlueprintPure, BlueprintCallable, meta = (NativeMakeFunc))
	static FUserResource MakeUserResource(int32 ID, FString UploaderUserID, FString Name, FString URL, FString Type, int32 Downloads, FString CreatedAt)
	{
		FUserResource result;
		result.ID = ID;
		result.UploaderUserID = UploaderUserID;
		result.Name = Name;
		result.URL = URL;
		result.Type = Type;
		result.Downloads = Downloads;
		result.CreatedAt = CreatedAt;
		return result;
	};
	
	UFUNCTION(BlueprintPure, BlueprintCallable, meta = (NativeBreakFunc))
	static void BreakUserResource(
		FUserResource InResource,
		int32& ID,
    	FString& UploaderUserID,
    	FString& Name,
    	FString& URL,
    	FString& Type,
    	int32& Downloads,
    	FString& CreatedAt
	)
	{
		ID = InResource.ID;
		UploaderUserID = InResource.UploaderUserID;
		Name = InResource.Name;
		URL = InResource.URL;
		Type = InResource.Type;
		Downloads = InResource.Downloads;
		CreatedAt = InResource.CreatedAt;
	};
	
	UFUNCTION(BlueprintCallable, Category = "HTTP")
	static void UploadFileFromPath(
		const FString& URL,
		const FString& FilePath,
		const TMap<FString, FString>& Headers,
		FOnHttpRequestComplete OnComplete,
		FOnHttpUploadProgress OnProgress);

	UFUNCTION(BlueprintCallable, Category = "HTTP", meta = (DisplayName = "Upload File From Path With Form Data"))
	static void UploadFileFromPathWithFormData(
		const FString& URL,
		const FString& FilePath,
		const TMap<FString, FString>& Headers,
		const TMap<FString, FString>& MultipartFormData,
		const FString& FileFieldName,
		FOnHttpRequestComplete OnComplete,
		FOnHttpUploadProgress OnProgress);
};
