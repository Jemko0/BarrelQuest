---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RootMotionMovementParams
---Utility struct to accumulate root motion.
---
--- Properties
---@field bHasRootMotion boolean
---@field BlendWeight number
---@field RootMotionTransform Transform
local RootMotionMovementParams = {}

--- Constructor
---@return RootMotionMovementParams
---@param bHasRootMotion boolean
---@param BlendWeight number
---@param RootMotionTransform Transform
function RootMotionMovementParams.new(bHasRootMotion, BlendWeight, RootMotionTransform)
    local self = {}
    self.bHasRootMotion = bHasRootMotion
    self.BlendWeight = BlendWeight
    self.RootMotionTransform = RootMotionTransform
    return self
end

return RootMotionMovementParams
