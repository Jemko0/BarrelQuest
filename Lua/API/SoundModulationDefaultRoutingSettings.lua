---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SoundModulationDefaultRoutingSettings
---Default parameter destination settings for source audio object.
---
--- Properties
---What volume modulation settings to use
---@field VolumeRouting EModulationRouting
---What pitch modulation settings to use
---@field PitchRouting EModulationRouting
---What high-pass modulation settings to use
---@field HighpassRouting EModulationRouting
---What low-pass modulation settings to use
---@field LowpassRouting EModulationRouting
---Volume modulation
---@field VolumeModulationDestination SoundModulationDestinationSettings
---Pitch modulation
---@field PitchModulationDestination SoundModulationDestinationSettings
---Highpass modulation
---@field HighpassModulationDestination SoundModulationDestinationSettings
---Lowpass modulation
---@field LowpassModulationDestination SoundModulationDestinationSettings
local SoundModulationDefaultRoutingSettings = {}
return SoundModulationDefaultRoutingSettings
