---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraScriptResolvedDataInterfaceInfo
---Niagara Script Resolved Data Interface Info
---
--- Properties
---@field Name string
---@field CompileName string
---@field ResolvedSourceEmitterName string
---@field ResolvedVariable NiagaraVariableBase
---@field ParameterStoreVariable NiagaraVariableBase
---@field bIsInternal boolean
---@field ResolvedDataInterface NiagaraDataInterface
---@field UserPtrIdx integer
local NiagaraScriptResolvedDataInterfaceInfo = {}
return NiagaraScriptResolvedDataInterfaceInfo
