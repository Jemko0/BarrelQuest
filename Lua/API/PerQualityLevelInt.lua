---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PerQualityLevelInt
---Per Quality Level Int
---
--- Properties
---@field Default integer
---@field PerQuality table<integer, integer>
local PerQualityLevelInt = {}

--- Constructor
---@return PerQualityLevelInt
---@param Default integer
---@param PerQuality table<integer, integer>
function PerQualityLevelInt.new(Default, PerQuality)
    local self = {}
    self.Default = Default
    self.PerQuality = PerQuality
    return self
end

return PerQualityLevelInt
