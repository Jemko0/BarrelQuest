---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class WidgetTransform
---Describes the standard transformation of a widget
---
--- Properties
---
---The amount to translate the widget in slate units
---@field Translation Vector2D
---The scale to apply to the widget
---@field Scale Vector2D
---The amount to shear the widget in slate units
---@field Shear Vector2D
---The angle in degrees to rotate
---@field Angle number
local WidgetTransform = {}

--- Constructor
---@return WidgetTransform
---@param Translation Vector2D
---@param Scale Vector2D
---@param Shear Vector2D
---@param Angle number
function WidgetTransform.new(Translation, Scale, Shear, Angle)
    local self = {}
    self.Translation = Translation
    self.Scale = Scale
    self.Shear = Shear
    self.Angle = Angle
    return self
end

return WidgetTransform
