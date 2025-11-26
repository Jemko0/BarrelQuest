---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SkyAtmosphereComponent : SceneComponent
---A component that represents a planet atmosphere material and simulates sky and light scattering within it.
---@see https://docs.unrealengine.com/en-US/Engine/Actors/FogEffects/SkyAtmosphere/index.html
---
--- Properties
---The ground albedo that will tint the atmosphere when the sun light will bounce on it. Only taken into account when MultiScattering>0.0.
---@field TransformMode ESkyAtmosphereTransformMode
---The radius in kilometers from the center of the planet to the ground level.
---@field BottomRadius number
---The ground albedo that will tint the atmosphere when the sun light will bounce on it. Only taken into account when MultiScattering>0.0.
---@field GroundAlbedo Color
---The height of the atmosphere layer above the ground in kilometers.
---@field AtmosphereHeight number
---Factor applied to multiple scattering only (after the sun light has bounced around in the atmosphere at least once).
---Multiple scattering is evaluated using a dual scattering approach.
---A value of 2 is recommended to better represent default atmosphere when r.SkyAtmosphere.MultiScatteringLUT.HighQuality=0.
---@field MultiScatteringFactor number
---Scale the atmosphere tracing sample count. Quality level scalability
---The sample count is still clamped according to scalability setting to 'r.SkyAtmosphere.SampleCountMax' when 'r.SkyAtmosphere.FastSkyLUT' is 0.
---The sample count is still clamped according to scalability setting to 'r.SkyAtmosphere.FastSkyLUT.SampleCountMax' when 'r.SkyAtmosphere.FastSkyLUT' is 1.
---The sample count is still clamped for aerial perspective according to  'r.SkyAtmosphere.AerialPerspectiveLUT.SampleCountMaxPerSlice'.
---@field TraceSampleCountScale number
---Rayleigh scattering coefficient scale.
---@field RayleighScatteringScale number
---The Rayleigh scattering coefficients resulting from molecules in the air at an altitude of 0 kilometer.
---@field RayleighScattering LinearColor
---The altitude in kilometer at which Rayleigh scattering effect is reduced to 40%.
---@field RayleighExponentialDistribution number
---Mie scattering coefficient scale.
---@field MieScatteringScale number
---The Mie scattering coefficients resulting from particles in the air at an altitude of 0 kilometer. As it becomes higher, light will be scattered more.
---@field MieScattering LinearColor
---Mie absorption coefficient scale.
---@field MieAbsorptionScale number
---The Mie absorption coefficients resulting from particles in the air at an altitude of 0 kilometer. As it becomes higher, light will be absorbed more.
---@field MieAbsorption LinearColor
---A value of 0 mean light is uniformly scattered. A value closer to 1 means lights will scatter more forward, resulting in halos around light sources.
---@field MieAnisotropy number
---The altitude in kilometer at which Mie effects are reduced to 40%.
---@field MieExponentialDistribution number
---Absorption coefficients for another atmosphere layer. Density increase from 0 to 1 between 10 to 25km and decreases from 1 to 0 between 25 to 40km. This approximates ozone molecules distribution in the Earth atmosphere.
---@field OtherAbsorptionScale number
---Absorption coefficients for another atmosphere layer. Density increase from 0 to 1 between 10 to 25km and decreases from 1 to 0 between 25 to 40km. The default values represents ozone molecules absorption in the Earth atmosphere.
---@field OtherAbsorption LinearColor
---Represents the altitude based tent distribution of absorption particles in the atmosphere.
---@field OtherTentDistribution TentDistribution
---Scales the luminance of pixels representing the sky. This will impact the captured sky light.
---@field SkyLuminanceFactor LinearColor
---Scales the luminance of pixels representing the sky and the aerial perspective. This will impact the captured sky light.
---@field SkyAndAerialPerspectiveLuminanceFactor LinearColor
---Makes the aerial perspective look thicker by scaling distances from view to surfaces (opaque and translucent).
---@field AerialPespectiveViewDistanceScale number
---Scale the sky and atmosphere lights contribution to the height fog when SupportSkyAtmosphereAffectsHeightFog project setting is true.
---@field HeightFogContribution number
---The minimum elevation angle in degree that should be used to evaluate the sun transmittance to the ground. Useful to maintain a visible sun light and shadow on meshes even when the sun has started going below the horizon. This does not affect the aerial perspective.
---@field TransmittanceMinLightElevationAngle number
---The distance (kilometers) at which we start evaluating the aerial perspective. Having the aerial perspective starts away from the camera can help with performance: pixels not affected by the aerial perspective will have their computation skipped using early depth test.
---@field AerialPerspectiveStartDepth number
---If this is True, this primitive will render black with an alpha of 0, but all secondary effects (shadows, reflections, indirect lighting) remain. This feature requires activating the project setting(s) "Alpha Output", and "Support Primitive Alpha Holdout" if using the deferred renderer.
---@field bHoldout boolean
---If true, this component will be rendered in the main pass (basepass, transparency)
---@field bRenderInMainPass boolean
local SkyAtmosphereComponent = {}

--- Methods
---Set Transmittance Min Light Elevation Angle
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetTransmittanceMinLightElevationAngle(NewValue) end

---Set Sky Luminance Factor
---@param NewValue LinearColor
---@return nil
function SkyAtmosphereComponent.SetSkyLuminanceFactor(NewValue) end

---Set Sky and Aerial Perspective Luminance Factor
---@param NewValue LinearColor
---@return nil
function SkyAtmosphereComponent.SetSkyAndAerialPerspectiveLuminanceFactor(NewValue) end

---Set Render in Main Pass
---@param bValue boolean
---@return nil
function SkyAtmosphereComponent.SetRenderInMainPass(bValue) end

---Set Rayleigh Scattering Scale
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetRayleighScatteringScale(NewValue) end

---Set Rayleigh Scattering
---@param NewValue LinearColor
---@return nil
function SkyAtmosphereComponent.SetRayleighScattering(NewValue) end

---Set Rayleigh Exponential Distribution
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetRayleighExponentialDistribution(NewValue) end

---Set Other Absorption Scale
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetOtherAbsorptionScale(NewValue) end

---Set Other Absorption
---@param NewValue LinearColor
---@return nil
function SkyAtmosphereComponent.SetOtherAbsorption(NewValue) end

---Set Multi Scattering Factor
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetMultiScatteringFactor(NewValue) end

---Set Mie Scattering Scale
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetMieScatteringScale(NewValue) end

---Set Mie Scattering
---@param NewValue LinearColor
---@return nil
function SkyAtmosphereComponent.SetMieScattering(NewValue) end

---Set Mie Exponential Distribution
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetMieExponentialDistribution(NewValue) end

---Set Mie Anisotropy
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetMieAnisotropy(NewValue) end

---Set Mie Absorption Scale
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetMieAbsorptionScale(NewValue) end

---Set Mie Absorption
---@param NewValue LinearColor
---@return nil
function SkyAtmosphereComponent.SetMieAbsorption(NewValue) end

---Set Holdout
---@param bNewHoldout boolean
---@return nil
function SkyAtmosphereComponent.SetHoldout(bNewHoldout) end

---Set Height Fog Contribution
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetHeightFogContribution(NewValue) end

---Set Ground Albedo
---@return nil
function SkyAtmosphereComponent.SetGroundAlbedo() end

---Set Bottom Radius
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetBottomRadius(NewValue) end

---Set Atmosphere Height
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetAtmosphereHeight(NewValue) end

---Set Aerial Pespective View Distance Scale
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetAerialPespectiveViewDistanceScale(NewValue) end

---Set Aerial Perspective Start Depth
---@param NewValue number
---@return nil
function SkyAtmosphereComponent.SetAerialPerspectiveStartDepth(NewValue) end

---Reset Atmosphere Light Direction Override
---@param AtmosphereLightIndex integer
---@return nil
function SkyAtmosphereComponent.ResetAtmosphereLightDirectionOverride(AtmosphereLightIndex) end

---Override Atmosphere Light Direction
---@param AtmosphereLightIndex integer
---@return nil
function SkyAtmosphereComponent.OverrideAtmosphereLightDirection(AtmosphereLightIndex) end

---Is Atmosphere Light Direction Overriden
---@param AtmosphereLightIndex integer
---@return boolean
function SkyAtmosphereComponent.IsAtmosphereLightDirectionOverriden(AtmosphereLightIndex) end

---Get Overriden Atmosphere Light Direction
---@param AtmosphereLightIndex integer
---@return Vector
function SkyAtmosphereComponent.GetOverridenAtmosphereLightDirection(AtmosphereLightIndex) end

---This function can be used for instance in order to evaluate a directional atmospheric light outer space illuminance for a desired illuminance on ground given a direction.
---This is given for the position at the top of the virtual planet. Plus the output outer space illuminance into the light intensity.
---@param LightDirection Vector
---@param IlluminanceOnGround number
---@return number
function SkyAtmosphereComponent.GetAtmosphericLightToMatchIlluminanceOnGround(LightDirection, IlluminanceOnGround) end

---Get Atmosphere Transmitance on Ground at Planet Top
---@param DirectionalLight DirectionalLightComponent
---@return LinearColor
function SkyAtmosphereComponent.GetAtmosphereTransmitanceOnGroundAtPlanetTop(DirectionalLight) end

return SkyAtmosphereComponent
