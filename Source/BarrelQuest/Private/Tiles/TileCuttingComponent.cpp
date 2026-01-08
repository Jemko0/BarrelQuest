
#include "Tiles/TileCuttingComponent.h"

#include "BarrelUtilityLibrary.h"
#include "Kismet/GameplayStatics.h"

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
	
    lastZ = currentZ;
	currentZ = UTileLibrary::WorldToTilePosition(CurrentFocusPoint).Z;
	zChanged = (currentZ != lastZ);
	
	UpdateImportantVisibilityTiles();
	CheckObstructingTiles();
	if (CheckBuilding()) //true if room changed since last frame
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
	
	for (auto& tile : hitTilesLastFrame)
	{
		tilesToUndoForceCut.Add(tile);
	}
	
	hitTilesLastFrame.Empty();
}

bool UTileCuttingComponent::CheckBuilding()
{
	isTargetInBuilding = false;
	FVector worldPosition = CurrentFocusPoint;
	
	int32 lastRoomID = CurrentRoomID;
	LastRoom = CurrentRoom;
	
	// add ceilings to LastRoom
	TSet<FIntVector> lastRoomWithCeilings = LastRoom.tiles;
	for (auto& roomTile : LastRoom.tiles)
	{
		lastRoomWithCeilings.Add(roomTile + FIntVector(0, 0, 1));
	}
	
	LastRoom.tiles = lastRoomWithCeilings;
	
	if (zChanged)
	{
		isTargetInBuilding = false; //force outside state
		return true;  // trigger restore
	}
	
	// now get the new room if z didnt change
	CurrentRoomID = TileManager->GetRoomAt(worldPosition, CurrentRoom);
	
	TSet<FIntVector> roomWithCeilings = CurrentRoom.tiles;
	for (auto& roomTile : CurrentRoom.tiles)
	{
		roomWithCeilings.Add(roomTile + FIntVector(0, 0, 1));
	}
	
	isTargetInBuilding = CurrentRoomID != -1;
	
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
    
	if (!ownerCamera)
	{
		ownerCamera = GetOwner()->FindComponentByClass<UCameraComponent>();
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
	
	FIntVector focusTile = UTileLibrary::WorldToTilePosition(startWorld);
	FIntVector cameraTile = UTileLibrary::WorldToTilePosition(endWorld);
	
	TilesBlockingImportant.Empty();
	
	hitTilesThisFrame.Empty();
	//only mark tiles as obstructed if we are actually obstructed and z didnt change
	if (!zChanged && isTargetObstructed)
	{
		TilesBlockingImportant = ATileManager::GetObstructingAreaIndices(cameraTile, importantVisibilityTiles);
		TilesBlockingImportant.Append(TileManager->ThickRaycast(focusTile, cameraTile, CameraOcclusionThickness));
		
		FVector cameraForward = ownerCamera->GetForwardVector().GetSafeNormal2D();
		
		for (auto& tile : TilesBlockingImportant)
		{
			if (CurrentRoom.tiles.Contains(tile)) continue;
			
			int roomID = TileManager->GetRoomIDAt(tile);
			FRoomValue room = TileManager->GetRoomByID(roomID);
			
			FVector tileWorld = UTileLibrary::TileToWorldPosition(tile);
			FVector toObject = tileWorld - CurrentFocusPoint;
			toObject.Z = 0.0f;
			toObject.Normalize();
			float dot = FVector::DotProduct(cameraForward, toObject);
			if (dot > tileBehindThreshold) continue;
			
			hitTilesThisFrame.Add(tile);
			hitTilesThisFrame.Append(room.tiles);
			hitTilesThisFrame.Append(room.ceilings);
		}
	}
	
	TSet<FIntVector> newTilesToHide = hitTilesThisFrame.Difference(hitTilesLastFrame);
	
	TSet<FIntVector> newTilesToShow = hitTilesLastFrame.Difference(hitTilesThisFrame);
	
	tilesToForceCut.Append(newTilesToHide);
	tilesToUndoForceCut.Append(newTilesToShow);
	
	hitTilesLastFrame = hitTilesThisFrame;
}

void UTileCuttingComponent::UpdateImportantVisibilityTiles()
{
	importantVisibilityTiles.Empty();
	importantVisibilityTiles.Append(CurrentRoom.tiles);
}

void UTileCuttingComponent::UpdateTileVisibility()
{
	FIntVector targetTilePosition = UTileLibrary::WorldToTilePosition(CurrentFocusPoint);
	
	for (auto& tile : tilesToForceCut)
	{
		FTileSearchFilter searchFilter = FTileSearchFilter();
		searchFilter.IncludeCategory(ETileCategory::WALL);
		searchFilter.SetMinZLevel(lastZ);
		
		TileManager->SetInstanceDataByTileIndex(tile, ETileInstanceDataIndex::FORCE_CUT, 1.0f, searchFilter);
	}
	
	for (auto& tile : tilesToUndoForceCut)
	{
		FTileSearchFilter searchFilter = FTileSearchFilter();
		searchFilter.IncludeCategory(ETileCategory::WALL);
		searchFilter.SetMinZLevel(lastZ);
		
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
	if (!TileManager)
	{
		UE_LOG(LogBarrelQuest, Error, TEXT("ERROR: TileManager is nullptr!"));
		return;
	}
	
	PreUpdate();
	Update();
}

