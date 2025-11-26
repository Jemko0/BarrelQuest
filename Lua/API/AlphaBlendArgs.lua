---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AlphaBlendArgs
---Alpha Blend construction arguments. Used for creation of an AlphaBlend.
---
--- Properties
---If you're using Custom BlendOption, you can specify curve
---@field CustomCurve CurveFloat
---Blend Time
---@field BlendTime number
---Type of blending used (Linear, Cubic, etc.)
---@field BlendOption EAlphaBlendOption
local AlphaBlendArgs = {}

--- Constructor
---@return AlphaBlendArgs
---@param CustomCurve CurveFloat
---@param BlendTime number
---@param BlendOption EAlphaBlendOption
function AlphaBlendArgs.new(CustomCurve, BlendTime, BlendOption)
    local self = {}
    self.CustomCurve = CustomCurve
    self.BlendTime = BlendTime
    self.BlendOption = BlendOption
    return self
end

return AlphaBlendArgs
