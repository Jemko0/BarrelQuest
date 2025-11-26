---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraBoundParameter
---Niagara Bound Parameter
---
--- Properties
---
---@field Parameter NiagaraVariableBase
---@field SrcOffset integer
---@field DestOffset integer
local NiagaraBoundParameter = {}

--- Constructor
---@return NiagaraBoundParameter
---@param Parameter NiagaraVariableBase
---@param SrcOffset integer
---@param DestOffset integer
function NiagaraBoundParameter.new(Parameter, SrcOffset, DestOffset)
    local self = {}
    self.Parameter = Parameter
    self.SrcOffset = SrcOffset
    self.DestOffset = DestOffset
    return self
end

return NiagaraBoundParameter
