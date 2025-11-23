---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class Color
---Stores a color with 8 bits of precision per channel. (BGRA).
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Color.h
---
--- Properties
---@field B integer
---@field G integer
---@field R integer
---@field A integer
local Color = {}
return Color
