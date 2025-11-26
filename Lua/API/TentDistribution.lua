---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TentDistribution
---Tent Distribution
---
--- Properties
---
---@field TipAltitude number
---@field TipValue number
---@field Width number
local TentDistribution = {}

--- Constructor
---@return TentDistribution
---@param TipAltitude number
---@param TipValue number
---@param Width number
function TentDistribution.new(TipAltitude, TipValue, Width)
    local self = {}
    self.TipAltitude = TipAltitude
    self.TipValue = TipValue
    self.Width = Width
    return self
end

return TentDistribution
