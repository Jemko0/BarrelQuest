---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class IntPoint
---Screen coordinates.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\IntPoint.h
---
--- Properties
---@field X integer
---@field Y integer
local IntPoint = {}

--- Constructor
---@return IntPoint
---@param X integer
---@param Y integer
function IntPoint.new(X, Y)
    local self = {}
    self.X = X
    self.Y = Y
    return self
end

return IntPoint
