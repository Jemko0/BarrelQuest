---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class CurveVector : CurveBase
---Curve Vector
---
--- Properties
---
---Keyframe data, one curve for X, Y and Z
---@field FloatCurves RichCurve
local CurveVector = {}

--- Methods
---Evaluate this float curve at the specified time
---@param InTime number
---@return Vector
function CurveVector.GetVectorValue(InTime) end

return CurveVector
