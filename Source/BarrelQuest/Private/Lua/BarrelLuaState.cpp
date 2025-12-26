#include "Lua/BarrelLuaState.h"
#include "LuaBlueprintFunctionLibrary.h"

UBarrelLuaState::UBarrelLuaState()
{
	// allow to call native UFunctions with implicit FLuaValue conversions
	bRawLuaFunctionCall = true;
}

void UBarrelLuaState::LuaStateInit()
{
	UserDataMetaTable = CreateLuaTable();
	UserDataMetaTable.SetField("__index", UBarrelLuaState::MetaMethodIndex_C);
	UserDataMetaTable.SetField("__newindex", UBarrelLuaState::MetaMethodNewIndex_C);
	UserDataMetaTable.SetField("__eq", UBarrelLuaState::MetaMethodEq_C);
	UserDataMetaTable.SetField("__tostring", UBarrelLuaState::MetaMethodToString_C);
}

TArray<FLuaValue> UBarrelLuaState::MetaMethodIndex(TArray<FLuaValue> LuaArgs)
{
	TArray<FLuaValue> ReturnValues;

	UObject* Object = LuaArgs[0].Object;
	FString Key = LuaArgs[1].ToString();

	// skip nullptr and classes
	if (!Object || Object->IsA<UClass>())
	{
		return ReturnValues;
	}

	ELuaReflectionType ReflectionType = ELuaReflectionType::Unknown;
	ULuaBlueprintFunctionLibrary::GetLuaReflectionType(Object, Key, ReflectionType);

	if (ReflectionType == ELuaReflectionType::Property)
	{
		ReturnValues.Add(GetLuaValueFromProperty(Object, Key));
	}
	else if (ReflectionType == ELuaReflectionType::Function)
	{
		ReturnValues.Add(FLuaValue::FunctionOfObject(Object, FName(Key)));
	}

	return ReturnValues;
}

TArray<FLuaValue> UBarrelLuaState::MetaMethodNewIndex(TArray<FLuaValue> LuaArgs)
{
	TArray<FLuaValue> ReturnValues;

	UObject* Object = LuaArgs[0].Object;
	FString Key = LuaArgs[1].ToString();
	FLuaValue Value = LuaArgs[2];

	// skip nullptr and classes
	if (!Object || Object->IsA<UClass>())
	{
		return ReturnValues;
	}

	ELuaReflectionType ReflectionType = ELuaReflectionType::Unknown;
	ULuaBlueprintFunctionLibrary::GetLuaReflectionType(Object, Key, ReflectionType);

	if (ReflectionType == ELuaReflectionType::Property)
	{
		SetPropertyFromLuaValue(Object, Key, Value);
	}

	return ReturnValues;
}

TArray<FLuaValue> UBarrelLuaState::MetaMethodEq(TArray<FLuaValue> LuaArgs)
{
	TArray<FLuaValue> ReturnValues;

	UObject* Object = LuaArgs[0].Object;
	UObject* OtherObject = LuaArgs[1].Object;

	if (!Object || !OtherObject)
	{
		ReturnValues.Add(FLuaValue(false));
	}
	else
	{
		ReturnValues.Add(FLuaValue(Object == OtherObject));
	}

	return ReturnValues;
}

TArray<FLuaValue> UBarrelLuaState::MetaMethodToString(TArray<FLuaValue> LuaArgs)
{
	TArray<FLuaValue> ReturnValues;

	UObject* Object = LuaArgs[0].Object;

	// skip nullptr and classes
	if (!Object || Object->IsA<UClass>())
	{
		return ReturnValues;
	}

	ReturnValues.Add(Object->GetFullName());

	return ReturnValues;
}

void UBarrelLuaState::AddHook(const FString& EventName, const FString& Identifier, FLuaValue LuaFunction)
{
	if (EventName.IsEmpty())
	{
		ReceiveLuaError(TEXT("HookAdd: EventName cannot be empty"));
		return;
	}
	if (Identifier.IsEmpty())
	{
		ReceiveLuaError(TEXT("HookAdd: Identifier cannot be empty"));
		return;
	}
	if (LuaFunction.Type != ELuaValueType::Function)
	{
		ReceiveLuaError(TEXT("HookAdd: LuaFunction must be a function"));
		return;
	}

	// Instead of using LuaFunction.LuaRef, get the function from the stack
	// Assume the function is at the top of the stack when HookAdd is called

	// Step 1: Push the function back onto the stack using LuaFunction.LuaRef
	// But only do that if LuaFunction.LuaRef is valid
	if (LuaFunction.LuaRef == LUA_NOREF || LuaFunction.LuaRef == LUA_REFNIL)
	{
		ReceiveLuaError(TEXT("HookAdd: LuaFunction has invalid ref, trying to grab from stack"));

		// Use lua_gettop to get the most recent function pushed by the Lua caller
		// Copy it to the top of the stack, then ref it
		int top = lua_gettop(L);
		lua_pushvalue(L, top); // assumes it's at the top

		if (!lua_isfunction(L, -1)) {
			ReceiveLuaError(TEXT("HookAdd: Top of Lua stack is not a function"));
			lua_pop(L, 1);
			return;
		}

		int32 NewFunctionRef = luaL_ref(L, LUA_REGISTRYINDEX);

		FLuaValue NewLuaFunction;
		NewLuaFunction.Type = ELuaValueType::Function;
		NewLuaFunction.LuaRef = NewFunctionRef;
		NewLuaFunction.LuaState = this;

		LuaFunction = NewLuaFunction;
	}
	else
	{
		// If it actually had a valid ref, use it
		lua_rawgeti(L, LUA_REGISTRYINDEX, LuaFunction.LuaRef);
		if (!lua_isfunction(L, -1)) {
			ReceiveLuaError(TEXT("HookAdd: LuaRef does not point to function"));
			lua_pop(L, 1);
			return;
		}
		lua_pop(L, 1); // Clean up stack

		// Still create a new reference anyway
		lua_rawgeti(L, LUA_REGISTRYINDEX, LuaFunction.LuaRef);
		int32 NewFunctionRef = luaL_ref(L, LUA_REGISTRYINDEX);

		FLuaValue NewLuaFunction;
		NewLuaFunction.Type = ELuaValueType::Function;
		NewLuaFunction.LuaRef = NewFunctionRef;
		NewLuaFunction.LuaState = this;

		LuaFunction = NewLuaFunction;
	}

	// Continue as before...

	TArray<FHookEntry>& HookList = HookRegistry.FindOrAdd(EventName);

	bool bFound = false;
	for (FHookEntry& Entry : HookList)
	{
		if (Entry.Identifier == Identifier)
		{
			if (Entry.LuaFunction.LuaRef != LUA_NOREF && Entry.LuaFunction.LuaRef != LUA_REFNIL)
			{
				luaL_unref(L, LUA_REGISTRYINDEX, Entry.LuaFunction.LuaRef);
			}
			Entry.LuaFunction = LuaFunction;
			Entry.bValid = true;
			bFound = true;
			break;
		}
	}

	if (!bFound)
	{
		HookList.Add(FHookEntry(Identifier, LuaFunction));
	}
	//InternalLog((uint8)0, TEXT("Hook added"));
	//UE_LOG(LogTemp, Log, TEXT("Hook added: %s.%s (ref: %d)"), *EventName, *Identifier, LuaFunction.LuaRef);
}

void UBarrelLuaState::RemoveHook(const FString& EventName, const FString& Identifier)
{
	if (EventName.IsEmpty() || Identifier.IsEmpty())
	{
		ReceiveLuaError(TEXT("HookRemove: EventName and Identifier cannot be empty"));
		return;
	}

	TArray<FHookEntry>* HookList = HookRegistry.Find(EventName);
	if (!HookList)
	{
		ReceiveLuaError(TEXT("HookRemove: No hooks found for event"));
		return;
	}
	
	for (int32 i = HookList->Num() - 1; i >= 0; i--)
	{
		if ((*HookList)[i].Identifier == Identifier)
		{
			const FHookEntry& Entry = (*HookList)[i];
			if (Entry.LuaFunction.Type == ELuaValueType::Function &&
				Entry.LuaFunction.LuaRef != LUA_NOREF &&
				Entry.LuaFunction.LuaRef != LUA_REFNIL)
			{
				luaL_unref(L, LUA_REGISTRYINDEX, Entry.LuaFunction.LuaRef);
			}

			HookList->RemoveAt(i);
			ReceiveLuaError(TEXT("Hook removed"));
			return;
		}
	}

	ReceiveLuaError(TEXT("HookRemove: Hook not found"));
}

TArray<FLuaValue> UBarrelLuaState::HookCall(const FString& EventName, const TArray<FLuaValue>& Arguments)
{
    // Return empty array if no state
    if (!L) return {};

    const TArray<FHookEntry>* HookList = HookRegistry.Find(EventName);
    if (!HookList) return {};

    // This will hold the results of the *last* valid hook execution
    TArray<FLuaValue> LastReturnValues;

    for (const FHookEntry& Hook : *HookList)
    {
        if (!Hook.bValid || Hook.LuaFunction.Type != ELuaValueType::Function ||
            Hook.LuaFunction.LuaRef == LUA_NOREF || Hook.LuaFunction.LuaRef == LUA_REFNIL)
        {
            continue;
        }

        // Record the stack position before we push the function
        int32 StackTop = lua_gettop(L);

        lua_rawgeti(L, LUA_REGISTRYINDEX, Hook.LuaFunction.LuaRef);

        if (!lua_isfunction(L, -1))
        {
            // Error handling...
            lua_settop(L, StackTop);
            continue;
        }

        // Push arguments
        for (const FLuaValue& Arg : Arguments)
        {
            PushLuaValue(Arg);
        }

        // 2. Change '1' to LUA_MULTRET to allow multiple returns
        int32 Result = lua_pcall(L, Arguments.Num(), LUA_MULTRET, 0);
        
        if (Result != LUA_OK)
        {
            const char* Error = lua_tostring(L, -1);
            UE_LOG(LogTemp, Error, TEXT("Lua hook error in %s: %s"), *Hook.Identifier,
                Error ? UTF8_TO_TCHAR(Error) : TEXT("Unknown error"));
            
            lua_settop(L, StackTop);
            continue;
        }

        // 3. Calculate how many values were returned
        // The new top minus the old top equals the number of return values
        int32 CurrentTop = lua_gettop(L);
        int32 NumReturns = CurrentTop - StackTop;

        // Clear results from previous hooks (if any) to match original behavior
        LastReturnValues.Reset();

        if (NumReturns > 0)
        {
            LastReturnValues.Reserve(NumReturns);

            // Pop values off the stack.
            // IMPORTANT: The stack is LIFO (Last In, First Out).
            // If Lua returns "A, B", B is at the top. Pop gives us B, then A.
            for (int32 i = 0; i < NumReturns; i++)
            {
                LastReturnValues.Add(PopLuaValue());
            }

            // Reverse the array so the order matches Lua (A, B)
            Algo::Reverse(LastReturnValues);
        }

        // Ensure stack is clean (though the pops above should have cleared it)
        lua_settop(L, StackTop); 
    }

    return LastReturnValues;
}


void UBarrelLuaState::PushLuaValue(const FLuaValue& Value)
{
	switch (Value.Type)
	{
	case ELuaValueType::Nil:
		lua_pushnil(L);
		break;

	case ELuaValueType::Bool:
		lua_pushboolean(L, Value.Bool ? 1 : 0);
		break;

	case ELuaValueType::Integer:
		lua_pushinteger(L, Value.Integer);
		break;

	case ELuaValueType::Number:
		lua_pushnumber(L, Value.Number);
		break;

	case ELuaValueType::String:
		lua_pushstring(L, TCHAR_TO_UTF8(*Value.String));
		break;

	case ELuaValueType::Function:
		// Fix: Use LuaRef instead of Integer for functions
		if (Value.LuaRef != LUA_NOREF && Value.LuaRef != LUA_REFNIL)
		{
			lua_rawgeti(L, LUA_REGISTRYINDEX, Value.LuaRef);
		}
		else
		{
			lua_pushnil(L);
		}
		break;

	case ELuaValueType::Table:
		// Fix: Use LuaRef instead of Integer for tables  
		if (Value.LuaRef != LUA_NOREF && Value.LuaRef != LUA_REFNIL)
		{
			lua_rawgeti(L, LUA_REGISTRYINDEX, Value.LuaRef);
		}
		else
		{
			lua_pushnil(L);
		}
		break;

	case ELuaValueType::UObject:
		// Create a copy since FromLuaValue expects non-const reference
		{
			FLuaValue ValueCopy = Value;
			FromLuaValue(ValueCopy, nullptr, L);
		}
	break;

	default:
		lua_pushnil(L);
		break;
	}
}

FLuaValue UBarrelLuaState::PopLuaValue()
{
	if (lua_gettop(L) == 0)
	{
		return FLuaValue(); // Nil
	}

	FLuaValue Result;
	int32 Type = lua_type(L, -1);

	switch (Type)
	{
	case LUA_TNIL:
		Result = FLuaValue();
		break;

	case LUA_TBOOLEAN:
		Result = FLuaValue(lua_toboolean(L, -1) != 0);
		break;

	case LUA_TNUMBER:
		if (lua_isinteger(L, -1))
		{
			Result = FLuaValue((int32)lua_tointeger(L, -1));
		}
		else
		{
			Result = FLuaValue((float)lua_tonumber(L, -1));
		}
		break;

	case LUA_TSTRING:
	{
		const char* Str = lua_tostring(L, -1);
		Result = FLuaValue(FString(UTF8_TO_TCHAR(Str)));
		break;
	}

	case LUA_TFUNCTION:
	{
		// Store function in registry and return reference
		int32 Ref = luaL_ref(L, LUA_REGISTRYINDEX);
		Result = FLuaValue();
		Result.Type = ELuaValueType::Function;
		Result.LuaRef = Ref;  // Fix: Use LuaRef instead of Integer
		Result.LuaState = this;  // Set the state reference
		return Result; // Don't pop, luaL_ref already did
	}

	case LUA_TTABLE:
	{
		// Store table in registry and return reference
		int32 Ref = luaL_ref(L, LUA_REGISTRYINDEX);
		Result = FLuaValue();
		Result.Type = ELuaValueType::Table;
		Result.LuaRef = Ref;  // Fix: Use LuaRef instead of Integer
		Result.LuaState = this;  // Set the state reference
		return Result; // Don't pop, luaL_ref already did
	}

	case LUA_TUSERDATA:
	case LUA_TLIGHTUSERDATA:
	{
		void* UserData = lua_touserdata(L, -1);
		Result = FLuaValue(static_cast<UObject*>(UserData));
		break;
	}

	default:
		Result = FLuaValue(); // Nil for unknown types
		break;
	}

	lua_pop(L, 1);
	return Result;
}

void UBarrelLuaState::CleanupInvalidHooks(const FString& EventName)
{
	TArray<FHookEntry>* HookList = HookRegistry.Find(EventName);
	if (!HookList)
		return;

	// Remove invalid hooks
	for (int32 i = HookList->Num() - 1; i >= 0; i--)
	{
		const FHookEntry& Hook = (*HookList)[i];
		if (!Hook.bValid || Hook.LuaFunction.LuaRef == LUA_NOREF || Hook.LuaFunction.LuaRef == LUA_REFNIL)
		{
			// Release the Lua reference before removing
			if (Hook.LuaFunction.Type == ELuaValueType::Function &&
				Hook.LuaFunction.LuaRef != LUA_NOREF &&
				Hook.LuaFunction.LuaRef != LUA_REFNIL)
			{
				luaL_unref(L, LUA_REGISTRYINDEX, Hook.LuaFunction.LuaRef);
			}

			HookList->RemoveAt(i);
		}
	}
}