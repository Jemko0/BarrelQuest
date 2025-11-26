---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraResolvedUObjectInfo
---Niagara Resolved UObject Info
---
--- Properties
---
---@field ReadVariableName string
---@field ResolvedVariable NiagaraVariableBase
---@field Object Object
local NiagaraResolvedUObjectInfo = {}

--- Constructor
---@return NiagaraResolvedUObjectInfo
---@param ReadVariableName string
---@param ResolvedVariable NiagaraVariableBase
---@param Object Object
function NiagaraResolvedUObjectInfo.new(ReadVariableName, ResolvedVariable, Object)
    local self = {}
    self.ReadVariableName = ReadVariableName
    self.ResolvedVariable = ResolvedVariable
    self.Object = Object
    return self
end

return NiagaraResolvedUObjectInfo
