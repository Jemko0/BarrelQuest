#include "UI/ColorPicker/ColorPickerLibrary.h"
#include "Framework/Application/SlateApplication.h"
#include "HAL/PlatformApplicationMisc.h"
#include "Widgets/SWindow.h"

FLinearColor UColorPickerLibrary::GetColorUnderMouse(APlayerController* PlayerController)
{
	if (!PlayerController)
	{
		return FLinearColor::Black;
	}

	if (!FSlateApplication::IsInitialized())
	{
		return FLinearColor::Black;
	}
	
	// Get cursor position in screen space
	FVector2D CursorPos = FSlateApplication::Get().GetCursorPos();
    
	// Get the pixel color at cursor position (2.2 is standard gamma)
	return FPlatformApplicationMisc::GetScreenPixelColor(CursorPos, 2.2f);
}