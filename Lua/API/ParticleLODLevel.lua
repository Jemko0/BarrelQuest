---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ParticleLODLevel
---Particle LODLevel
---
--- Properties
---The index value of the LOD level
---@field Level integer
---True if the LOD level is enabled, meaning it should be updated and rendered.
---@field bEnabled boolean
---The required module for this LOD level
---@field RequiredModule ParticleModuleRequired
---An array of particle modules that contain the adjusted data for the LOD level
---@field Modules ParticleModule[]
---Module<SINGULAR> used for emitter type "extension".
---@field TypeDataModule ParticleModuleTypeDataBase
---The SpawnRate/Burst module - required by all emitters.
---@field SpawnModule ParticleModuleSpawn
---The optional EventGenerator module.
---@field EventGenerator ParticleModuleEventGenerator
---SpawningModules - These are called to determine how many particles to spawn.
---@field SpawningModules ParticleModuleSpawnBase[]
---SpawnModules - These are called when particles are spawned.
---@field SpawnModules ParticleModule[]
---UpdateModules - These are called when particles are updated.
---@field UpdateModules ParticleModule[]
---OrbitModules
---    These are used to do offsets of the sprite from the particle location.
---@field OrbitModules ParticleModuleOrbit[]
---Event receiver modules only!
---@field EventReceiverModules ParticleModuleEventReceiverBase[]
---@field ConvertedModules boolean
---@field PeakActiveParticles integer
local ParticleLODLevel = {}

--- Methods
return ParticleLODLevel
