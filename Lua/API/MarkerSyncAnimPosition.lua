---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class MarkerSyncAnimPosition
---Represent a current play position in an animation
---based on sync markers
---
--- Properties
---The marker we have passed
---@field PreviousMarkerName string
---The marker we are heading towards
---@field NextMarkerName string
---Value between 0 and 1 representing where we are:
---      0   we are at PreviousMarker
---      1   we are at NextMarker
---      0.5 we are half way between the two
---@field PositionBetweenMarkers number
local MarkerSyncAnimPosition = {}
return MarkerSyncAnimPosition
