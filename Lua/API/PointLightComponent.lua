---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PointLightComponent : LocalLightComponent
---A light component which emits light from a single point equally in all directions.
---
--- Properties
---
---Whether to use physically based inverse squared distance falloff, where AttenuationRadius is only clamping the light's contribution.
---Disabling inverse squared falloff can be useful when placing fill lights (don't want a super bright spot near the light).
---When enabled, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb.
---When disabled, the light's Intensity is a brightness scale.
---@field bUseInverseSquaredFalloff boolean
---Controls the radial falloff of the light when UseInverseSquaredFalloff is disabled.
---2 is almost linear and very unrealistic and around 8 it looks reasonable.
---With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents.
---@field LightFalloffExponent number
---Radius of light source shape.
---Note that light sources shapes which intersect shadow casting geometry can cause shadowing artifacts.
---@field SourceRadius number
---Soft radius of light source shape.
---Note that light sources shapes which intersect shadow casting geometry can cause shadowing artifacts.
---@field SoftSourceRadius number
---Length of light source shape.
---Note that light sources shapes which intersect shadow casting geometry can cause shadowing artifacts.
---@field SourceLength number
local PointLightComponent = {}

--- Methods
---Set Use Inverse Squared Falloff
---@param bNewValue boolean
---@return nil
function PointLightComponent.SetUseInverseSquaredFalloff(bNewValue) end

---Set Source Radius
---@param bNewValue number
---@return nil
function PointLightComponent.SetSourceRadius(bNewValue) end

---Set Source Length
---@param NewValue number
---@return nil
function PointLightComponent.SetSourceLength(NewValue) end

---Set Soft Source Radius
---@param bNewValue number
---@return nil
function PointLightComponent.SetSoftSourceRadius(bNewValue) end

---Set Light Falloff Exponent
---@param NewLightFalloffExponent number
---@return nil
function PointLightComponent.SetLightFalloffExponent(NewLightFalloffExponent) end

---Set Inverse Exposure Blend
---@param NewInverseExposureBlend number
---@return nil
function PointLightComponent.SetInverseExposureBlend(NewInverseExposureBlend) end

return PointLightComponent
