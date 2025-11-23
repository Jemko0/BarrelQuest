---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

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
return RawDistributionVector
