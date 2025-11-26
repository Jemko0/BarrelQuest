---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class TTTrackId
---TTTrack Id
---
--- Properties
---@field TrackType integer
---@field TrackIndex integer
local TTTrackId = {}

--- Constructor
---@return TTTrackId
---@param TrackType integer
---@param TrackIndex integer
function TTTrackId.new(TrackType, TrackIndex)
    local self = {}
    self.TrackType = TrackType
    self.TrackIndex = TrackIndex
    return self
end

return TTTrackId
