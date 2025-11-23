---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class LightComponentBase : SceneComponent
---Light Component Base
---
--- Properties
---GUID used to associate a light component with precomputed shadowing information across levels.
---The GUID changes whenever the light position changes.
---@field OriginalLightGuid Guid
---@field LightGuid Guid
---@field Brightness number
---Total energy that the light emits.
---@field Intensity number
---Filter color of the light.
---Note that this can change the light's effective intensity.
---@field LightColor Color
---Whether the light can affect the world, or whether it is disabled.
---A disabled light will not contribute to the scene in any way.  This setting cannot be changed at runtime and unbuilds lighting when changed.
---Setting this to false has the same effect as deleting the light, so it is useful for non-destructive experiments.
---@field bAffectsWorld boolean
---Whether the light should cast any shadows.
---@field CastShadows boolean
---Whether the light should cast shadows from static objects.  Also requires Cast Shadows to be set to True.
---@field CastStaticShadows boolean
---Whether the light should cast shadows from dynamic objects.  Also requires Cast Shadows to be set to True.
---@field CastDynamicShadows boolean
---Whether the light affects translucency or not.  Disabling this can save GPU time when there are many small lights.
---@field bAffectTranslucentLighting boolean
---Whether light from this light transmits through surfaces with subsurface scattering profiles. Requires light to be movable.
---@field bTransmission boolean
---Whether the light shadows volumetric fog.  Disabling this can save GPU time.
---@field bCastVolumetricShadow boolean
---Whether the light should cast high quality hair-strands self-shadowing. When this option is enabled, an extra GPU cost for this light.
---@field bCastDeepShadow boolean
---Whether the light shadows are computed with shadow-mapping or ray-tracing (when available).
---@field bCastRaytracedShadow boolean
---@field CastRaytracedShadow integer
---Whether the light affects objects in reflections, when ray-traced reflection is enabled.
---@field bAffectReflection boolean
---Whether the light affects global illumination, when ray-traced global illumination is enabled.
---@field bAffectGlobalIllumination boolean
---Change the deep shadow layers distribution 0:linear distribution (uniform layer distribution), 1:exponential (more details on near small details).
---@field DeepShadowLayerDistribution number
---Scales the indirect lighting contribution from this light.
---A value of 0 disables any GI from this light. Default is 1.
---@field IndirectLightingIntensity number
---Intensity of the volumetric scattering from this light.  This scales Intensity and LightColor.
---@field VolumetricScatteringIntensity number
---Samples per pixel for ray tracing
---@field SamplesPerPixel integer
---Sprite for static light in the editor.
---@field StaticEditorTexture Texture2D
---Sprite scaling for static light in the editor.
---@field StaticEditorTextureScale number
---Sprite for dynamic light in the editor.
---@field DynamicEditorTexture Texture2D
---Sprite scaling for dynamic light in the editor.
---@field DynamicEditorTextureScale number
local LightComponentBase = {}

--- Methods
---Set Samples Per Pixel
---@param NewValue integer
---@return nil
function LightComponentBase.SetSamplesPerPixel(NewValue) end

---Set Cast Volumetric Shadow
---@param bNewValue boolean
---@return nil
function LightComponentBase.SetCastVolumetricShadow(bNewValue) end

---Sets whether this light casts shadows
---@param bNewValue boolean
---@return nil
function LightComponentBase.SetCastShadows(bNewValue) end

---Set Cast Raytraced Shadows
---@param bNewValue integer
---@return nil
function LightComponentBase.SetCastRaytracedShadows(bNewValue) end

---Set Cast Raytraced Shadow
---@param bNewValue boolean
---@return nil
function LightComponentBase.SetCastRaytracedShadow(bNewValue) end

---Set Cast Deep Shadow
---@param bNewValue boolean
---@return nil
function LightComponentBase.SetCastDeepShadow(bNewValue) end

---Set Affect Reflection
---@param bNewValue boolean
---@return nil
function LightComponentBase.SetAffectReflection(bNewValue) end

---Set Affect Global Illumination
---@param bNewValue boolean
---@return nil
function LightComponentBase.SetAffectGlobalIllumination(bNewValue) end

---Gets the light color as a linear color
---@return LinearColor
function LightComponentBase.GetLightColor() end

return LightComponentBase
