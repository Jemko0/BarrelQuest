---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ForceFeedbackChannelDetails
---Force Feedback Channel Details
---
--- Properties
---
---Please note the final channel mapping depends on the software and hardware capabilities of the platform used to run the engine or the game. Refer to documentation for more information.
---@field bAffectsLeftLarge boolean
---Please note the final channel mapping depends on the software and hardware capabilities of the platform used to run the engine or the game. Refer to documentation for more information.
---@field bAffectsLeftSmall boolean
---Please note the final channel mapping depends on the software and hardware capabilities of the platform used to run the engine or the game. Refer to documentation for more information.
---@field bAffectsRightLarge boolean
---Please note the final channel mapping depends on the software and hardware capabilities of the platform used to run the engine or the game. Refer to documentation for more information.
---@field bAffectsRightSmall boolean
---@field Curve RuntimeFloatCurve
local ForceFeedbackChannelDetails = {}

--- Constructor
---@return ForceFeedbackChannelDetails
---@param bAffectsLeftLarge boolean
---@param bAffectsLeftSmall boolean
---@param bAffectsRightLarge boolean
---@param bAffectsRightSmall boolean
---@param Curve RuntimeFloatCurve
function ForceFeedbackChannelDetails.new(bAffectsLeftLarge, bAffectsLeftSmall, bAffectsRightLarge, bAffectsRightSmall, Curve)
    local self = {}
    self.bAffectsLeftLarge = bAffectsLeftLarge
    self.bAffectsLeftSmall = bAffectsLeftSmall
    self.bAffectsRightLarge = bAffectsRightLarge
    self.bAffectsRightSmall = bAffectsRightSmall
    self.Curve = Curve
    return self
end

return ForceFeedbackChannelDetails
