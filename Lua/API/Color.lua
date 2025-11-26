---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

--- Constructor
---@return Color
---@param B integer
---@param G integer
---@param R integer
---@param A integer
function Color.new(B, G, R, A)
    local self = {}
    self.B = B
    self.G = G
    self.R = R
    self.A = A
    return self
end

return Color
