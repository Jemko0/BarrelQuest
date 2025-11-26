---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SubsurfaceProfileStruct
---struct with all the settings we want in USubsurfaceProfile, separate to make it easer to pass this data around in the engine.
---
--- Properties
---
---It should match The base color of the corresponding material as much as possible.
---@field SurfaceAlbedo LinearColor
---Controls how far light goes into the subsurface in the Red, Green and Blue channel. It is scaled by Mean Free path distance.
---@field MeanFreePathColor LinearColor
---Subsurface mean free path distance in world/unreal units (cm)
---@field MeanFreePathDistance number
---Control the scale of world/unreal units (cm)
---@field WorldUnitScale number
---Effective only when Burley subsurface scattering is enabled in cmd.
---@field bEnableBurley boolean
---Switch to use Mean Free Path, otherwise use diffuse mean free path.
---@field bEnableMeanFreePath boolean
---Specifies the how much of the diffuse light gets into the material,
---can be seen as a per-channel mix factor between the original image,
---and the SSS-filtered image. It introduces Non-PBR looks.
---@field Tint LinearColor
---in world/unreal units (cm)
---@field ScatterRadius number
---Specifies the how much of the diffuse light gets into the material,
---can be seen as a per-channel mix factor between the original image,
---and the SSS-filtered image (called "strength" in SeparableSSS, default there: 0.48, 0.41, 0.28)
---@field SubsurfaceColor LinearColor
---defines the per-channel falloff of the gradients
---produced by the subsurface scattering events, can be used to fine tune the color of the gradients
---(called "falloff" in SeparableSSS, default there: 1, 0.37, 0.3)
---@field FalloffColor LinearColor
---@field BoundaryColorBleed LinearColor
---This allows users to use mixed implementations for best quality and performance (e.g., High quality for skin with AFIS, and high performance on ice with Separable in the same scene).
---@field Implementation ESubsurfaceImplementationTechniqueHint
---@field ExtinctionScale number
---@field NormalScale number
---@field ScatteringDistribution number
---@field IOR number
---@field Roughness0 number
---@field Roughness1 number
---@field LobeMix number
---Transmission tint control. It is multiplied on the transmission results. Works only when Burley is enabled.
---@field TransmissionTintColor LinearColor
local SubsurfaceProfileStruct = {}

--- Constructor
---@return SubsurfaceProfileStruct
---@param SurfaceAlbedo LinearColor
---@param MeanFreePathColor LinearColor
---@param MeanFreePathDistance number
---@param WorldUnitScale number
---@param bEnableBurley boolean
---@param bEnableMeanFreePath boolean
---@param Tint LinearColor
---@param ScatterRadius number
---@param SubsurfaceColor LinearColor
---@param FalloffColor LinearColor
---@param BoundaryColorBleed LinearColor
---@param Implementation ESubsurfaceImplementationTechniqueHint
---@param ExtinctionScale number
---@param NormalScale number
---@param ScatteringDistribution number
---@param IOR number
---@param Roughness0 number
---@param Roughness1 number
---@param LobeMix number
---@param TransmissionTintColor LinearColor
function SubsurfaceProfileStruct.new(SurfaceAlbedo, MeanFreePathColor, MeanFreePathDistance, WorldUnitScale, bEnableBurley, bEnableMeanFreePath, Tint, ScatterRadius, SubsurfaceColor, FalloffColor, BoundaryColorBleed, Implementation, ExtinctionScale, NormalScale, ScatteringDistribution, IOR, Roughness0, Roughness1, LobeMix, TransmissionTintColor)
    local self = {}
    self.SurfaceAlbedo = SurfaceAlbedo
    self.MeanFreePathColor = MeanFreePathColor
    self.MeanFreePathDistance = MeanFreePathDistance
    self.WorldUnitScale = WorldUnitScale
    self.bEnableBurley = bEnableBurley
    self.bEnableMeanFreePath = bEnableMeanFreePath
    self.Tint = Tint
    self.ScatterRadius = ScatterRadius
    self.SubsurfaceColor = SubsurfaceColor
    self.FalloffColor = FalloffColor
    self.BoundaryColorBleed = BoundaryColorBleed
    self.Implementation = Implementation
    self.ExtinctionScale = ExtinctionScale
    self.NormalScale = NormalScale
    self.ScatteringDistribution = ScatteringDistribution
    self.IOR = IOR
    self.Roughness0 = Roughness0
    self.Roughness1 = Roughness1
    self.LobeMix = LobeMix
    self.TransmissionTintColor = TransmissionTintColor
    return self
end

return SubsurfaceProfileStruct
