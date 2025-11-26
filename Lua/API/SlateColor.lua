---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SlateColor
---A Slate color can be a directly specified value, or the color can be pulled from a WidgetStyle.
---
--- Properties
---The current specified color; only meaningful when ColorToUse == UseColor_Specified.
---@field SpecifiedColor LinearColor
---The rule for which color to pick.
---@field ColorUseRule ESlateColorStylingMode
local SlateColor = {}
return SlateColor
