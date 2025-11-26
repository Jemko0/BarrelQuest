---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PoseSnapshot
---A pose for a skeletal mesh
---
--- Properties
---Array of transforms per-bone
---@field LocalTransforms Transform[]
---Array of bone names (corresponding to LocalTransforms)
---@field BoneNames string[]
---The name of the skeletal mesh that was used to take this snapshot
---@field SkeletalMeshName string
---The name for this snapshot
---@field SnapshotName string
---Whether the pose is valid
---@field bIsValid boolean
local PoseSnapshot = {}

--- Constructor
---@return PoseSnapshot
---@param LocalTransforms Transform[]
---@param BoneNames string[]
---@param SkeletalMeshName string
---@param SnapshotName string
---@param bIsValid boolean
function PoseSnapshot.new(LocalTransforms, BoneNames, SkeletalMeshName, SnapshotName, bIsValid)
    local self = {}
    self.LocalTransforms = LocalTransforms
    self.BoneNames = BoneNames
    self.SkeletalMeshName = SkeletalMeshName
    self.SnapshotName = SnapshotName
    self.bIsValid = bIsValid
    return self
end

return PoseSnapshot
