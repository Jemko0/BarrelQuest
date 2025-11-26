---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class QueuedWidgetAnimationTransition
---Struct that maintains state of currently queued animation transtions to be evaluated next frame.
---
--- Properties
---Animation with a queued transition
---@field WidgetAnimation WidgetAnimation
local QueuedWidgetAnimationTransition = {}

--- Constructor
---@return QueuedWidgetAnimationTransition
---@param WidgetAnimation WidgetAnimation
function QueuedWidgetAnimationTransition.new(WidgetAnimation)
    local self = {}
    self.WidgetAnimation = WidgetAnimation
    return self
end

return QueuedWidgetAnimationTransition
