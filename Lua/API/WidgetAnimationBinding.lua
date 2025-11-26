---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

--- Constructor
---@return WidgetAnimationBinding
---@param WidgetName string
---@param SlotWidgetName string
---@param AnimationGuid Guid
---@param bIsRootWidget boolean
---@param DynamicBinding MovieSceneDynamicBinding
function WidgetAnimationBinding.new(WidgetName, SlotWidgetName, AnimationGuid, bIsRootWidget, DynamicBinding)
    local self = {}
    self.WidgetName = WidgetName
    self.SlotWidgetName = SlotWidgetName
    self.AnimationGuid = AnimationGuid
    self.bIsRootWidget = bIsRootWidget
    self.DynamicBinding = DynamicBinding
    return self
end

return WidgetAnimationBinding
