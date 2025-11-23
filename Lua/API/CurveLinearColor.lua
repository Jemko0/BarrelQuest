---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CurveLinearColor : CurveBase
---Curve Linear Color
---
--- Properties
---Keyframe data, one curve for red, green, blue, and alpha
---@field FloatCurves RichCurve
---Properties for adjusting the color of the gradient
---@field AdjustHue number
---@field AdjustSaturation number
---@field AdjustBrightness number
---@field AdjustBrightnessCurve number
---@field AdjustVibrance number
---@field AdjustMinAlpha number
---@field AdjustMaxAlpha number
local CurveLinearColor = {}

--- Methods
---Get Unadjusted Linear Color Value
---@param InTime number
---@return LinearColor
function CurveLinearColor.GetUnadjustedLinearColorValue(InTime) end

---Get Linear Color Value
---@param InTime number
---@return LinearColor
function CurveLinearColor.GetLinearColorValue(InTime) end

---Get Clamped Linear Color Value
---@param InTime number
---@return LinearColor
function CurveLinearColor.GetClampedLinearColorValue(InTime) end

return CurveLinearColor
