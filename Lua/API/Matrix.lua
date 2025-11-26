---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Matrix
---A 4x4 matrix.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Matrix.h
---
--- Properties
---@field XPlane Plane
---@field YPlane Plane
---@field ZPlane Plane
---@field WPlane Plane
local Matrix = {}

--- Constructor
---@return Matrix
---@param XPlane Plane
---@param YPlane Plane
---@param ZPlane Plane
---@param WPlane Plane
function Matrix.new(XPlane, YPlane, ZPlane, WPlane)
    local self = {}
    self.XPlane = XPlane
    self.YPlane = YPlane
    self.ZPlane = ZPlane
    self.WPlane = WPlane
    return self
end

return Matrix
