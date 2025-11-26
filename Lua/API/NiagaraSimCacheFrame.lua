---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraSimCacheFrame
---Niagara Sim Cache Frame
---
--- Properties
---@field LocalToWorld Transform
---@field LWCTile Vector3f
---@field SimulationAge number
---@field SimulationTickCount integer
---@field SystemData NiagaraSimCacheSystemFrame
---@field EmitterData NiagaraSimCacheEmitterFrame[]
local NiagaraSimCacheFrame = {}

--- Constructor
---@return NiagaraSimCacheFrame
---@param LocalToWorld Transform
---@param LWCTile Vector3f
---@param SimulationAge number
---@param SimulationTickCount integer
---@param SystemData NiagaraSimCacheSystemFrame
---@param EmitterData NiagaraSimCacheEmitterFrame[]
function NiagaraSimCacheFrame.new(LocalToWorld, LWCTile, SimulationAge, SimulationTickCount, SystemData, EmitterData)
    local self = {}
    self.LocalToWorld = LocalToWorld
    self.LWCTile = LWCTile
    self.SimulationAge = SimulationAge
    self.SimulationTickCount = SimulationTickCount
    self.SystemData = SystemData
    self.EmitterData = EmitterData
    return self
end

return NiagaraSimCacheFrame
