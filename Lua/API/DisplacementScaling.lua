---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class DisplacementScaling
---Displacement Scaling
---
--- Properties
---
---@field Magnitude number
---@field Center number
local DisplacementScaling = {}

--- Constructor
---@return DisplacementScaling
---@param Magnitude number
---@param Center number
function DisplacementScaling.new(Magnitude, Center)
    local self = {}
    self.Magnitude = Magnitude
    self.Center = Center
    return self
end

return DisplacementScaling
