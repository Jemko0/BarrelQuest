---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Vector2D
---A vector in 2-D space composed of components (X, Y) with floating point precision.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Vector2D.h
---
--- Properties
---@field X number
---@field Y number
local Vector2D = {}

--- Constructor
---@return Vector2D
---@param X number
---@param Y number
function Vector2D.new(X, Y)
    local self = {}
    self.X = X
    self.Y = Y
    return self
end

return Vector2D
