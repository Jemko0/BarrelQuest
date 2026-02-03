// 

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "ColorPickerLibrary.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UColorPickerLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
	UFUNCTION(BlueprintCallable, Category = "Color Picker")
	static FLinearColor GetColorUnderMouse(APlayerController* PlayerController);
};
