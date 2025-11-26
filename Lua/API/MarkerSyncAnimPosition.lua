---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

--- Constructor
---@return MarkerSyncAnimPosition
---@param PreviousMarkerName string
---@param NextMarkerName string
---@param PositionBetweenMarkers number
function MarkerSyncAnimPosition.new(PreviousMarkerName, NextMarkerName, PositionBetweenMarkers)
    local self = {}
    self.PreviousMarkerName = PreviousMarkerName
    self.NextMarkerName = NextMarkerName
    self.PositionBetweenMarkers = PositionBetweenMarkers
    return self
end

return MarkerSyncAnimPosition
