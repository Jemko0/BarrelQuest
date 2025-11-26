---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AlphaBlend
---Alpha Blend class that supports different blend options as well as custom curves
---
--- Properties
---If you're using Custom BlendOption, you can specify curve
---@field CustomCurve CurveFloat
---Blend Time
---@field BlendTime number
---Type of blending used (Linear, Cubic, etc.)
---@field BlendOption EAlphaBlendOption
local AlphaBlend = {}

--- Constructor
---@return AlphaBlend
---@param CustomCurve CurveFloat
---@param BlendTime number
---@param BlendOption EAlphaBlendOption
function AlphaBlend.new(CustomCurve, BlendTime, BlendOption)
    local self = {}
    self.CustomCurve = CustomCurve
    self.BlendTime = BlendTime
    self.BlendOption = BlendOption
    return self
end

return AlphaBlend
