---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraSystemScalabilityOverrides
---Container struct for an array of system scalability overrides. Enables details customization and data validation.
---
--- Properties
---@field Overrides NiagaraSystemScalabilityOverride[]
local NiagaraSystemScalabilityOverrides = {}

--- Constructor
---@return NiagaraSystemScalabilityOverrides
---@param Overrides NiagaraSystemScalabilityOverride[]
function NiagaraSystemScalabilityOverrides.new(Overrides)
    local self = {}
    self.Overrides = Overrides
    return self
end

return NiagaraSystemScalabilityOverrides
