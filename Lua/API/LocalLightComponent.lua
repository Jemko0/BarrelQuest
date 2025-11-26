---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class LocalLightComponent : LightComponent
---A light component which emits light from a single point equally in all directions.
---
--- Properties
---
---Units used for the intensity.
---The peak luminous intensity is measured in candelas, while the luminous flux is measured in lumens.
---When the units are set in Nits, the light's power is also determined by the size of the light source (larger sources will emit more light).
---@field IntensityUnits ELightUnits
---Blend Factor used to blend between Intensity and Intensity/Exposure.
---This is useful for gameplay lights that should have constant brighness on screen independent of current exposure.
---This feature can cause issues with exposure particularly when used on the primary light on a scene, as such it's usage should be limited.
---@field InverseExposureBlend number
---@field Radius number
---Bounds the light's visible influence.
---This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more.
---@field AttenuationRadius number
---The Lightmass settings for this object.
---@field LightmassSettings LightmassPointLightSettings
local LocalLightComponent = {}

--- Methods
---Set the units used for the intensity of the light
---@param NewIntensityUnits ELightUnits
---@return nil
function LocalLightComponent.SetIntensityUnits(NewIntensityUnits) end

---Set Attenuation Radius
---@param NewRadius number
---@return nil
function LocalLightComponent.SetAttenuationRadius(NewRadius) end

---Get Units Conversion Factor
---@param SrcUnits ELightUnits
---@param TargetUnits ELightUnits
---@param CosHalfConeAngle number
---@return number
function LocalLightComponent.GetUnitsConversionFactor(SrcUnits, TargetUnits, CosHalfConeAngle) end

return LocalLightComponent
