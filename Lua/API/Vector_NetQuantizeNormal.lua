---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Vector_NetQuantizeNormal
---FVector_NetQuantizeNormal
---16 bits per component
---Valid range: -1..+1 inclusive
---
--- Properties
---
---@field X number
---@field Y number
---@field Z number
local Vector_NetQuantizeNormal = {}

--- Constructor
---@return Vector_NetQuantizeNormal
---@param X number
---@param Y number
---@param Z number
function Vector_NetQuantizeNormal.new(X, Y, Z)
    local self = {}
    self.X = X
    self.Y = Y
    self.Z = Z
    return self
end

return Vector_NetQuantizeNormal
