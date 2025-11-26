---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SoundWaveEnvelopeTimeData
---Struct used to store time-stamped envelope data
---
--- Properties
---The normalized linear amplitude of the audio
---@field Amplitude number
---The timestamp of the audio
---@field TimeSec number
local SoundWaveEnvelopeTimeData = {}

--- Constructor
---@return SoundWaveEnvelopeTimeData
---@param Amplitude number
---@param TimeSec number
function SoundWaveEnvelopeTimeData.new(Amplitude, TimeSec)
    local self = {}
    self.Amplitude = Amplitude
    self.TimeSec = TimeSec
    return self
end

return SoundWaveEnvelopeTimeData
