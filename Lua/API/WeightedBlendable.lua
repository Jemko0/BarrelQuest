---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class WeightedBlendable
---Weighted Blendable
---
--- Properties
---0:no effect .. 1:full effect
---@field Weight number
---should be of the IBlendableInterface* type but UProperties cannot express that
---@field Object Object
local WeightedBlendable = {}
return WeightedBlendable
