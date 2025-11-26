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
return SoundWaveEnvelopeTimeData
