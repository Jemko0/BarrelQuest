


#include "BarrelNetCulledCharacter.h"

// Sets default values
ABarrelNetCulledCharacter::ABarrelNetCulledCharacter()
{
 	// Set this character to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

}

// Called when the game starts or when spawned
void ABarrelNetCulledCharacter::BeginPlay()
{
	Super::BeginPlay();
}

bool ABarrelNetCulledCharacter::IsNetRelevantFor(const AActor* RealViewer, const AActor* ViewTarget, const FVector& SrcLocation) const
{
	if (bUseBarrelCustomNetCulling)
	{
		return GetBarrelCustomNetRelevancy(RealViewer, ViewTarget, SrcLocation);
	}

	return Super::IsNetRelevantFor(RealViewer, ViewTarget, SrcLocation);
}

// Called every frame
void ABarrelNetCulledCharacter::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
}

// Called to bind functionality to input
void ABarrelNetCulledCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)
{
	Super::SetupPlayerInputComponent(PlayerInputComponent);

}

bool ABarrelNetCulledCharacter::GetBarrelCustomNetRelevancy_Implementation(const AActor* RealViewer, const AActor* ViewTarget, const FVector& SrcLocation) const
{
	return true;
}
