---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BranchingPoint
---Remove FBranchingPoint when VER_UE4_MONTAGE_BRANCHING_POINT_REMOVAL is removed.
---
--- Properties
---@field EventName string
---@field DisplayTime number
---An offset from the DisplayTime to the actual time we will trigger the notify, as we cannot always trigger it exactly at the time the user wants
---@field TriggerTimeOffset number
---The montage that this element is currently linked to
---@field LinkedMontage AnimMontage
---The slot index we are currently using within LinkedMontage
---@field SlotIndex integer
---The index of the segment we are linked to within the slot we are using
---@field SegmentIndex integer
---The method we are using to calculate our times
---@field LinkMethod integer
---Cached link method used to transform the time when LinkMethod changes, always relates to the currently stored time
---@field CachedLinkMethod integer
---The absolute time in the montage that our currently linked segment begins
---@field SegmentBeginTime number
---The absolute length of our currently linked segment
---@field SegmentLength number
---The time of this montage. This will differ depending upon the method we are using to link the time for this element
---@field LinkValue number
---The Animation Sequence that this montage element will link to, when the sequence changes
---in either length or rate; the element will correctly place itself in relation to the sequence
---@field LinkedSequence AnimSequenceBase
local BranchingPoint = {}
return BranchingPoint
