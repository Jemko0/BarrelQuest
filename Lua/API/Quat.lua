---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Quat
---Quaternion.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Quat.h
---
--- Properties
---@field X number
---@field Y number
---@field Z number
---@field W number
local Quat = {}

--- Constructor
---@return Quat
---@param X number
---@param Y number
---@param Z number
---@param W number
function Quat.new(X, Y, Z, W)
    local self = {}
    self.X = X
    self.Y = Y
    self.Z = Z
    self.W = W
    return self
end

return Quat
