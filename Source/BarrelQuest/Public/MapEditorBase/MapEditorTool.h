#pragma once

#include "CoreMinimal.h"
#include "GameFramework/PlayerInput.h"
#include "UObject/NoExportTypes.h"
#include "MapEditorTool.generated.h"

UCLASS(Abstract, Blueprintable, BlueprintType, EditInlineNew, DefaultToInstanced)
class BARRELQUEST_API UMapEditorTool : public UObject
{
	GENERATED_BODY()

public:
	virtual UWorld* GetWorld() const override
	{
		return GetOuter() ? GetOuter()->GetWorld() : nullptr;
	}
	
	bool DispatchActionInput(FKey Key, EInputEvent Event, const UPlayerInput* PlayerInput);
	bool DispatchAxisInputs(const UPlayerInput* PlayerInput);

protected:
	UFUNCTION(BlueprintImplementableEvent, Category = "Tool|Input")
	void OnActionInput(FName ActionName, EInputEvent Event);

	UFUNCTION(BlueprintImplementableEvent, Category = "Tool|Input")
	void OnAxisInput(FName AxisName, float Value);
};
