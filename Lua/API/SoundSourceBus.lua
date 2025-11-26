---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoundSourceBus : SoundWave
---A source bus is a type of USoundBase and can be "played" like any sound.
---
--- Properties
---
---How many channels to use for the source bus if the audio bus is not specified, otherwise it will use the audio bus object's channel count.
---@field SourceBusChannels ESourceBusChannels
---The duration (in seconds) to use for the source bus. A duration of 0.0 indicates to play the source bus indefinitely.
---@field SourceBusDuration number
---Audio bus to use as audio for this source bus. This source bus will sonify the audio from the audio bus.
---@field AudioBus AudioBus
---Stop the source bus when the volume goes to zero.
---@field bAutoDeactivateWhenSilent boolean
local SoundSourceBus = {}

--- Methods
return SoundSourceBus
