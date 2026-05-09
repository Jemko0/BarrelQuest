

#pragma once

#include "CoreMinimal.h"
#include "UObject/NoExportTypes.h"
#include "MapEditorTool.generated.h"

/**
 * Base Class for map editor tools
 */
UCLASS(Abstract, Blueprintable)
class BARRELQUEST_API UMapEditorTool : public UObject
{
	GENERATED_BODY()
	
	virtual UWorld* GetWorld() const override
	{
		return GetOuter() ? GetOuter()->GetWorld() : nullptr;
	}
	
	
};
