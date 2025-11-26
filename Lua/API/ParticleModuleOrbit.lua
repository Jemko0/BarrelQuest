---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ParticleModuleOrbit : ParticleModuleOrbitBase
---Particle Module Orbit
---
--- Properties
---Orbit modules will chain together in the order they appear in the module stack.
---The combination of a module with the one prior to it is defined by using one
---of the following enumerations:
---        EOChainMode_Add         Add the values to the previous results
---        EOChainMode_Scale       Multiply the values by the previous results
---        EOChainMode_Link        'Break' the chain and apply the values from the previous results
---@field ChainMode integer
---The amount to offset the sprite from the particle position.
---@field OffsetAmount RawDistributionVector
---The options associated with the OffsetAmount look-up.
---@field OffsetOptions OrbitOptions
---The amount (in 'turns') to rotate the offset about the particle position.
---        0.0 = no rotation
---        0.5     = 180 degree rotation
---        1.0 = 360 degree rotation
---@field RotationAmount RawDistributionVector
---The options associated with the RotationAmount look-up.
---@field RotationOptions OrbitOptions
---The rate (in 'turns') at which to rotate the offset about the particle positon.
---        0.0 = no rotation
---        0.5     = 180 degree rotation
---        1.0 = 360 degree rotation
---@field RotationRateAmount RawDistributionVector
---The options associated with the RotationRateAmount look-up.
---@field RotationRateOptions OrbitOptions
local ParticleModuleOrbit = {}

--- Methods
return ParticleModuleOrbit
