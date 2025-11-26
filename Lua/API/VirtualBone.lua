---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class VirtualBone
---Virtual Bone
---
--- Properties
---
---@field SourceBoneName string
---@field TargetBoneName string
---@field VirtualBoneName string
local VirtualBone = {}

--- Constructor
---@return VirtualBone
---@param SourceBoneName string
---@param TargetBoneName string
---@param VirtualBoneName string
function VirtualBone.new(SourceBoneName, TargetBoneName, VirtualBoneName)
    local self = {}
    self.SourceBoneName = SourceBoneName
    self.TargetBoneName = TargetBoneName
    self.VirtualBoneName = VirtualBoneName
    return self
end

return VirtualBone
