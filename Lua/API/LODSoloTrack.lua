---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class LODSoloTrack
---Temporary array for tracking 'solo' emitter mode.
---Entry will be true if emitter was enabled
---
--- Properties
---@field SoloEnableSetting integer[]
local LODSoloTrack = {}

--- Constructor
---@return LODSoloTrack
---@param SoloEnableSetting integer[]
function LODSoloTrack.new(SoloEnableSetting)
    local self = {}
    self.SoloEnableSetting = SoloEnableSetting
    return self
end

return LODSoloTrack
