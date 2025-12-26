---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class ParticleEmitter
---Particle Emitter
---
--- Properties
---
---The name of the emitter.
---@field EmitterName string
---@field SubUVDataOffset integer
---How to render the emitter particles. Can be one of the following:
---        ERM_Normal      - As the intended sprite/mesh
---        ERM_Point       - As a 2x2 pixel block with no scaling and the color set in EmitterEditorColor
---        ERM_Cross       - As a cross of lines, scaled to the size of the particle in EmitterEditorColor
---        ERM_None        - Do not render
---@field EmitterRenderMode integer
---The significance level required of this emitter's owner for this emitter to be active.
---@field SignificanceLevel EParticleSignificanceLevel
---If true, maintains some legacy spawning behavior.
---@field bUseLegacySpawningBehavior boolean
---@field ConvertedModules boolean
---If true, then show only this emitter in the editor
---@field bIsSoloing boolean
---If true, then this emitter was 'cooked out' by the cooker.
---This means it was completely disabled, but to preserve any
---indexing schemes, it is left in place.
---@field bCookedOut boolean
---When true, if the current LOD is disabled the emitter will be kept alive. Otherwise, the emitter will be considered complete if the current LOD is disabled.
---@field bDisabledLODsKeepEmitterAlive boolean
---When true, emitters deemed insignificant will have their tick and render disabled Instantly. When false they will simple stop spawning new particles.
---@field bDisableWhenInsignficant boolean
---This value indicates the emitter should be drawn 'collapsed' in Cascade
---@field bCollapsed boolean
---The color of the emitter in the curve editor and debug rendering modes.
---@field EmitterEditorColor Color
---'Private' data - not required by the editor
---@field LODLevels ParticleLODLevel[]
---@field PeakActiveParticles integer
---Initial allocation count - overrides calculated peak count if > 0
---@field InitialAllocationCount integer
---@field QualityLevelSpawnRateScale number
---Detail mode: Set flags reflecting which system detail mode you want the emitter to be ticked and rendered in
---@field DetailModeBitmask integer
---@field DetailModeDisplay string
local ParticleEmitter = {}

--- Methods
return ParticleEmitter
