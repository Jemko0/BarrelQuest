
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
	tilesToForceCut.Empty();
	tilesToUndoForceCut.Empty();
	tilesThatShouldCut.Empty();
	tilesThatUndoShouldCut.Empty();
    
	CheckObstructingTiles();
	if (CheckBuilding()) //true if room changed since last frame or Z
	{
		RestoreLastRoom();
	}
	
	ClearBuilding();
	UpdateTileVisibility();
}

void UTileCuttingComponent::ClearBuilding()
{
	if (!isTargetInBuilding)
	{
		CurrentRoom = FRoomValue();
		CurrentRoomID = -1;
	}
}

void UTileCuttingComponent::RestoreLastRoom()
{
	for (auto& tile : LastRoom.tiles)
	{
		tilesThatUndoShouldCut.Add(tile);
		tilesToUndoForceCut.Add(tile);
	}
	
	hitTilesLastFrame.Empty();
}

bool UTileCuttingComponent::CheckBuilding()
{
	isTargetInBuilding = false;
	FVector worldPosition = CurrentFocusPoint;
	
	int32 currentZ = UTileLibrary::WorldToTilePosition(CurrentFocusPoint).Z;
	int32 lastRoomID = CurrentRoomID;
	
	// save BEFORE getting new room
	LastRoom = CurrentRoom;
	
	// add ceilings to LastRoom
	TSet<FIntVector> lastRoomWithCeilings = LastRoom.tiles;
	for (auto& roomTile : LastRoom.tiles)
	{
		lastRoomWithCeilings.Add(roomTile + FIntVector(0, 0, 1));
	}
	LastRoom.tiles = lastRoomWithCeilings;
	
	// If Z changed, pretend we're outside for this frame
	bool zChanged = (lastZLevel != currentZ);
	if (zChanged)
	{
		lastZLevel = currentZ;
		CurrentRoomID = -1;  // Force "outside" state
		CurrentRoom = FRoomValue();  // Clear current room
		isTargetInBuilding = false;
		return true;  // Trigger restore
	}
	
	// NOW get the new room (only if Z didn't change)
	CurrentRoomID = TileManager->GetRoomAt(worldPosition, CurrentRoom);
	
	TSet<FIntVector> roomWithCeilings = CurrentRoom.tiles;
	for (auto& roomTile : CurrentRoom.tiles)
	{
		roomWithCeilings.Add(roomTile + FIntVector(0, 0, 1));
	}
	
	if (CurrentRoomID == -1)
	{
		isTargetInBuilding = false;
	}
	else
	{
		isTargetInBuilding = true;
	}
	
	FIntVector targetTilePosition = UTileLibrary::WorldToTilePosition(worldPosition);
	
	for (auto& roomTile : roomWithCeilings)
	{
		if (isTargetInBuilding)
		{
			//we are in the building
			if (roomTile.Z > targetTilePosition.Z)
			{
				tilesToForceCut.Add(roomTile);
			}
			else
			{
				tilesToUndoForceCut.Add(roomTile);
			}
			tilesThatShouldCut.Add(roomTile);
		}
		else
		{
			// restore everything when leaving the building
			if (!hitTilesLastFrame.Contains(roomTile))
			{
				tilesToUndoForceCut.Add(roomTile);
			}
			
			tilesThatUndoShouldCut.Add(roomTile);
		}
	}
	
	return CurrentRoomID != lastRoomID;
}

void UTileCuttingComponent::CheckObstructingTiles()
{
	isTargetObstructed = false;
    
	UCameraComponent* ownerCamera = GetOwner()->FindComponentByClass<UCameraComponent>();
	if (!ownerCamera)
	{
		return;
	}
    
	FVector startWorld = CurrentFocusPoint;
	FVector endWorld = ownerCamera->GetComponentLocation();
	FHitResult lineTraceHit;
	FCollisionQueryParams qParams;
	qParams.AddIgnoredActor(GetOwner());
	FCollisionResponseParams rParams;
	
	GetWorld()->LineTraceSingleByChannel(lineTraceHit, startWorld, endWorld, DirectTraceCollisionChannel, qParams, 
		rParams);
	
	isTargetObstructed = lineTraceHit.bBlockingHit;
	
	FIntVector startTile = UTileLibrary::WorldToTilePosition(startWorld);
	FIntVector endTile = UTileLibrary::WorldToTilePosition(endWorld);
	
	// Check if Z level changed - DON'T clear hitTilesLastFrame yet
	// RestoreLastRoom() will handle it
	bool zChanged = (lastZLevel != startTile.Z);
	if (zChanged)
	{
		lastZLevel = startTile.Z;
	}
    
	TArray<FIntVector> HitTiles = TileManager->ThickRaycast(startTile, endTile, CameraOcclusionThickness);
    
	TSet<FIntVector> hitTilesThisFrame;
	
	FVector cameraForward = ownerCamera->GetForwardVector();
	cameraForward.Z = 0.0f;
	
	if (isTargetObstructed)
	{
		for (auto& tile : HitTiles)
		{
			if (CurrentRoom.tiles.Contains(tile)) continue;
			
			FVector tileWorld = UTileLibrary::TileToWorldPosition(tile);
			FVector toObject = tileWorld - CurrentFocusPoint;
			
			toObject.Z = 0.0f;
			toObject.Normalize();
			
			float dot = FVector::DotProduct(cameraForward, toObject);
			
			if (dot > tileBehindThreshold) continue;
			
			hitTilesThisFrame.Add(tile);
		}
	}
	
	if (!zChanged)
	{
		TSet<FIntVector> newTilesToHide = hitTilesThisFrame.Difference(hitTilesLastFrame);
		
		TSet<FIntVector> newTilesToShow = hitTilesLastFrame.Difference(hitTilesThisFrame);
		
		tilesToForceCut.Append(newTilesToHide);
		tilesToUndoForceCut.Append(newTilesToShow);
	}
    
	hitTilesLastFrame = hitTilesThisFrame;
}

void UTileCuttingComponent::UpdateTileVisibility()
{
	FIntVector targetTilePosition = UTileLibrary::WorldToTilePosition(CurrentFocusPoint);
	
	for (auto& tile : tilesToForceCut)
	{
		FTileSearchFilter searchFilter = FTileSearchFilter();
		searchFilter.IncludeCategory(ETileCategory::WALL);
		searchFilter.SetMinZLevel(targetTilePosition.Z);
		
		TileManager->SetInstanceDataByTileIndex(tile, ETileInstanceDataIndex::FORCE_CUT, 1.0f, searchFilter);
	}
	
	for (auto& tile : tilesToUndoForceCut)
	{
		FTileSearchFilter searchFilter = FTileSearchFilter();
		searchFilter.IncludeCategory(ETileCategory::WALL);
		searchFilter.SetMinZLevel(targetTilePosition.Z);
		
		TileManager->SetInstanceDataByTileIndex(tile, ETileInstanceDataIndex::FORCE_CUT, 0.0f, searchFilter);
	}
	
	for (auto& tile : tilesThatShouldCut)
	{
		TileManager->SetInstanceDataByTileIndex(tile, ETileInstanceDataIndex::SHOULD_CUT, 1.0f);
	}
	
	for (auto& tile : tilesThatUndoShouldCut)
	{
		TileManager->SetInstanceDataByTileIndex(tile, ETileInstanceDataIndex::SHOULD_CUT, 0.0f);
	}
}

/*
void UTileCuttingComponent::OnRoomChanged()
{
	for (auto it = hitTilesLastFrame.CreateIterator(); it; ++it)
	{
		if (CurrentRoom.tiles.Contains(*it))
		{
			TileManager->SetInstanceDataByTileIndex(*it, ETileInstanceDataIndex::FORCE_CUT, 0.0f);
			it.RemoveCurrent();
		}
	}
}
*/

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

