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
return BranchingPointMarker
