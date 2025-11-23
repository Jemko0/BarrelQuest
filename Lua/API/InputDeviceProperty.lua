---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class InputDeviceProperty
---Base class that represents a single Input Device Property. An Input Device Property
---represents a feature that can be set on an input device. Things like what color a
---light is, advanced rumble patterns, or trigger haptics.
---This top level object can then be evaluated at a specific time to create a lower level
---FInputDeviceProperty, which the IInputInterface implementation can interpret however it desires.
---The behavior of device properties can vary depending on the current platform. Some platforms may not
---support certain device properties. An older gamepad may not have any advanced trigger haptics for
---example.
---
--- Properties
---The duration that this device property should last. Override this if your property has any dynamic curves
---to be the max time range.
---A duration of 0 means that the device property will be treated as a "One Shot" effect, being applied once
---before being removed by the Input Device Subsystem.
---@field PropertyDuration number
local InputDeviceProperty = {}

--- Methods
return InputDeviceProperty
