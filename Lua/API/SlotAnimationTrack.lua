---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SlotAnimationTrack
---Each slot data referenced by Animation Slot
---contains slot name, and animation data
---
--- Properties
---@field SlotName string
---@field AnimTrack AnimTrack
local SlotAnimationTrack = {}

--- Constructor
---@return SlotAnimationTrack
---@param SlotName string
---@param AnimTrack AnimTrack
function SlotAnimationTrack.new(SlotName, AnimTrack)
    local self = {}
    self.SlotName = SlotName
    self.AnimTrack = AnimTrack
    return self
end

return SlotAnimationTrack
