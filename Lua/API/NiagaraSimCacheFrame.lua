---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

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
return NiagaraSimCacheFrame
