---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SkyLightComponent : LightComponentBase
---Sky Light Component
---
--- Properties
---When enabled, the sky will be captured and convolved to achieve dynamic diffuse and specular environment lighting.
---SkyAtmosphere, VolumetricCloud Components as well as sky domes with Sky materials are taken into account.
---@field bRealTimeCapture boolean
---Indicates where to get the light contribution from.
---@field SourceType integer
---Cubemap to use for sky lighting if SourceType is set to SLS_SpecifiedCubemap.
---@field Cubemap TextureCube
---Angle to rotate the source cubemap when SourceType is set to SLS_SpecifiedCubemap.
---@field SourceCubemapAngle number
---Maximum resolution for the very top processed cubemap mip. Must be a power of 2.
---@field CubemapResolution integer
---Distance from the sky light at which any geometry should be treated as part of the sky.
---This is also used by reflection captures, so update reflection captures to see the impact.
---@field SkyDistanceThreshold number
---Only capture emissive materials. Skips all lighting making the capture cheaper. Recomended when using CaptureEveryFrame
---@field bCaptureEmissiveOnly boolean
---Whether all distant lighting from the lower hemisphere should be set to LowerHemisphereColor.
---Enabling this is accurate when lighting a scene on a planet where the ground blocks the sky,
---However disabling it can be useful to approximate skylight bounce lighting (eg Movable light).
---@field bLowerHemisphereIsBlack boolean
---@field LowerHemisphereColor LinearColor
---Max distance that the occlusion of one point will affect another.
---Higher values increase the cost of Distance Field AO exponentially.
---@field OcclusionMaxDistance number
---Contrast S-curve applied to the computed AO.  A value of 0 means no contrast increase, 1 is a significant contrast increase.
---@field Contrast number
---Exponent applied to the computed AO.  Values lower than 1 brighten occlusion overall without losing contact shadows.
---@field OcclusionExponent number
---Controls the darkest that a fully occluded area can get.  This tends to destroy contact shadows, use Contrast or OcclusionExponent instead.
---@field MinOcclusion number
---Tint color on occluded areas, artistic control.
---@field OcclusionTint Color
---Whether the cloud should occlude sky contribution within the atmosphere (progressively fading multiple scattering out) or not.
---@field bCloudAmbientOcclusion boolean
---The strength of the ambient occlusion, higher value will block more light.
---@field CloudAmbientOcclusionStrength number
---The world space radius of the cloud ambient occlusion map around the camera in kilometers.
---@field CloudAmbientOcclusionExtent number
---Scale the cloud ambient occlusion map resolution, base resolution is 512. The resolution is still clamped to 'r.VolumetricCloud.SkyAO.MaxResolution'.
---@field CloudAmbientOcclusionMapResolutionScale number
---Controls the cone aperture angle over which the sky occlusion due to volumetric clouds is evaluated. A value of 1 means `take into account the entire hemisphere` resulting in blurry occlusion, while a value of 0 means `take into account a single up occlusion direction up` resulting in sharp occlusion.
---@field CloudAmbientOcclusionApertureScale number
---Controls how occlusion from Distance Field Ambient Occlusion is combined with Screen Space Ambient Occlusion.
---@field OcclusionCombineMode integer
---@field BlendDestinationCubemap TextureCube
local SkyLightComponent = {}

--- Methods
---Set Volumetric Scattering Intensity
---@param NewIntensity number
---@return nil
function SkyLightComponent.SetVolumetricScatteringIntensity(NewIntensity) end

---Sets the angle of the cubemap used when SourceType is set to SpecifiedCubemap and it is non static. It will cause the skylight to update on the next tick.
---@param NewValue number
---@return nil
function SkyLightComponent.SetSourceCubemapAngle(NewValue) end

---Set Real Time Capture
---@param bInRealTimeCapture boolean
---@return nil
function SkyLightComponent.SetRealTimeCapture(bInRealTimeCapture) end

---Set Occlusion Tint
---@return nil
function SkyLightComponent.SetOcclusionTint() end

---Set Occlusion Exponent
---@param InOcclusionExponent number
---@return nil
function SkyLightComponent.SetOcclusionExponent(InOcclusionExponent) end

---Set Occlusion Contrast
---@param InOcclusionContrast number
---@return nil
function SkyLightComponent.SetOcclusionContrast(InOcclusionContrast) end

---Set Min Occlusion
---@param InMinOcclusion number
---@return nil
function SkyLightComponent.SetMinOcclusion(InMinOcclusion) end

---Set Lower Hemisphere Color
---@return nil
function SkyLightComponent.SetLowerHemisphereColor() end

---Set color of the light
---@param NewLightColor LinearColor
---@return nil
function SkyLightComponent.SetLightColor(NewLightColor) end

---Set Intensity
---@param NewIntensity number
---@return nil
function SkyLightComponent.SetIntensity(NewIntensity) end

---Set Indirect Lighting Intensity
---@param NewIntensity number
---@return nil
function SkyLightComponent.SetIndirectLightingIntensity(NewIntensity) end

---Creates sky lighting from a blend between two cubemaps, which is only valid when SourceType is set to SpecifiedCubemap.
---This can be used to seamlessly transition sky lighting between different times of day.
---The caller should continue to update the blend until BlendFraction is 0 or 1 to reduce rendering cost.
---The caller is responsible for avoiding pops due to changing the source or destination.
---@param SourceCubemap TextureCube
---@param DestinationCubemap TextureCube
---@param InBlendFraction number
---@return nil
function SkyLightComponent.SetCubemapBlend(SourceCubemap, DestinationCubemap, InBlendFraction) end

---Sets the cubemap used when SourceType is set to SpecifiedCubemap, and causes a skylight update on the next tick.
---@param NewCubemap TextureCube
---@return nil
function SkyLightComponent.SetCubemap(NewCubemap) end

---Recaptures the scene for the skylight.
---This is useful for making sure the sky light is up to date after changing something in the world that it would capture.
---Warning: this is very costly and will definitely cause a hitch.
---@return nil
function SkyLightComponent.RecaptureSky() end

return SkyLightComponent
