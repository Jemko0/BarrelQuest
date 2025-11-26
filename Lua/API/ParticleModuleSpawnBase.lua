---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ParticleModuleSpawnBase : ParticleModule
---Particle Module Spawn Base
---
--- Properties
---
---If true, the SpawnRate of the SpawnModule of the emitter will be processed.
---If mutliple Spawn modules are 'stacked' in an emitter, if ANY of them
---have this set to false, it will not process the SpawnModule SpawnRate.
---@field bProcessSpawnRate boolean
---If true, the BurstList of the SpawnModule of the emitter will be processed.
---If mutliple Spawn modules are 'stacked' in an emitter, if ANY of them
---have this set to false, it will not process the SpawnModule BurstList.
---@field bProcessBurstList boolean
local ParticleModuleSpawnBase = {}

--- Methods
return ParticleModuleSpawnBase
