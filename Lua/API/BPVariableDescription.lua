---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BPVariableDescription
---Struct indicating a variable in the generated class
---
--- Properties
---Name of the variable
---@field VarName string
---A Guid that will remain constant even if the VarName changes
---@field VarGuid Guid
---Type of the variable
---@field VarType EdGraphPinType
---Friendly name of the variable
---@field FriendlyName string
---Category this variable should be in
---@field Category string
---Property flags for this variable - Changed from int32 to uint64
---@field PropertyFlags integer
---@field RepNotifyFunc string
---@field ReplicationCondition integer
---Metadata information for this variable
---@field MetaDataArray BPVariableMetaDataEntry[]
---Optional new default value stored as string
---@field DefaultValue string
local BPVariableDescription = {}
return BPVariableDescription
