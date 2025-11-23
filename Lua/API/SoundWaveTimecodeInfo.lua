---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SoundWaveTimecodeInfo
---Sound Wave Timecode Info
---
--- Properties
---@field NumSamplesSinceMidnight integer
---@field NumSamplesPerSecond integer
---@field Description string
---@field OriginatorTime string
---@field OriginatorDate string
---@field OriginatorDescription string
---@field OriginatorReference string
---@field TimecodeRate FrameRate
---@field bTimecodeIsDropFrame boolean
local SoundWaveTimecodeInfo = {}
return SoundWaveTimecodeInfo
