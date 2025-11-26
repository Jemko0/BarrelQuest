---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SkeletalMeshLODGroupSettings
---Skeletal Mesh LODGroup Settings
---
--- Properties
---
---The screen sizes to use for the respective LOD level
---@field ScreenSize PerPlatformFloat
---Used to avoid 'flickering' when on LOD boundary. Only taken into account when moving from complex->simple.
---@field LODHysteresis number
---Bones which should be removed from the skeleton for the LOD level
---@field BoneFilterActionOption EBoneFilterActionOption
---Bones which should be removed from the skeleton for the LOD level
---@field BoneList BoneFilter[]
---Bones which should be prioritized for the quality, this will be weighted toward keeping source data. Use WeightOfPrioritization to control the value.
---@field BonesToPrioritize string[]
---Sections which should be prioritized for the quality, this will be weighted toward keeping source data. Use WeightOfPrioritization to control the value.
---@field SectionsToPrioritize integer[]
---How much to consideration to give BonesToPrioritize and SectionsToPrioritize.  The weight is an additional vertex simplification penalty where 0 means nothing.
---@field WeightOfPrioritization number
---Pose which should be used to reskin vertex influences for which the bones will be removed in this LOD level, uses ref-pose by default
---@field BakePose AnimSequence
---The optimization settings to use for the respective LOD level
---@field ReductionSettings SkeletalMeshOptimizationSettings
---Whether a Mesh Deformer applied to the mesh asset or Skinned Mesh Component should be used on this LOD or not
---@field bAllowMeshDeformer boolean
local SkeletalMeshLODGroupSettings = {}

--- Constructor
---@return SkeletalMeshLODGroupSettings
---@param ScreenSize PerPlatformFloat
---@param LODHysteresis number
---@param BoneFilterActionOption EBoneFilterActionOption
---@param BoneList BoneFilter[]
---@param BonesToPrioritize string[]
---@param SectionsToPrioritize integer[]
---@param WeightOfPrioritization number
---@param BakePose AnimSequence
---@param ReductionSettings SkeletalMeshOptimizationSettings
---@param bAllowMeshDeformer boolean
function SkeletalMeshLODGroupSettings.new(ScreenSize, LODHysteresis, BoneFilterActionOption, BoneList, BonesToPrioritize, SectionsToPrioritize, WeightOfPrioritization, BakePose, ReductionSettings, bAllowMeshDeformer)
    local self = {}
    self.ScreenSize = ScreenSize
    self.LODHysteresis = LODHysteresis
    self.BoneFilterActionOption = BoneFilterActionOption
    self.BoneList = BoneList
    self.BonesToPrioritize = BonesToPrioritize
    self.SectionsToPrioritize = SectionsToPrioritize
    self.WeightOfPrioritization = WeightOfPrioritization
    self.BakePose = BakePose
    self.ReductionSettings = ReductionSettings
    self.bAllowMeshDeformer = bAllowMeshDeformer
    return self
end

return SkeletalMeshLODGroupSettings
