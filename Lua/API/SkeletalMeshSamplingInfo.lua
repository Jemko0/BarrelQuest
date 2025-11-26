---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SkeletalMeshSamplingInfo
---Skeletal Mesh Sampling Info
---
--- Properties
---Info defining sampling of named regions on this mesh.
---@field Regions SkeletalMeshSamplingRegion[]
---@field BuiltData SkeletalMeshSamplingBuiltData
local SkeletalMeshSamplingInfo = {}

--- Constructor
---@return SkeletalMeshSamplingInfo
---@param Regions SkeletalMeshSamplingRegion[]
---@param BuiltData SkeletalMeshSamplingBuiltData
function SkeletalMeshSamplingInfo.new(Regions, BuiltData)
    local self = {}
    self.Regions = Regions
    self.BuiltData = BuiltData
    return self
end

return SkeletalMeshSamplingInfo
