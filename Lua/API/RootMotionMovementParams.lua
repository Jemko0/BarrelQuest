---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class RootMotionMovementParams
---Utility struct to accumulate root motion.
---
--- Properties
---@field bHasRootMotion boolean
---@field BlendWeight number
---@field RootMotionTransform Transform
local RootMotionMovementParams = {}
return RootMotionMovementParams
