---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class ForceFeedbackEffect
---A predefined force-feedback effect to be played on a controller
---
--- Properties
---
---@field ChannelDetails ForceFeedbackChannelDetails[]
---A map of platform name -> ForceFeedback channel details
---@field PerDeviceOverrides table<string, ForceFeedbackEffectOverridenChannelDetails>
---A map of input device properties that we want to set while this effect is playing
---@field DeviceProperties InputDeviceProperty[]
---Duration of force feedback pattern in seconds.
---@field Duration number
local ForceFeedbackEffect = {}

--- Methods
return ForceFeedbackEffect
