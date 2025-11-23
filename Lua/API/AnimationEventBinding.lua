---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class AnimationEventBinding
---Used to manage different animation event bindings that users want callbacks on.
---
--- Properties
---The animation to look for.
---@field Animation WidgetAnimation
---The callback.
---@field Delegate function
---The type of animation event.
---@field AnimationEvent EWidgetAnimationEvent
---A user tag used to only get callbacks for specific runs of the animation.
---@field UserTag string
local AnimationEventBinding = {}
return AnimationEventBinding
