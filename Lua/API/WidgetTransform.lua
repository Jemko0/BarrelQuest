---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class WidgetTransform
---Describes the standard transformation of a widget
---
--- Properties
---The amount to translate the widget in slate units
---@field Translation Vector2D
---The scale to apply to the widget
---@field Scale Vector2D
---The amount to shear the widget in slate units
---@field Shear Vector2D
---The angle in degrees to rotate
---@field Angle number
local WidgetTransform = {}
return WidgetTransform
