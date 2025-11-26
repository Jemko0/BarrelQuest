---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CameraCacheEntry
---Cached camera POV info, stored as optimization so we only
---need to do a full camera update once per tick.
---
--- Properties
---
---World time this entry was created.
---@field TimeStamp number
---Camera POV to cache.
---@field POV MinimalViewInfo
local CameraCacheEntry = {}

--- Constructor
---@return CameraCacheEntry
---@param TimeStamp number
---@param POV MinimalViewInfo
function CameraCacheEntry.new(TimeStamp, POV)
    local self = {}
    self.TimeStamp = TimeStamp
    self.POV = POV
    return self
end

return CameraCacheEntry
