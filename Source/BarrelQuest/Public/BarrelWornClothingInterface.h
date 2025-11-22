#pragma once

#include "CoreMinimal.h"
#include "UObject/Interface.h"
#include "BarrelUtilityLibrary.h"
#include "BarrelWornClothingInterface.generated.h"

UINTERFACE(MinimalAPI)
class UBarrelWornClothingInterface : public UInterface
{
	GENERATED_BODY()
};

class BARRELQUEST_API IBarrelWornClothingInterface
{
	GENERATED_BODY()

public:
	
	UFUNCTION(BlueprintCallable, BlueprintNativeEvent)
	TArray<FWearingClothingData> GetWornClothingData();
};
