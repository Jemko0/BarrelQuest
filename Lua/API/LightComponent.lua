---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class LightComponent : LightComponentBase
---Light Component
---
--- Properties
---
---Color temperature in Kelvin of the blackbody illuminant.
---White (D65) is 6500K.
---@field Temperature number
---@field MaxDrawDistance number
---@field MaxDistanceFadeRange number
---false: use white (D65) as illuminant.
---@field bUseTemperature boolean
---Legacy shadowmap channel from the lighting build, now stored in FLightComponentMapBuildData.
---@field ShadowMapChannel integer
---Transient shadowmap channel used to preview the results of stationary light shadowmap packing.
---@field PreviewShadowMapChannel integer
---Min roughness effective for this light. Used for softening specular highlights.
---@field MinRoughness number
---Multiplier on specular highlights. Use only with great care! Any value besides 1 is not physical!
---Can be used to artistically remove highlights mimicking polarizing filters or photo touch up.
---@field SpecularScale number
---Multiplier on diffuse lighting. Use only with great care! Any value besides 1 is not physical!
---@field DiffuseScale number
---Scales the resolution of shadowmaps used to shadow this light.  By default shadowmap resolution is chosen based on screen size of the caster.
---Setting the scale to zero disables shadow maps, but does not disable, e.g., contact shadows.
---Note: shadowmap resolution is still clamped by 'r.Shadow.MaxResolution'
---@field ShadowResolutionScale number
---Controls how accurate self shadowing of whole scene shadows from this light are.
---At 0, shadows will start at the their caster surface, but there will be many self shadowing artifacts.
---larger values, shadows will start further from their caster, and there won't be self shadowing artifacts but object might appear to fly.
---around 0.5 seems to be a good tradeoff. This also affects the soft transition of shadows
---@field ShadowBias number
---Controls how accurate self shadowing of whole scene shadows from this light are. This works in addition to shadow bias, by increasing the
---amount of bias depending on the slope of a surface.
---At 0, shadows will start at the their caster surface, but there will be many self shadowing artifacts.
---larger values, shadows will start further from their caster, and there won't be self shadowing artifacts but object might appear to fly.
---around 0.5 seems to be a good tradeoff. This also affects the soft transition of shadows
---@field ShadowSlopeBias number
---Amount to sharpen shadow filtering
---@field ShadowSharpen number
---Length of screen space ray trace for sharp contact shadows. Zero is disabled.
---@field ContactShadowLength number
---Where Length of screen space ray trace for sharp contact shadows is in world space units or in screen space units.
---@field ContactShadowLengthInWS boolean
---Intensity of the shadows cast by primitives with "cast contact shadow" enabled. 0 = no shadow, 1 (default) = fully shadowed.
---@field ContactShadowCastingIntensity number
---Intensity of the shadows cast by primitives with "cast contact shadow" disabled. 0 (default) = no shadow, 1 = fully shadowed.
---@field ContactShadowNonCastingIntensity number
---@field InverseSquaredFalloff boolean
---Whether the light is allowed to cast dynamic shadows from translucency.
---@field CastTranslucentShadows boolean
---Whether the light should only cast shadows from components marked as bCastCinematicShadows.
---This is useful for setting up cinematic Movable spotlights aimed at characters and avoiding the shadow depth rendering costs of the background.
---Note: this only works with dynamic shadow maps, not with static shadowing or Ray Traced Distance Field shadows.
---@field bCastShadowsFromCinematicObjectsOnly boolean
---Enables cached shadows for movable primitives for this light even if r.shadow.cachedshadowscastfrommovableprimitives is 0
---@field bForceCachedShadowsForMovablePrimitives boolean
---Whether to allow this light to use MegaLights, if it is enabled in the project settings or Post Process Volume.
---When disabled, the renderer will no longer use stochastic sampling to solve this light's lighting, and will fall back to other shadowing methods, adding significant GPU cost.
---@field bAllowMegaLights boolean
---Selects which shadowing method should MegaLights use for this light.
---RayTracing - Preferred method, which guarantees fixed MegaLights cost and correct area shadows, but is dependent on the BVH representation quality.
---VirtualShadowMap - Has a significant per light cost, but can cast shadows directly from the Nanite geometry using rasterization.
---@field MegaLightsShadowMethod integer
---Channels that this light should affect.
---These channels only apply to opaque materials, direct lighting, and dynamic lighting and shadowing.
---Lighting channels are only supported on translucent materials using forward shading (i.e. when not using the translucency lighting volume).
---@field LightingChannels LightingChannels
---View / light masking support.  Controls which views this light should affect.
---@field ViewLightingChannels ViewLightingChannels
---The light function material to be applied to this light.
---Note that only non-lightmapped lights (UseDirectLightMap=False) can have a light function.
---Light functions are supported within VolumetricFog, but only for Directional, Point and Spot lights. Rect lights are not supported.
---@field LightFunctionMaterial MaterialInterface
---When clearing the light func, e.g. because the light is made static, this field remembers the last value
---@field StashedLightFunctionMaterial MaterialInterface
---Scales the light function projection.  X and Y scale in the directions perpendicular to the light's direction, Z scales along the light direction.
---@field LightFunctionScale Vector
---IES texture (light profiles from real world measured data)
---@field IESTexture TextureLightProfile
---true: take light brightness from IES profile, false: use the light brightness - the maximum light in one direction is used to define no masking. Use with InverseSquareFalloff. Will be disabled if a valid IES profile texture is not supplied.
---@field bUseIESBrightness boolean
---Global scale for IES brightness contribution. Only available when "Use IES Brightness" is selected, and a valid IES profile texture is set
---@field IESBrightnessScale number
---Distance at which the light function should be completely faded to DisabledBrightness.
---This is useful for hiding aliasing from light functions applied in the distance.
---@field LightFunctionFadeDistance number
---Brightness factor applied to the light when the light function is specified but disabled, for example in scene captures that use SceneCapView_LitNoShadows.
---This should be set to the average brightness of the light function material's emissive input, which should be between 0 and 1.
---@field DisabledBrightness number
---Whether to render light shaft bloom from this light.
---For directional lights, the color around the light direction will be blurred radially and added back to the scene.
---for point lights, the color on pixels closer than the light's SourceRadius will be blurred radially and added back to the scene.
---@field bEnableLightShaftBloom boolean
---Scales the additive color.
---@field BloomScale number
---Scene color must be larger than this to create bloom in the light shafts.
---@field BloomThreshold number
---After exposure is applied, scene color brightness larger than BloomMaxBrightness will be rescaled down to BloomMaxBrightness.
---@field BloomMaxBrightness number
---Multiplies against scene color to create the bloom color.
---@field BloomTint Color
---Whether to use ray traced distance field area shadows.  The project setting bGenerateMeshDistanceFields must be enabled for this to have effect.
---Distance field shadows support area lights so they create soft shadows with sharp contacts.
---They have less aliasing artifacts than standard shadowmaps, but inherit all the limitations of distance field representations (only uniform scale, no deformation).
---These shadows have a low per-object cost (and don't depend on triangle count) so they are effective for distant shadows from a dynamic sun.
---@field bUseRayTracedDistanceFieldShadows boolean
---Controls how large of an offset ray traced shadows have from the receiving surface as the camera gets further away.
---This can be useful to hide self-shadowing artifacts from low resolution distance fields on huge static meshes.
---@field RayStartOffsetDepthScale number
local LightComponent = {}

--- Methods
---Set Volumetric Scattering Intensity
---@param NewIntensity number
---@return nil
function LightComponent.SetVolumetricScatteringIntensity(NewIntensity) end

---Set Use Temperature
---@param bNewValue boolean
---@return nil
function LightComponent.SetUseTemperature(bNewValue) end

---Set Use Ray Traced Distance Field Shadows
---@param bNewValue boolean
---@return nil
function LightComponent.SetUseRayTracedDistanceFieldShadows(bNewValue) end

---Set Use IESBrightness
---@param bNewValue boolean
---@return nil
function LightComponent.SetUseIESBrightness(bNewValue) end

---Set Transmission
---@param bNewValue boolean
---@return nil
function LightComponent.SetTransmission(bNewValue) end

---Set Temperature
---@param NewTemperature number
---@return nil
function LightComponent.SetTemperature(NewTemperature) end

---Set Specular Scale
---@param NewValue number
---@return nil
function LightComponent.SetSpecularScale(NewValue) end

---Set Shadow Slope Bias
---@param NewValue number
---@return nil
function LightComponent.SetShadowSlopeBias(NewValue) end

---Set Shadow Bias
---@param NewValue number
---@return nil
function LightComponent.SetShadowBias(NewValue) end

---Set Lighting Channels
---@param bChannel0 boolean
---@param bChannel1 boolean
---@param bChannel2 boolean
---@return nil
function LightComponent.SetLightingChannels(bChannel0, bChannel1, bChannel2) end

---Set Light Function Scale
---@param NewLightFunctionScale Vector
---@return nil
function LightComponent.SetLightFunctionScale(NewLightFunctionScale) end

---Set Light Function Material
---@param NewLightFunctionMaterial MaterialInterface
---@return nil
function LightComponent.SetLightFunctionMaterial(NewLightFunctionMaterial) end

---Set Light Function Fade Distance
---@param NewLightFunctionFadeDistance number
---@return nil
function LightComponent.SetLightFunctionFadeDistance(NewLightFunctionFadeDistance) end

---Set Light Function Disabled Brightness
---@param NewValue number
---@return nil
function LightComponent.SetLightFunctionDisabledBrightness(NewValue) end

---Set color of the light
---@param NewLightColor LinearColor
---@param bSRGB boolean
---@return nil
function LightComponent.SetLightColor(NewLightColor, bSRGB) end

---Set intensity of the light
---@param NewIntensity number
---@return nil
function LightComponent.SetIntensity(NewIntensity) end

---Set Indirect Lighting Intensity
---@param NewIntensity number
---@return nil
function LightComponent.SetIndirectLightingIntensity(NewIntensity) end

---Set IESTexture
---@param NewValue TextureLightProfile
---@return nil
function LightComponent.SetIESTexture(NewValue) end

---Set IESBrightness Scale
---@param NewValue number
---@return nil
function LightComponent.SetIESBrightnessScale(NewValue) end

---Set Force Cached Shadows for Movable Primitives
---@param bNewValue boolean
---@return nil
function LightComponent.SetForceCachedShadowsForMovablePrimitives(bNewValue) end

---Set Enable Light Shaft Bloom
---@param bNewValue boolean
---@return nil
function LightComponent.SetEnableLightShaftBloom(bNewValue) end

---Set Diffuse Scale
---@param NewValue number
---@return nil
function LightComponent.SetDiffuseScale(NewValue) end

---Set Bloom Tint
---@param NewValue Color
---@return nil
function LightComponent.SetBloomTint(NewValue) end

---Set Bloom Threshold
---@param NewValue number
---@return nil
function LightComponent.SetBloomThreshold(NewValue) end

---Set Bloom Scale
---@param NewValue number
---@return nil
function LightComponent.SetBloomScale(NewValue) end

---Set Bloom Max Brightness
---@param NewValue number
---@return nil
function LightComponent.SetBloomMaxBrightness(NewValue) end

---Set Affect Translucent Lighting
---@param bNewValue boolean
---@return nil
function LightComponent.SetAffectTranslucentLighting(bNewValue) end

return LightComponent
