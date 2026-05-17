

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "Interfaces/IHttpRequest.h"
#include "Kismet/BlueprintAsyncActionBase.h"
#include "UserResourceComponent.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FOnResourceDownloadStarted, FString, ResourceURL, FString, ResourceType);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_ThreeParams(FOnResourceDownloadFinished, FString, ResourceURL, FString, ResourceType, TArray<uint8>, Bytes);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_ThreeParams(FOnResourceDownloadFailed, FString, ResourceURL, FString, ResourceType, FString, Error);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_ThreeParams(FOnRequestResourceAsyncSucceeded, FString, ResourceURL, FString, ResourceType, const TArray<uint8>&, Bytes);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_ThreeParams(FOnRequestResourceAsyncFailed, FString, ResourceURL, FString, ResourceType, FString, Error);

DECLARE_DELEGATE_ThreeParams(FOnResourceDownloadFinishedNative, const FString& /*ResourceURL*/, const FString& /*ResourceType*/, const TArray<uint8>& /*Bytes*/);
DECLARE_DELEGATE_ThreeParams(FOnResourceDownloadFailedNative, const FString& /*ResourceURL*/, const FString& /*ResourceType*/, const FString& /*Error*/);

USTRUCT(BlueprintType)
struct FCachedResource
{
	GENERATED_BODY();
	
public:
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TArray<uint8> Bytes;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	FString Type;
};

USTRUCT(BlueprintType)
struct FInterpretedResourceData
{
	GENERATED_BODY();
	
public:
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UTexture2D* TexturePtr;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UStaticMesh* MeshPtr;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	USoundBase* AudioPtr;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TArray<uint8> RawBytes;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	bool IsMIDIBytes;
};

UCLASS( ClassGroup=(Custom), meta=(BlueprintSpawnableComponent) )
class BARRELQUEST_API UUserResourceComponent : public UActorComponent
{
	GENERATED_BODY()

public:	
	// Sets default values for this component's properties
	UUserResourceComponent();
	
	UPROPERTY(BlueprintAssignable)
	FOnResourceDownloadStarted OnDownloadStarted;
	
	UPROPERTY(BlueprintAssignable)
	FOnResourceDownloadFinished OnDownloadFinished;
	
	UPROPERTY(BlueprintAssignable)
	FOnResourceDownloadFailed OnDownloadFailed;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FString, FCachedResource> ResourceCache;
	
	UPROPERTY(BlueprintReadOnly, EditAnywhere)
	TSet<FString> InProgressDownloads;
	
	UFUNCTION(BlueprintCallable)
	void RequestResource(const FString& ResourceID);

	void RequestResourceWithCallbacks(
		const FString& ResourceID,
		FOnResourceDownloadFinishedNative OnFinished,
		FOnResourceDownloadFailedNative OnFailed);
	
	UFUNCTION(BlueprintCallable)
	bool IsDownloading();
	
	UFUNCTION(BlueprintCallable)
	bool IsCached(const FString& ResourceURL);

	UFUNCTION(BlueprintCallable)
	void ClearResourceCache();

	UFUNCTION(BlueprintPure)
	int64 GetCachedResourceBytes() const;
	
	void OnResourceRequestComplete(FHttpRequestPtr RequestPtr, FHttpResponsePtr ResponsePtr, bool success);
	void OnFileDownloadComplete(FHttpRequestPtr Request, FHttpResponsePtr Response, bool success, FString URL, FString Type);

	void OnResourceRequestCompleteWithCallbacks(
		FHttpRequestPtr RequestPtr,
		FHttpResponsePtr ResponsePtr,
		bool success,
		FOnResourceDownloadFinishedNative OnFinished,
		FOnResourceDownloadFailedNative OnFailed,
		bool bBroadcastComponentDelegates);
	void OnFileDownloadCompleteWithCallbacks(
		FHttpRequestPtr Request,
		FHttpResponsePtr Response,
		bool success,
		FString URL,
		FString Type,
		FOnResourceDownloadFinishedNative OnFinished,
		FOnResourceDownloadFailedNative OnFailed,
		bool bBroadcastComponentDelegates);
	
	UFUNCTION(BlueprintCallable)
	static FInterpretedResourceData InterpretData(UObject* WorldContextObject, FString ResourceURL, FString ResourceType, UPARAM(ref) TArray<uint8>& Buffer);

protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

		
};

UCLASS()
class BARRELQUEST_API URequestResourceAsyncAction : public UBlueprintAsyncActionBase
{
	GENERATED_BODY()

public:
	UPROPERTY(BlueprintAssignable)
	FOnRequestResourceAsyncSucceeded OnSuccess;

	UPROPERTY(BlueprintAssignable)
	FOnRequestResourceAsyncFailed OnFailure;

	UFUNCTION(BlueprintCallable, meta=(BlueprintInternalUseOnly="true", DisplayName="Request Resource Async"))
	static URequestResourceAsyncAction* RequestResource_Async(UUserResourceComponent* ResourceComponent, const FString& ResourceID);

	virtual void Activate() override;

private:
	UPROPERTY()
	UUserResourceComponent* ResourceComponent;

	FString ResourceID;

	void HandleSuccess(const FString& ResourceURL, const FString& ResourceType, const TArray<uint8>& Bytes);
	void HandleFailure(const FString& ResourceURL, const FString& ResourceType, const FString& Error);
};
