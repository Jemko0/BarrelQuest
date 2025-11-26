---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraScriptUObjectCompileInfo
---Niagara Script UObject Compile Info
---
--- Properties
---@field Variable NiagaraVariableBase
---@field Object Object
---@field ObjectPath SoftObjectPath
---@field RegisteredParameterMapRead string
---@field RegisteredParameterMapWrites string[]
local NiagaraScriptUObjectCompileInfo = {}
return NiagaraScriptUObjectCompileInfo
