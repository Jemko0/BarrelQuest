

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "Interfaces/IHttpRequest.h"
#include "UserResourceComponent.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FOnResourceDownloadStarted, FString, ResourceURL, FString, ResourceType);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_ThreeParams(FOnResourceDownloadFinished, FString, ResourceURL, FString, ResourceType, TArray<uint8>, Bytes);
DECLARE_DYNAMIC_MULTICAST_DELEGATE_ThreeParams(FOnResourceDownloadFailed, FString, ResourceURL, FString, ResourceType, FString, Error);

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
	
	UFUNCTION(BlueprintCallable)
	static FInterpretedResourceData InterpretData(UObject* WorldContextObject, FString ResourceURL, FString ResourceType, UPARAM(ref) TArray<uint8>& Buffer);

protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

		
};
