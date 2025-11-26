---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoundWaveTimecodeInfo
---Sound Wave Timecode Info
---
--- Properties
---
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

--- Constructor
---@return SoundWaveTimecodeInfo
---@param NumSamplesSinceMidnight integer
---@param NumSamplesPerSecond integer
---@param Description string
---@param OriginatorTime string
---@param OriginatorDate string
---@param OriginatorDescription string
---@param OriginatorReference string
---@param TimecodeRate FrameRate
---@param bTimecodeIsDropFrame boolean
function SoundWaveTimecodeInfo.new(NumSamplesSinceMidnight, NumSamplesPerSecond, Description, OriginatorTime, OriginatorDate, OriginatorDescription, OriginatorReference, TimecodeRate, bTimecodeIsDropFrame)
    local self = {}
    self.NumSamplesSinceMidnight = NumSamplesSinceMidnight
    self.NumSamplesPerSecond = NumSamplesPerSecond
    self.Description = Description
    self.OriginatorTime = OriginatorTime
    self.OriginatorDate = OriginatorDate
    self.OriginatorDescription = OriginatorDescription
    self.OriginatorReference = OriginatorReference
    self.TimecodeRate = TimecodeRate
    self.bTimecodeIsDropFrame = bTimecodeIsDropFrame
    return self
end

return SoundWaveTimecodeInfo
