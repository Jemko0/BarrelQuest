---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class WidgetAnimationBinding
---A single object bound to a UMG sequence.
---
--- Properties
---@field WidgetName string
---@field SlotWidgetName string
---@field AnimationGuid Guid
---@field bIsRootWidget boolean
---@field DynamicBinding MovieSceneDynamicBinding
local WidgetAnimationBinding = {}
return WidgetAnimationBinding
