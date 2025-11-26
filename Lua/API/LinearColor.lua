---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class LinearColor
---A linear, 32-bit/component floating point RGBA color.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Color.h
---
--- Properties
---@field R number
---@field G number
---@field B number
---@field A number
local LinearColor = {}
return LinearColor
