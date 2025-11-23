---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SoundWaveCuePoint
---Struct defining a cue point in a sound wave asset
---
--- Properties
---Unique identifier for the wave cue point
---@field CuePointID integer
---The label for the cue point
---@field Label string
---The frame position of the cue point
---@field FramePosition integer
---The frame length of the cue point (non-zero if it's a region)
---@field FrameLength integer
---intentionally kept private.
---only USoundFactory should modify this value on import
---@field bIsLoopRegion boolean
local SoundWaveCuePoint = {}
return SoundWaveCuePoint
