---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Vector3f
---A point or direction FVector in 3d space.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Vector.h
---
--- Properties
---@field X number
---@field Y number
---@field Z number
local Vector3f = {}

--- Constructor
---@return Vector3f
---@param X number
---@param Y number
---@param Z number
function Vector3f.new(X, Y, Z)
    local self = {}
    self.X = X
    self.Y = Y
    self.Z = Z
    return self
end

return Vector3f
