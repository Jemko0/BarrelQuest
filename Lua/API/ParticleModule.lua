---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ParticleModule
---Particle Module
---
--- Properties
---
---If true, the module performs operations on particles during Spawning
---@field bSpawnModule boolean
---If true, the module performs operations on particles during Updating
---@field bUpdateModule boolean
---If true, the module performs operations on particles during final update
---@field bFinalUpdateModule boolean
---If true, the module performs operations on particles during update and/or final update for GPU emitters
---@field bUpdateForGPUEmitter boolean
---If true, the module displays FVector curves as colors
---@field bCurvesAsColor boolean
---If true, the module should render its 3D visualization helper
---@field b3DDrawMode boolean
---If true, the module supports rendering a 3D visualization helper
---@field bSupported3DDrawMode boolean
---If true, the module is enabled
---@field bEnabled boolean
---If true, the module has had editing enabled on it
---@field bEditable boolean
---If true, this flag indicates that auto-generation for LOD will result in
---an exact duplicate of the module, regardless of the percentage.
---If false, it will result in a module with different settings.
---@field LODDuplicate boolean
---If true, the module supports RandomSeed setting
---@field bSupportsRandomSeed boolean
---If true, the module should be told when looping
---@field bRequiresLoopingNotification boolean
---The LOD levels this module is present in.
---Bit-flags are used to indicate validity for a given LOD level.
---For example, if
---        ((1 << Level) & LODValidity) != 0
---then the module is used in that LOD.
---@field LODValidity integer
---The color to draw the modules curves in the curve editor.
---    If bCurvesAsColor is true, it overrides this value.
---@field ModuleEditorColor Color
local ParticleModule = {}

--- Methods
return ParticleModule
