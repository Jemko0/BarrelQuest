---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ParameterDefinitionsSubscription
---Parameter Definitions Subscription
---
--- Properties
---@field Definitions NiagaraParameterDefinitionsBase
---@field DefinitionsId Guid
---@field CachedChangeIdHash integer
local ParameterDefinitionsSubscription = {}

--- Constructor
---@return ParameterDefinitionsSubscription
---@param Definitions NiagaraParameterDefinitionsBase
---@param DefinitionsId Guid
---@param CachedChangeIdHash integer
function ParameterDefinitionsSubscription.new(Definitions, DefinitionsId, CachedChangeIdHash)
    local self = {}
    self.Definitions = Definitions
    self.DefinitionsId = DefinitionsId
    self.CachedChangeIdHash = CachedChangeIdHash
    return self
end

return ParameterDefinitionsSubscription
