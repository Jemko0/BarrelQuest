---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class AudioBus
---An audio bus is an object which represents an audio patch cord. Audio can be sent to it. It can be sonified using USoundSourceBuses.
---Instances of the audio bus are created in the audio engine.
---
--- Properties
---
---Number of channels to use for the Audio Bus.
---@field AudioBusChannels EAudioBusChannels
local AudioBus = {}

--- Methods
return AudioBus
