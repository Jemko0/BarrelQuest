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

FVector2D UColorPickerLibrary::GetRawMousePosition(APlayerController* PlayerController)
{
	if (!PlayerController)
	{
		return FVector2D::ZeroVector;
	}

	if (!FSlateApplication::IsInitialized())
	{
		return FVector2D::ZeroVector;
	}
	
	return FSlateApplication::Get().GetCursorPos();
}

FLinearColor UColorPickerLibrary::GetColorUnderPosition(FVector2D screenPosition)
{
	if (!FSlateApplication::IsInitialized())
	{
		return FLinearColor::Black;
	}
	
	// Get cursor position in screen space
	FVector2D inScreenPos = screenPosition;
    
	// Get the pixel color at cursor position (2.2 is standard gamma)
	return FPlatformApplicationMisc::GetScreenPixelColor(inScreenPos, 2.2f);
}
