---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RawDistributionVector
---Raw Distribution Vector
---
--- Properties
---@field MinValue number
---@field MaxValue number
---@field MinValueVec Vector
---@field MaxValueVec Vector
---@field Distribution DistributionVector
---@field Table DistributionLookupTable
local RawDistributionVector = {}

--- Constructor
---@return RawDistributionVector
---@param MinValue number
---@param MaxValue number
---@param MinValueVec Vector
---@param MaxValueVec Vector
---@param Distribution DistributionVector
---@param Table DistributionLookupTable
function RawDistributionVector.new(MinValue, MaxValue, MinValueVec, MaxValueVec, Distribution, Table)
    local self = {}
    self.MinValue = MinValue
    self.MaxValue = MaxValue
    self.MinValueVec = MinValueVec
    self.MaxValueVec = MaxValueVec
    self.Distribution = Distribution
    self.Table = Table
    return self
end

return RawDistributionVector
