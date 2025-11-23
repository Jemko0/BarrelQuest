---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ActiveForceFeedbackEffect
---Active Force Feedback Effect
---
--- Properties
---@field ForceFeedbackEffect ForceFeedbackEffect
---Array of device properties that have been activated by this force feedback effect
---@field ActiveDeviceProperties table<InputDevicePropertyHandle, boolean>
local ActiveForceFeedbackEffect = {}
return ActiveForceFeedbackEffect
