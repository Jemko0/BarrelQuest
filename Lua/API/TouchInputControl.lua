---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class TouchInputControl
---Touch Input Control
---
--- Properties
---Set this to true to treat the joystick as a simple button
---@field bTreatAsButton boolean
---For sticks, this is the Thumb
---@field Image1 Texture2D
---For sticks, this is the Background
---@field Image2 Texture2D
---The initial center point of the control. If Time Until Reset is < 0, control resets back to here.
---Use negative numbers to invert positioning from top to bottom, left to right. (if <= 1.0, it's relative to screen, > 1.0 is absolute)
---@field Center Vector2D
---The size of the control (if <= 1.0, it's relative to screen, > 1.0 is absolute)
---@field VisualSize Vector2D
---For sticks, the size of the thumb (if <= 1.0, it's relative to screen, > 1.0 is absolute)
---@field ThumbSize Vector2D
---The interactive size of the control. Measured outward from Center. (if <= 1.0, it's relative to screen, > 1.0 is absolute)
---@field InteractionSize Vector2D
---The scale for control input
---@field InputScale Vector2D
---The main input to send from this control (for sticks, this is the horizontal axis)
---@field MainInputKey Key
---The alternate input to send from this control (for sticks, this is the vertical axis)
---@field AltInputKey Key
local TouchInputControl = {}
return TouchInputControl
