---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class DirectionalLightComponent : LightComponent
---A light component that has parallel rays. Will provide a uniform lighting across any affected surface (eg. The Sun). This will affect all objects in the defined light-mass importance volume.
---
--- Properties
---
---Controls the depth bias scaling across cascades. This allows to mitigage the shadow acne difference on shadow cascades transition.
---A value of 1 scales shadow bias based on each cascade size (Default).
---A value of 0 scales shadow bias uniformly accross all cacascade.
---@field ShadowCascadeBiasDistribution number
---Whether to occlude fog and atmosphere inscattering with screenspace blurred occlusion from this light.
---@field bEnableLightShaftOcclusion boolean
---Controls how dark the occlusion masking is, a value of 1 results in no darkening term.
---@field OcclusionMaskDarkness number
---Everything closer to the camera than this distance will occlude light shafts.
---@field OcclusionDepthRange number
---Can be used to make light shafts come from somewhere other than the light's actual direction.
---This will only be used when non-zero.  It does not have to be normalized.
---@field LightShaftOverrideDirection Vector
---@field WholeSceneDynamicShadowRadius number
---How far Cascaded Shadow Map dynamic shadows will cover for a movable light, measured from the camera.
---A value of 0 disables the dynamic shadow.
---@field DynamicShadowDistanceMovableLight number
---How far Cascaded Shadow Map dynamic shadows will cover for a stationary light, measured from the camera.
---A value of 0 disables the dynamic shadow.
---@field DynamicShadowDistanceStationaryLight number
---Number of cascades to split the view frustum into for the whole scene dynamic shadow.
---More cascades result in better shadow resolution, but adds significant rendering cost.
---@field DynamicShadowCascades integer
---Controls whether the cascades are distributed closer to the camera (larger exponent) or further from the camera (smaller exponent).
---An exponent of 1 means that cascade transitions will happen at a distance proportional to their resolution.
---@field CascadeDistributionExponent number
---Proportion of the fade region between cascades.
---Pixels within the fade region of two cascades have their shadows blended to avoid hard transitions between quality levels.
---A value of zero eliminates the fade region, creating hard transitions.
---Higher values increase the size of the fade region, creating a more gradual transition between cascades.
---The value is expressed as a percentage proportion (i.e. 0.1 = 10% overlap).
---Ideal values are the smallest possible which still hide the transition.
---An increased fade region size causes an increase in shadow rendering cost.
---@field CascadeTransitionFraction number
---Controls the size of the fade out region at the far extent of the dynamic shadow's influence.
---This is specified as a fraction of DynamicShadowDistance.
---@field ShadowDistanceFadeoutFraction number
---Stationary lights only: Whether to use per-object inset shadows for movable components, even though cascaded shadow maps are enabled.
---This allows dynamic objects to have a shadow even when they are outside of the cascaded shadow map, which is important when DynamicShadowDistanceStationaryLight is small.
---If DynamicShadowDistanceStationaryLight is large (currently > 8000), this will be forced off.
---Disabling this can reduce shadowing cost significantly with many movable objects.
---@field bUseInsetShadowsForMovableObjects boolean
---0: no Far Shadow Cascades, otherwise the number of cascades between DynamicShadowDistance and FarShadowDistance that are covered by Far Shadow Cascades.
---@field FarShadowCascadeCount integer
---Distance at which the far shadow cascade should end.  Far shadows will cover the range between 'Dynamic Shadow Distance' and this distance.
---@field FarShadowDistance number
---Distance at which the ray traced shadow cascade should end.  Distance field shadows will cover the range between 'Dynamic Shadow Distance' this distance.
---@field DistanceFieldShadowDistance number
---Forward lighting priority for the single directional light that will be used for forward shading, translucent, single layer water and volumetric fog.
---When two lights have equal priorities, the selection will be based on their overall brightness as a fallback.
---@field ForwardShadingPriority integer
---Angle subtended by light source in degrees (also known as angular diameter).
---Defaults to 0.5357 which is the angle for our sun.
---@field LightSourceAngle number
---Angle subtended by soft light source in degrees.
---@field LightSourceSoftAngle number
---Shadow source angle factor, relative to the light source angle.
---Defaults to 1.0 to coincide with light source angle.
---@field ShadowSourceAngleFactor number
---Determines how far shadows can be cast, in world units.  Larger values increase the shadowing cost.
---@field TraceDistance number
---@field bUsedAsAtmosphereSunLight boolean
---Whether the directional light can interact with the atmosphere, cloud and generate a visual disk. All of which compose the visual sky.
---@field bAtmosphereSunLight boolean
---Two atmosphere lights are supported. For instance: a sun and a moon, or two suns.
---@field AtmosphereSunLightIndex integer
---A color multiplied with the sun disk luminance.
---@field AtmosphereSunDiskColorScale LinearColor
---Whether to apply atmosphere transmittance per pixel on opaque meshes, instead of using the light global transmittance. Note: VolumetricCloud per pixel transmittance option is selectable on the VolumetricCloud component itself.
---@field bPerPixelAtmosphereTransmittance boolean
---Whether the light should cast any shadows from opaque meshes onto clouds. This is disabled when 'Atmosphere Sun Light Index' is set to 1.
---@field bCastShadowsOnClouds boolean
---Whether the light should cast any shadows from opaque meshes onto the atmosphere.
---@field bCastShadowsOnAtmosphere boolean
---Whether the light should cast any shadows from clouds onto the atmosphere and other scene elements.
---@field bCastCloudShadows boolean
---The overall strength of the cloud shadow, higher value will block more light.
---@field CloudShadowStrength number
---The strength of the shadow on atmosphere. Disabled when 0.
---@field CloudShadowOnAtmosphereStrength number
---The strength of the shadow on opaque and transparent meshes. Disabled when 0.
---@field CloudShadowOnSurfaceStrength number
---The bias applied to the shadow front depth of the volumetric cloud shadow map.
---@field CloudShadowDepthBias number
---The world space radius of the cloud shadow map around the camera in kilometers.
---@field CloudShadowExtent number
---Scale the cloud shadow map resolution, base resolution is 512. The resolution is still clamped to 'r.VolumetricCloud.ShadowMap.MaxResolution'.
---@field CloudShadowMapResolutionScale number
---Scale the shadow map tracing sample count.
---The sample count resolution is still clamped according to scalability setting to 'r.VolumetricCloud.ShadowMap.RaySampleMaxCount'.
---@field CloudShadowRaySampleCountScale number
---Scales the lights contribution when scattered in cloud participating media. This can help counter balance the fact that our multiple scattering solution is only an approximation.
---@field CloudScatteredLuminanceScale LinearColor
---The Lightmass settings for this object.
---@field LightmassSettings LightmassDirectionalLightSettings
---Whether the light should cast modulated shadows from dynamic objects (mobile only).  Also requires Cast Shadows to be set to True.
---@field bCastModulatedShadows boolean
---Color to modulate against the scene color when rendering modulated shadows. (mobile only)
---@field ModulatedShadowColor Color
---Control the amount of shadow occlusion. A value of 0 means no occlusion, thus no shadow.
---@field ShadowAmount number
local DirectionalLightComponent = {}

--- Methods
---Set Shadow Source Angle Factor
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetShadowSourceAngleFactor(NewValue) end

---Set Shadow Distance Fadeout Fraction
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetShadowDistanceFadeoutFraction(NewValue) end

---Set Shadow Cascade Bias Distribution
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetShadowCascadeBiasDistribution(NewValue) end

---Set Shadow Amount
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetShadowAmount(NewValue) end

---Set Occlusion Mask Darkness
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetOcclusionMaskDarkness(NewValue) end

---Set Occlusion Depth Range
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetOcclusionDepthRange(NewValue) end

---Set Light Source Soft Angle
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetLightSourceSoftAngle(NewValue) end

---Set Light Source Angle
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetLightSourceAngle(NewValue) end

---Set Light Shaft Override Direction
---@param NewValue Vector
---@return nil
function DirectionalLightComponent.SetLightShaftOverrideDirection(NewValue) end

---Set Forward Shading Priority
---@param NewValue integer
---@return nil
function DirectionalLightComponent.SetForwardShadingPriority(NewValue) end

---Set Enable Light Shaft Occlusion
---@param bNewValue boolean
---@return nil
function DirectionalLightComponent.SetEnableLightShaftOcclusion(bNewValue) end

---Set Dynamic Shadow Distance Stationary Light
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetDynamicShadowDistanceStationaryLight(NewValue) end

---Set Dynamic Shadow Distance Movable Light
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetDynamicShadowDistanceMovableLight(NewValue) end

---Set Dynamic Shadow Cascades
---@param NewValue integer
---@return nil
function DirectionalLightComponent.SetDynamicShadowCascades(NewValue) end

---Set Cascade Transition Fraction
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetCascadeTransitionFraction(NewValue) end

---Set Cascade Distribution Exponent
---@param NewValue number
---@return nil
function DirectionalLightComponent.SetCascadeDistributionExponent(NewValue) end

---Set Atmosphere Sun Light Index
---@param NewValue integer
---@return nil
function DirectionalLightComponent.SetAtmosphereSunLightIndex(NewValue) end

---Set Atmosphere Sun Light
---@param bNewValue boolean
---@return nil
function DirectionalLightComponent.SetAtmosphereSunLight(bNewValue) end

---Set Atmosphere Sun Disk Color Scale
---@param NewValue LinearColor
---@return nil
function DirectionalLightComponent.SetAtmosphereSunDiskColorScale(NewValue) end

return DirectionalLightComponent
