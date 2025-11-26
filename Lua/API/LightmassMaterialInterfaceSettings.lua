---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

--- Constructor
---@return LightmassMaterialInterfaceSettings
---@param EmissiveBoost number
---@param DiffuseBoost number
---@param ExportResolutionScale number
---@param bCastShadowAsMasked boolean
---@param bOverrideCastShadowAsMasked boolean
---@param bOverrideEmissiveBoost boolean
---@param bOverrideDiffuseBoost boolean
---@param bOverrideExportResolutionScale boolean
function LightmassMaterialInterfaceSettings.new(EmissiveBoost, DiffuseBoost, ExportResolutionScale, bCastShadowAsMasked, bOverrideCastShadowAsMasked, bOverrideEmissiveBoost, bOverrideDiffuseBoost, bOverrideExportResolutionScale)
    local self = {}
    self.EmissiveBoost = EmissiveBoost
    self.DiffuseBoost = DiffuseBoost
    self.ExportResolutionScale = ExportResolutionScale
    self.bCastShadowAsMasked = bCastShadowAsMasked
    self.bOverrideCastShadowAsMasked = bOverrideCastShadowAsMasked
    self.bOverrideEmissiveBoost = bOverrideEmissiveBoost
    self.bOverrideDiffuseBoost = bOverrideDiffuseBoost
    self.bOverrideExportResolutionScale = bOverrideExportResolutionScale
    return self
end

return LightmassMaterialInterfaceSettings
