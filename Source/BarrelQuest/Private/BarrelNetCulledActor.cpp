


#include "BarrelNetCulledActor.h"
#include "GameFramework/GameNetworkManager.h"

// Sets default values
ABarrelNetCulledActor::ABarrelNetCulledActor()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

}

// Called when the game starts or when spawned
void ABarrelNetCulledActor::BeginPlay()
{
	Super::BeginPlay();
	
}

bool ABarrelNetCulledActor::IsNetRelevantFor(const AActor* RealViewer, const AActor* ViewTarget, const FVector& SrcLocation) const
{
	if (bUseBarrelCustomNetCulling)
	{
		return GetBarrelCustomNetRelevancy(RealViewer, ViewTarget, SrcLocation);
	}

	return Super::IsNetRelevantFor(RealViewer, ViewTarget, SrcLocation);
}

// Called every frame
void ABarrelNetCulledActor::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

}

bool ABarrelNetCulledActor::GetBarrelCustomNetRelevancy_Implementation(const AActor* RealViewer, const AActor* ViewTarget, const FVector& SrcLocation) const
{
	return true;
}

