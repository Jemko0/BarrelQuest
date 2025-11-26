---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class RichCurve
---A rich, editable float curve
---
--- Properties
---
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

--- Constructor
---@return RichCurve
---@param Keys RichCurveKey[]
---@param DefaultValue number
---@param PreInfinityExtrap integer
---@param PostInfinityExtrap integer
---@param KeyHandlesToIndices KeyHandleMap
function RichCurve.new(Keys, DefaultValue, PreInfinityExtrap, PostInfinityExtrap, KeyHandlesToIndices)
    local self = {}
    self.Keys = Keys
    self.DefaultValue = DefaultValue
    self.PreInfinityExtrap = PreInfinityExtrap
    self.PostInfinityExtrap = PostInfinityExtrap
    self.KeyHandlesToIndices = KeyHandlesToIndices
    return self
end

return RichCurve
