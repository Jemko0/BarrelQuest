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

--- Constructor
---@return BPVariableDescription
---@param VarName string
---@param VarGuid Guid
---@param VarType EdGraphPinType
---@param FriendlyName string
---@param Category string
---@param PropertyFlags integer
---@param RepNotifyFunc string
---@param ReplicationCondition integer
---@param MetaDataArray BPVariableMetaDataEntry[]
---@param DefaultValue string
function BPVariableDescription.new(VarName, VarGuid, VarType, FriendlyName, Category, PropertyFlags, RepNotifyFunc, ReplicationCondition, MetaDataArray, DefaultValue)
    local self = {}
    self.VarName = VarName
    self.VarGuid = VarGuid
    self.VarType = VarType
    self.FriendlyName = FriendlyName
    self.Category = Category
    self.PropertyFlags = PropertyFlags
    self.RepNotifyFunc = RepNotifyFunc
    self.ReplicationCondition = ReplicationCondition
    self.MetaDataArray = MetaDataArray
    self.DefaultValue = DefaultValue
    return self
end

return BPVariableDescription
