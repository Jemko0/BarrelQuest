

#pragma once

#include "CoreMinimal.h"
#include "LuaState.h"
#include "BarrelLuaState.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UBarrelLuaState : public ULuaState
{
	GENERATED_BODY()
	
public:
	UBarrelLuaState();
	
protected:
	virtual void LuaStateInit() override;
	
	// __index(object, key) -> returning 1 value
	LUACFUNCTION(UBarrelLuaState, MetaMethodIndex, 1, 2);

	// __newindex(object, key, value)
	LUACFUNCTION(UBarrelLuaState, MetaMethodNewIndex, 0, 3);

	// __eq(object1, object2) -> returning bool
	LUACFUNCTION(UBarrelLuaState, MetaMethodEq, 1, 2);

	// __string(object) -> returning string
	LUACFUNCTION(UBarrelLuaState, MetaMethodToString, 1, 1);
};
