---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraResolvedUserDataInterfaceBinding
---Niagara Resolved User Data Interface Binding
---
--- Properties
---@field UserParameterStoreDataInterfaceIndex integer
---@field ScriptParameterStoreDataInterfaceIndex integer
local NiagaraResolvedUserDataInterfaceBinding = {}

--- Constructor
---@return NiagaraResolvedUserDataInterfaceBinding
---@param UserParameterStoreDataInterfaceIndex integer
---@param ScriptParameterStoreDataInterfaceIndex integer
function NiagaraResolvedUserDataInterfaceBinding.new(UserParameterStoreDataInterfaceIndex, ScriptParameterStoreDataInterfaceIndex)
    local self = {}
    self.UserParameterStoreDataInterfaceIndex = UserParameterStoreDataInterfaceIndex
    self.ScriptParameterStoreDataInterfaceIndex = ScriptParameterStoreDataInterfaceIndex
    return self
end

return NiagaraResolvedUserDataInterfaceBinding
