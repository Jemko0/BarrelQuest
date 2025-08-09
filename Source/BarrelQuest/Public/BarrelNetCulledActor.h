

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "BarrelNetCulledActor.generated.h"

UCLASS()
class BARRELQUEST_API ABarrelNetCulledActor : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	ABarrelNetCulledActor();

	UPROPERTY(Category = "Replication", BlueprintReadWrite, EditAnywhere)
	bool bUseBarrelCustomNetCulling = false;

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;
	virtual bool IsNetRelevantFor(const AActor* RealViewer, const AActor* ViewTarget, const FVector& SrcLocation) const override;

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

	UFUNCTION(BlueprintCallable, Category = "Barrel Custom Replication", BlueprintNativeEvent)
	bool GetBarrelCustomNetRelevancy(const AActor* RealViewer, const AActor* ViewTarget, const FVector& SrcLocation) const;

};
