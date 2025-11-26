---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraSimCacheLayout
---Niagara Sim Cache Layout
---
--- Properties
---@field SystemLayout NiagaraSimCacheDataBuffersLayout
---@field EmitterLayouts NiagaraSimCacheDataBuffersLayout[]
local NiagaraSimCacheLayout = {}

--- Constructor
---@return NiagaraSimCacheLayout
---@param SystemLayout NiagaraSimCacheDataBuffersLayout
---@param EmitterLayouts NiagaraSimCacheDataBuffersLayout[]
function NiagaraSimCacheLayout.new(SystemLayout, EmitterLayouts)
    local self = {}
    self.SystemLayout = SystemLayout
    self.EmitterLayouts = EmitterLayouts
    return self
end

return NiagaraSimCacheLayout
