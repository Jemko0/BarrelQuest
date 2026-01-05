

#pragma once

#include "CoreMinimal.h"
#include "Camera/CameraComponent.h"
#include "Components/ActorComponent.h"
#include "Tiles/TileLibrary.h"
#include "Tiles/TileManager.h"
#include "ViewCone/ViewConeQueryInterface.h"
#include "TileCuttingComponent.generated.h"


UCLASS( ClassGroup=(Custom), meta=(BlueprintSpawnableComponent) )
class BARRELQUEST_API UTileCuttingComponent : public UActorComponent, public IViewConeQueryInterface
{
	GENERATED_BODY()

public:	
	// Sets default values for this component's properties
	UTileCuttingComponent();
	ATileManager* TileManager;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Properties")
	int32 CameraOcclusionThickness = 4;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Runtime Properties")
	FVector CurrentFocusPoint;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Runtime Properties")
	bool isTargetObstructed = false;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Runtime Properties")
	bool isTargetInBuilding = false;
	
	UCameraComponent* ownerCamera;
	
	UPROPERTY()
	int32 lastZ = 0;
	
	UPROPERTY()
	int32 currentZ = 0;
	
	UPROPERTY()
	bool zChanged = false;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Properties")
	float tileBehindThreshold = -0.25f;
	
	FRoomValue LastRoom;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Runtime Properties")
	FRoomValue CurrentRoom;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Runtime Properties")
	int CurrentRoomID = -1;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Properties")
	TEnumAsByte<ECollisionChannel> DirectTraceCollisionChannel;
	
	TSet<FIntVector> hitTilesLastFrame;
	TSet<FIntVector> hiddenRoomTilesLastFrame;
	TSet<FIntVector> hiddenRoomTilesThisFrame;
	
	TSet<FIntVector> tilesToUndoForceCut;
	TSet<FIntVector> tilesToForceCut;
	
	TSet<FIntVector> tilesThatUndoShouldCut;
	TSet<FIntVector> tilesThatShouldCut;
	
	TSet<FIntVector> importantVisibilityTiles;
	//temp
	TSet<FIntVector> TilesBlockingFocus;
	TSet<FIntVector> TilesBlockingImportant;
	TSet<FIntVector> hitTilesThisFrame;
	
	UFUNCTION(BlueprintCallable, BlueprintNativeEvent)
	void PreUpdate();
	void Update();
	
	void ClearBuilding();
	void RestoreLastRoom();
	bool CheckBuilding();
	
	void CheckObstructingTiles();
	void UpdateImportantVisibilityTiles();
	void UpdateTileVisibility();
	
protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

		
};
