---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class LightmassPointLightSettings
---Point/spot settings for Lightmass
---
--- Properties
---
---0 will be completely desaturated, 1 will be unchanged
---@field IndirectLightingSaturation number
---Controls the falloff of shadow penumbras
---@field ShadowExponent number
---Whether to use area shadows for stationary light precomputed shadowmaps.
---Area shadows get softer the further they are from shadow casters, but require higher lightmap resolution to get the same quality where the shadow is sharp.
---@field bUseAreaShadowsForStationaryLight boolean
local LightmassPointLightSettings = {}

--- Constructor
---@return LightmassPointLightSettings
---@param IndirectLightingSaturation number
---@param ShadowExponent number
---@param bUseAreaShadowsForStationaryLight boolean
function LightmassPointLightSettings.new(IndirectLightingSaturation, ShadowExponent, bUseAreaShadowsForStationaryLight)
    local self = {}
    self.IndirectLightingSaturation = IndirectLightingSaturation
    self.ShadowExponent = ShadowExponent
    self.bUseAreaShadowsForStationaryLight = bUseAreaShadowsForStationaryLight
    return self
end

return LightmassPointLightSettings
