

#pragma once

#include "CoreMinimal.h"
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
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FVector CurrentFocusPoint;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	bool isTargetObstructed = false;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	bool isTargetInBuilding = false;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FRoomValue CurrentRoom;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	int CurrentRoomID = -1;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TEnumAsByte<ETraceTypeQuery> TraceType;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TSet<FIntVector> obstructingNonRoomTiles;
	
	UPROPERTY()
	TSet<FIntVector> hiddenTiles;
	
	UFUNCTION(BlueprintCallable, BlueprintNativeEvent)
	void PreUpdate();
	void Update();
	
	void ClearBuilding();
	bool CheckBuilding();
	
	void ClearObstructingTiles();
	void CheckObstructingTiles();
	
protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType, FActorComponentTickFunction* ThisTickFunction) override;

		
};
