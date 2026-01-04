
#include "Tiles/TileCuttingComponent.h"

#include "Camera/CameraComponent.h"
#include "Kismet/GameplayStatics.h"
#include "Kismet/KismetSystemLibrary.h"

// Sets default values for this component's properties
UTileCuttingComponent::UTileCuttingComponent()
{
	// Set this component to be initialized when the game starts, and to be ticked every frame.  You can turn these features
	// off to improve performance if you don't need them.
	PrimaryComponentTick.bCanEverTick = true;

	// ...
}


void UTileCuttingComponent::PreUpdate_Implementation()
{
	CurrentFocusPoint = IViewConeQueryInterface::Execute_GetFocusPoint(GetOwner());
}

void UTileCuttingComponent::Update()
{
	bool checkObstructing = CheckBuilding();
	ClearBuilding();
	
	if (!checkObstructing) return;
	
	ClearObstructingTiles();
	CheckObstructingTiles();
}

void UTileCuttingComponent::ClearBuilding()
{
	if (!isTargetInBuilding)
	{
		CurrentRoom = FRoomValue();
		CurrentRoomID = -1;
	}
}

//returns true if it should check for obstructing tiles after this.
bool UTileCuttingComponent::CheckBuilding()
{
	bool shouldCheckObstructingTiles = true;
	isTargetInBuilding = false;
	FVector worldPosition = CurrentFocusPoint;
	
	CurrentRoomID = TileManager->GetRoomAt(worldPosition, CurrentRoom);
	
	if (CurrentRoomID == -1)
	{
		isTargetInBuilding = false;
		shouldCheckObstructingTiles = true;
	}
	else
	{
		isTargetInBuilding = true;
		shouldCheckObstructingTiles = false;
	}
	
	FIntVector targetTilePosition = UTileLibrary::WorldToTilePosition(worldPosition);
	
	for (auto& roomTile : CurrentRoom.tiles)
	{
		if (roomTile.Z > targetTilePosition.Z)
		{
			TileManager->SetInstanceDataByTileIndex(roomTile, ETileInstanceDataIndex::FORCE_CUT, isTargetInBuilding? 1.0f : 0.0f);
		}
		TileManager->SetInstanceDataByTileIndex(roomTile, ETileInstanceDataIndex::SHOULD_CUT, isTargetInBuilding? 1.0f : 0.0f);
	}
	
	return shouldCheckObstructingTiles;
}

void UTileCuttingComponent::ClearObstructingTiles()
{
	for (auto& tile : hiddenTiles)
	{
		TileManager->SetInstanceDataByTileIndex(tile, ETileInstanceDataIndex::FORCE_CUT, 0.0f);
	}
	hiddenTiles.Empty();
}

void UTileCuttingComponent::CheckObstructingTiles()
{
	isTargetObstructed = false;
	
	UCameraComponent* ownerCamera = GetOwner()->FindComponentByClass<UCameraComponent>();
	if (!ownerCamera)
	{
		return;
	}
	
	float sphereRadius = 600.0f;
	
	FVector rayStart = CurrentFocusPoint;
	FVector rayEnd = ownerCamera->GetComponentLocation();
	
	FVector rayDir = ((rayEnd - rayStart).GetSafeNormal());
	rayEnd = rayStart + rayDir * (sphereRadius * 2.0f);
	
	TArray<AActor*> actorsToIgnore;
	actorsToIgnore.Add(GetOwner());
	
	TArray<FHitResult> hitResults;
	
	UKismetSystemLibrary::SphereTraceMulti(GetWorld(), rayStart, rayEnd, 600.0f, TraceType, false, actorsToIgnore, 
		EDrawDebugTrace::None, hitResults, true);
	
	for (auto hit : hitResults)
	{
		FIntVector tilePosition = UTileLibrary::WorldToTilePosition(hit.ImpactPoint);
		
		TileManager->SetInstanceDataByTileIndex(tilePosition, ETileInstanceDataIndex::FORCE_CUT, 1.0f);
		hiddenTiles.Add(tilePosition);
	}
}

// Called when the game starts
void UTileCuttingComponent::BeginPlay()
{
	Super::BeginPlay();
	TileManager = static_cast<ATileManager*>(UGameplayStatics::GetActorOfClass(GetWorld(), ATileManager::StaticClass()));
}


// Called every frame
void UTileCuttingComponent::TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
	PreUpdate();
	Update();
}

