---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class LightmassPrimitiveSettings
---Per-object settings for Lightmass
---
--- Properties
---If true, this object will be lit as if it receives light from both sides of its polygons.
---@field bUseTwoSidedLighting boolean
---If true, this object will only shadow indirect lighting.
---@field bShadowIndirectOnly boolean
---If true, allow using the emissive for static lighting.
---@field bUseEmissiveForStaticLighting boolean
---Typically the triangle normal is used for hemisphere gathering which prevents incorrect self-shadowing from artist-tweaked vertex normals.
---However in the case of foliage whose vertex normal has been setup to match the underlying terrain, gathering in the direction of the vertex normal is desired.
---@field bUseVertexNormalForHemisphereGather boolean
---Direct lighting falloff exponent for mesh area lights created from emissive areas on this primitive.
---@field EmissiveLightFalloffExponent number
---Direct lighting influence radius.
---The default is 0, which means the influence radius should be automatically generated based on the emissive light brightness.
---Values greater than 0 override the automatic method.
---@field EmissiveLightExplicitInfluenceRadius number
---Scales the emissive contribution of all materials applied to this object.
---@field EmissiveBoost number
---Scales the diffuse contribution of all materials applied to this object.
---@field DiffuseBoost number
---Fraction of samples taken that must be occluded in order to reach full occlusion.
---@field FullyOccludedSamplesFraction number
local LightmassPrimitiveSettings = {}

--- Constructor
---@return LightmassPrimitiveSettings
---@param bUseTwoSidedLighting boolean
---@param bShadowIndirectOnly boolean
---@param bUseEmissiveForStaticLighting boolean
---@param bUseVertexNormalForHemisphereGather boolean
---@param EmissiveLightFalloffExponent number
---@param EmissiveLightExplicitInfluenceRadius number
---@param EmissiveBoost number
---@param DiffuseBoost number
---@param FullyOccludedSamplesFraction number
function LightmassPrimitiveSettings.new(bUseTwoSidedLighting, bShadowIndirectOnly, bUseEmissiveForStaticLighting, bUseVertexNormalForHemisphereGather, EmissiveLightFalloffExponent, EmissiveLightExplicitInfluenceRadius, EmissiveBoost, DiffuseBoost, FullyOccludedSamplesFraction)
    local self = {}
    self.bUseTwoSidedLighting = bUseTwoSidedLighting
    self.bShadowIndirectOnly = bShadowIndirectOnly
    self.bUseEmissiveForStaticLighting = bUseEmissiveForStaticLighting
    self.bUseVertexNormalForHemisphereGather = bUseVertexNormalForHemisphereGather
    self.EmissiveLightFalloffExponent = EmissiveLightFalloffExponent
    self.EmissiveLightExplicitInfluenceRadius = EmissiveLightExplicitInfluenceRadius
    self.EmissiveBoost = EmissiveBoost
    self.DiffuseBoost = DiffuseBoost
    self.FullyOccludedSamplesFraction = FullyOccludedSamplesFraction
    return self
end

return LightmassPrimitiveSettings
