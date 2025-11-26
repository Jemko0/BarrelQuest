---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoundWaveSpectralTimeData
---Struct used to store spectral data with time-stamps
---
--- Properties
---
---The spectral data at the given time. The array indices correspond to the frequencies set to analyze.
---@field Data SoundWaveSpectralDataEntry[]
---The timestamp associated with this spectral data
---@field TimeSec number
local SoundWaveSpectralTimeData = {}

--- Constructor
---@return SoundWaveSpectralTimeData
---@param Data SoundWaveSpectralDataEntry[]
---@param TimeSec number
function SoundWaveSpectralTimeData.new(Data, TimeSec)
    local self = {}
    self.Data = Data
    self.TimeSec = TimeSec
    return self
end

return SoundWaveSpectralTimeData
