---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BranchingPointMarker
---AnimNotifies marked as BranchingPoints will create these markers on their Begin/End times.
---      They create stopping points when the Montage is being ticked to dispatch events.
---
--- Properties
---@field NotifyIndex integer
---@field TriggerTime number
---@field NotifyEventType integer
local BranchingPointMarker = {}

--- Constructor
---@return BranchingPointMarker
---@param NotifyIndex integer
---@param TriggerTime number
---@param NotifyEventType integer
function BranchingPointMarker.new(NotifyIndex, TriggerTime, NotifyEventType)
    local self = {}
    self.NotifyIndex = NotifyIndex
    self.TriggerTime = TriggerTime
    self.NotifyEventType = NotifyEventType
    return self
end

return BranchingPointMarker
