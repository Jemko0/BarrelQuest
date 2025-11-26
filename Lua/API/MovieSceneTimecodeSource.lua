---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MovieSceneTimecodeSource
---Movie Scene Timecode Source
---
--- Properties
---The global timecode at which this target is based (ie. the timecode at the beginning of the movie scene section when it was recorded)
---@field Timecode Timecode
local MovieSceneTimecodeSource = {}

--- Constructor
---@return MovieSceneTimecodeSource
---@param Timecode Timecode
function MovieSceneTimecodeSource.new(Timecode)
    local self = {}
    self.Timecode = Timecode
    return self
end

return MovieSceneTimecodeSource
