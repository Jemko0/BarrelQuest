---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class DisplacementFadeRange
---Displacement Fade Range
---
--- Properties
---
---How large the max displacement should be, in on-screen pixels, when beginning to fade out displacement.
---NOTE: This should be a LARGER number than End Fade Size.
---@field StartSizePixels number
---How large the max displacement should be, in on-screen pixels, when fading out should complete, and displacement
---should be disabled.
---NOTE: This should be a SMALLER number than Start Fade Size.
---@field EndSizePixels number
local DisplacementFadeRange = {}

--- Constructor
---@return DisplacementFadeRange
---@param StartSizePixels number
---@param EndSizePixels number
function DisplacementFadeRange.new(StartSizePixels, EndSizePixels)
    local self = {}
    self.StartSizePixels = StartSizePixels
    self.EndSizePixels = EndSizePixels
    return self
end

return DisplacementFadeRange
