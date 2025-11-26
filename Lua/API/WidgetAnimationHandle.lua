---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class WidgetAnimationHandle
---Handle to an ongoing or finished widget animation.
---
--- Properties
---The widget this handle relates to.
---@field WeakUserWidget any
---The animation state index.
---@field StateIndex integer
---The animation state serial.
---@field StateSerial integer
local WidgetAnimationHandle = {}

--- Constructor
---@return WidgetAnimationHandle
---@param WeakUserWidget any
---@param StateIndex integer
---@param StateSerial integer
function WidgetAnimationHandle.new(WeakUserWidget, StateIndex, StateSerial)
    local self = {}
    self.WeakUserWidget = WeakUserWidget
    self.StateIndex = StateIndex
    self.StateSerial = StateSerial
    return self
end

return WidgetAnimationHandle
