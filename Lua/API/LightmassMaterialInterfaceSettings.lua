---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class LightmassMaterialInterfaceSettings
---UMaterial interface settings for Lightmass
---
--- Properties
---Scales the emissive contribution of this material to static lighting.
---@field EmissiveBoost number
---Scales the diffuse contribution of this material to static lighting.
---@field DiffuseBoost number
---Scales the resolution that this material's attributes were exported at.
---This is useful for increasing material resolution when details are needed.
---@field ExportResolutionScale number
---If true, forces translucency to cast static shadows as if the material were masked.
---@field bCastShadowAsMasked boolean
---If true, override the bCastShadowAsMasked setting of the parent material.
---@field bOverrideCastShadowAsMasked boolean
---If true, override the emissive boost setting of the parent material.
---@field bOverrideEmissiveBoost boolean
---If true, override the diffuse boost setting of the parent material.
---@field bOverrideDiffuseBoost boolean
---If true, override the export resolution scale setting of the parent material.
---@field bOverrideExportResolutionScale boolean
local LightmassMaterialInterfaceSettings = {}
return LightmassMaterialInterfaceSettings
