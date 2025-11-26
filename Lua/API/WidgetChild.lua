---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class WidgetChild
---Represent a Widget present in the Tree Widget of the UserWidget
---
--- Properties
---
---This either the widget to focus, OR the name of the function to call.
---@field WidgetName string
---@field WidgetPtr any
local WidgetChild = {}

--- Constructor
---@return WidgetChild
---@param WidgetName string
---@param WidgetPtr any
function WidgetChild.new(WidgetName, WidgetPtr)
    local self = {}
    self.WidgetName = WidgetName
    self.WidgetPtr = WidgetPtr
    return self
end

return WidgetChild
