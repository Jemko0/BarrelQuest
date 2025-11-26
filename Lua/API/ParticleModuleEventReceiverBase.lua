---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ParticleModuleEventReceiverBase : ParticleModuleEventBase
---Particle Module Event Receiver Base
---
--- Properties
---The type of event that will generate the kill.
---@field EventGeneratorType integer
---The name of the emitter of interest for generating the event.
---@field EventName string
local ParticleModuleEventReceiverBase = {}

--- Methods
return ParticleModuleEventReceiverBase
