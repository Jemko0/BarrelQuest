---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CurveFloat : CurveBase
---Curve Float
---
--- Properties
---Keyframe data
---@field FloatCurve RichCurve
---Flag to represent event curve
---@field bIsEventCurve boolean
local CurveFloat = {}

--- Methods
---Evaluate this float curve at the specified time
---@param InTime number
---@return number
function CurveFloat.GetFloatValue(InTime) end

return CurveFloat
