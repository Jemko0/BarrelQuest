---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SubsurfaceProfile
---Subsurface Scattering profile asset, can be specified at the material. Only for "Subsurface Profile" materials, is use during Screenspace Subsurface Scattering
---Don't change at runtime. All properties in here are per material - texture like variations need to come from properties that are in the GBuffer.
---
--- Properties
---@field Settings SubsurfaceProfileStruct
---@field Guid Guid
local SubsurfaceProfile = {}

--- Methods
return SubsurfaceProfile
