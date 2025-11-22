

#include "BarrelUtilityFunctionLibrary.h"
#include "Kismet/KismetStringLibrary.h"

FLinearColor UBarrelUtilityFunctionLibrary::HexStringToLinearColor(FString hexString)
{
	if (hexString.StartsWith(TEXT("#")))
	{
		hexString = hexString.RightChop(1);
	}

	int32 hexValue = FCString::Strtoi(*hexString, nullptr, 16);

	uint8 r = (hexValue >> 16) & 0xFF;
	uint8 g = (hexValue >> 8) & 0xFF;
	uint8 b = hexValue & 0xFF;
	uint8 a = 255;

	if (hexString.Len() == 8)
	{
		a = hexValue & 0xFF;
		b = (hexValue >> 8) & 0xFF;
		g = (hexValue >> 16) & 0xFF;
		r = (hexValue >> 24) & 0xFF;
	}

	return FLinearColor(r, g, b, a);
}
