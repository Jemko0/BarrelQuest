---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Vector
---A point or direction FVector in 3d space.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Vector.h
---
--- Properties
---@field X number
---@field Y number
---@field Z number
local Vector = {}

--- Constructor
---@return Vector
---@param X number
---@param Y number
---@param Z number
function Vector.new(X, Y, Z)
    local self = {}
    self.X = X
    self.Y = Y
    self.Z = Z
    return self
end

return Vector
