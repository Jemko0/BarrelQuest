---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class InstancedStruct
---FInstancedStruct works similarly as instanced UObject* property but is USTRUCTs.
---Example:
---    UPROPERTY(EditAnywhere, Category = Foo, meta = (BaseStruct = "/Script/ModuleName.TestStructBase"))
---    FInstancedStruct Test;
---    UPROPERTY(EditAnywhere, Category = Foo, meta = (BaseStruct = "/Script/ModuleName.TestStructBase"))
---    TArray<FInstancedStruct> TestArray;
---
--- Properties
---
local InstancedStruct = {}

--- Constructor
---@return InstancedStruct
function InstancedStruct.new()
    local self = {}
    return self
end

return InstancedStruct
