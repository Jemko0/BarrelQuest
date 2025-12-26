

#pragma once

#include "CoreMinimal.h"
#include "LuaState.h"
#include "BarrelLuaState.generated.h"

typedef TMap<FName, TMap<FString, FLuaValue>> FBarrelLuaHooks;

USTRUCT(BlueprintType)
struct BARRELQUEST_API FHookEntry
{
	GENERATED_BODY()

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Hook")
	FString Identifier;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Hook")
	FLuaValue LuaFunction;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Hook")
	bool bValid;

	FHookEntry()
	{
		bValid = false;
	}

	FHookEntry(const FString& InIdentifier, const FLuaValue& InFunction)
		: Identifier(InIdentifier), LuaFunction(InFunction), bValid(true)
	{
	}
};

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
	
	UFUNCTION(BlueprintCallable, Category = "Lua|Hooks")
	void AddHook(const FString& EventName, const FString& Identifier, FLuaValue LuaFunction);

	UFUNCTION(BlueprintCallable, Category = "Lua|Hooks")
	void RemoveHook(const FString& EventName, const FString& Identifier);
	
	TMap<FString, TArray<FHookEntry>> HookRegistry;

	void PushLuaValue(const FLuaValue& Value);
	void CleanupInvalidHooks(const FString& EventName);
	FLuaValue PopLuaValue();
	
	UFUNCTION(BlueprintCallable, Category = "Lua|Hooks")
	TArray<FLuaValue> HookCall(const FString& EventName, const TArray<FLuaValue>& Arguments);
	
	// __index(object, key) -> returning 1 value
	LUACFUNCTION(UBarrelLuaState, MetaMethodIndex, 1, 2);

	// __newindex(object, key, value)
	LUACFUNCTION(UBarrelLuaState, MetaMethodNewIndex, 0, 3);

	// __eq(object1, object2) -> returning bool
	LUACFUNCTION(UBarrelLuaState, MetaMethodEq, 1, 2);

	// __string(object) -> returning string
	LUACFUNCTION(UBarrelLuaState, MetaMethodToString, 1, 1);
};
