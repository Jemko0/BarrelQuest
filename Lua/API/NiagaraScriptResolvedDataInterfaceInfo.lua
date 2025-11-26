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

--- Constructor
---@return NiagaraScriptResolvedDataInterfaceInfo
---@param Name string
---@param CompileName string
---@param ResolvedSourceEmitterName string
---@param ResolvedVariable NiagaraVariableBase
---@param ParameterStoreVariable NiagaraVariableBase
---@param bIsInternal boolean
---@param ResolvedDataInterface NiagaraDataInterface
---@param UserPtrIdx integer
function NiagaraScriptResolvedDataInterfaceInfo.new(Name, CompileName, ResolvedSourceEmitterName, ResolvedVariable, ParameterStoreVariable, bIsInternal, ResolvedDataInterface, UserPtrIdx)
    local self = {}
    self.Name = Name
    self.CompileName = CompileName
    self.ResolvedSourceEmitterName = ResolvedSourceEmitterName
    self.ResolvedVariable = ResolvedVariable
    self.ParameterStoreVariable = ParameterStoreVariable
    self.bIsInternal = bIsInternal
    self.ResolvedDataInterface = ResolvedDataInterface
    self.UserPtrIdx = UserPtrIdx
    return self
end

return NiagaraScriptResolvedDataInterfaceInfo
