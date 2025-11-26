---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ActiveForceFeedbackEffect
---Active Force Feedback Effect
---
--- Properties
---
---@field ForceFeedbackEffect ForceFeedbackEffect
---Array of device properties that have been activated by this force feedback effect
---@field ActiveDeviceProperties table<InputDevicePropertyHandle, boolean>
local ActiveForceFeedbackEffect = {}

--- Constructor
---@return ActiveForceFeedbackEffect
---@param ForceFeedbackEffect ForceFeedbackEffect
---@param ActiveDeviceProperties table<InputDevicePropertyHandle, boolean>
function ActiveForceFeedbackEffect.new(ForceFeedbackEffect, ActiveDeviceProperties)
    local self = {}
    self.ForceFeedbackEffect = ForceFeedbackEffect
    self.ActiveDeviceProperties = ActiveDeviceProperties
    return self
end

return ActiveForceFeedbackEffect
