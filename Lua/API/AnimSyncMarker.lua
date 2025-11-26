---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AnimSyncMarker
---Anim Sync Marker
---
--- Properties
---The name of this marker
---@field MarkerName string
---Time in seconds of this marker
---@field Time number
---The editor track this marker sits on
---@field TrackIndex integer
---@field Guid Guid
local AnimSyncMarker = {}
return AnimSyncMarker
