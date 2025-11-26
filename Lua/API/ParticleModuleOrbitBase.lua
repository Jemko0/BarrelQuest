---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ParticleModuleOrbitBase : ParticleModule
---Particle Module Orbit Base
---
--- Properties
---
---If true, distribution values will be retrieved using the EmitterTime.
---If false (default), they will be retrieved using the Particle.RelativeTime.
---@field bUseEmitterTime boolean
local ParticleModuleOrbitBase = {}

--- Methods
return ParticleModuleOrbitBase
