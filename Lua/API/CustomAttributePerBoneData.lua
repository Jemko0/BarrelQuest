---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CustomAttributePerBoneData
---Custom Attribute Per Bone Data
---
--- Properties
---@field BoneTreeIndex integer
---@field Attributes CustomAttribute[]
local CustomAttributePerBoneData = {}

--- Constructor
---@return CustomAttributePerBoneData
---@param BoneTreeIndex integer
---@param Attributes CustomAttribute[]
function CustomAttributePerBoneData.new(BoneTreeIndex, Attributes)
    local self = {}
    self.BoneTreeIndex = BoneTreeIndex
    self.Attributes = Attributes
    return self
end

return CustomAttributePerBoneData
