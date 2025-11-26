---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TouchInterface
---Defines an interface by which touch input can be controlled using any number of buttons and virtual joysticks
---
--- Properties
---
---@field Controls TouchInputControl[]
---Opacity (0.0 - 1.0) of all controls while any control is active
---@field ActiveOpacity number
---Opacity (0.0 - 1.0) of all controls while no controls are active
---@field InactiveOpacity number
---How long after user interaction will all controls fade out to Inactive Opacity
---@field TimeUntilDeactive number
---How long after going inactive will controls reset/recenter themselves (0.0 will disable this feature)
---@field TimeUntilReset number
---How long after joystick enabled for touch (0.0 will disable this feature)
---@field ActivationDelay number
---Prevent joystick re-centering and moving from Center through user taps
---@field bPreventRecenter boolean
---Delay at startup before virtual joystick is drawn
---@field StartupDelay number
local TouchInterface = {}

--- Methods
return TouchInterface
