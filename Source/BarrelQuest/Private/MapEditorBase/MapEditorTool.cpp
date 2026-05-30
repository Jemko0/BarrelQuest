#include "MapEditorBase/MapEditorTool.h"
#include "GameFramework/InputSettings.h"

namespace
{
bool ModifiersMatch(const FInputActionKeyMapping& Mapping, const UPlayerInput* PlayerInput)
{
	if (!PlayerInput)
	{
		return !Mapping.bShift && !Mapping.bCtrl && !Mapping.bAlt && !Mapping.bCmd;
	}

	return (!Mapping.bShift || PlayerInput->IsShiftPressed())
		&& (!Mapping.bCtrl || PlayerInput->IsCtrlPressed())
		&& (!Mapping.bAlt || PlayerInput->IsAltPressed())
		&& (!Mapping.bCmd || PlayerInput->IsCmdPressed());
}
}

bool UMapEditorTool::DispatchActionInput(FKey Key, EInputEvent Event, const UPlayerInput* PlayerInput)
{
	const UInputSettings* Settings = UInputSettings::GetInputSettings();
	if (!Settings) return false;

	bool bHandled = false;

	for (const FInputActionKeyMapping& Mapping : Settings->GetActionMappings())
	{
		if (Mapping.Key == Key && ModifiersMatch(Mapping, PlayerInput))
		{
			OnActionInput(Mapping.ActionName, Event);
			bHandled = true;
		}
	}

	return bHandled;
}

bool UMapEditorTool::DispatchAxisInputs(const UPlayerInput* PlayerInput)
{
	const UInputSettings* Settings = UInputSettings::GetInputSettings();
	if (!Settings || !PlayerInput) return false;

	TMap<FName, float> AxisValues;

	for (const FInputAxisKeyMapping& Mapping : Settings->GetAxisMappings())
	{
		AxisValues.FindOrAdd(Mapping.AxisName) += PlayerInput->GetKeyValue(Mapping.Key) * Mapping.Scale;
	}

	for (const TPair<FName, float>& AxisValue : AxisValues)
	{
		OnAxisInput(AxisValue.Key, AxisValue.Value);
	}

	return AxisValues.Num() > 0;
}
