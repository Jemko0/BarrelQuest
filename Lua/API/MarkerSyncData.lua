---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class MarkerSyncData
---Marker Sync Data
---
--- Properties
---
---Authored Sync markers
---@field AuthoredSyncMarkers AnimSyncMarker[]
local MarkerSyncData = {}

--- Constructor
---@return MarkerSyncData
---@param AuthoredSyncMarkers AnimSyncMarker[]
function MarkerSyncData.new(AuthoredSyncMarkers)
    local self = {}
    self.AuthoredSyncMarkers = AuthoredSyncMarkers
    return self
end

return MarkerSyncData
