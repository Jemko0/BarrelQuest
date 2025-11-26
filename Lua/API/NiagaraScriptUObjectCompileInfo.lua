---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraScriptUObjectCompileInfo
---Niagara Script UObject Compile Info
---
--- Properties
---
---@field Variable NiagaraVariableBase
---@field Object Object
---@field ObjectPath SoftObjectPath
---@field RegisteredParameterMapRead string
---@field RegisteredParameterMapWrites string[]
local NiagaraScriptUObjectCompileInfo = {}

--- Constructor
---@return NiagaraScriptUObjectCompileInfo
---@param Variable NiagaraVariableBase
---@param Object Object
---@param ObjectPath SoftObjectPath
---@param RegisteredParameterMapRead string
---@param RegisteredParameterMapWrites string[]
function NiagaraScriptUObjectCompileInfo.new(Variable, Object, ObjectPath, RegisteredParameterMapRead, RegisteredParameterMapWrites)
    local self = {}
    self.Variable = Variable
    self.Object = Object
    self.ObjectPath = ObjectPath
    self.RegisteredParameterMapRead = RegisteredParameterMapRead
    self.RegisteredParameterMapWrites = RegisteredParameterMapWrites
    return self
end

return NiagaraScriptUObjectCompileInfo
