---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ForceFeedbackChannelDetails
---Force Feedback Channel Details
---
--- Properties
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
return ForceFeedbackChannelDetails
