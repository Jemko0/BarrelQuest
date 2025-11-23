---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class RichCurve
---A rich, editable float curve
---
--- Properties
---Sorted array of keys
---@field Keys RichCurveKey[]
---Default value
---@field DefaultValue number
---Pre-infinity extrapolation state
---@field PreInfinityExtrap integer
---Post-infinity extrapolation state
---@field PostInfinityExtrap integer
---Map of which key handles go to which indices.
---@field KeyHandlesToIndices KeyHandleMap
local RichCurve = {}
return RichCurve
