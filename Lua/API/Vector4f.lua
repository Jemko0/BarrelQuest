---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Vector4f
---A 4-D homogeneous vector.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Vector4.h
---
--- Properties
---
---@field X number
---@field Y number
---@field Z number
---@field W number
local Vector4f = {}

--- Constructor
---@return Vector4f
---@param X number
---@param Y number
---@param Z number
---@param W number
function Vector4f.new(X, Y, Z, W)
    local self = {}
    self.X = X
    self.Y = Y
    self.Z = Z
    self.W = W
    return self
end

return Vector4f
