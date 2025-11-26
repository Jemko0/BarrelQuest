---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class FrameRate
---A frame rate represented as a fraction comprising 2 integers: a numerator (number of frames), and a denominator (per second).
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Misc\FrameRate.h
---
--- Properties
---The numerator of the framerate represented as a number of frames per second (e.g. 60 for 60 fps)
---@field Numerator integer
---The denominator of the framerate represented as a number of frames per second (e.g. 1 for 60 fps)
---@field Denominator integer
local FrameRate = {}
return FrameRate
