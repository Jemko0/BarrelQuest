---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RootMotionSourceGroup
---Group of Root Motion Sources that are applied
---
--- Properties
---Whether this group has additive root motion sources
---@field bHasAdditiveSources boolean
---Whether this group has override root motion sources
---@field bHasOverrideSources boolean
---Whether this group has override root motion sources that have IgnoreZAccumulate flag
---@field bHasOverrideSourcesWithIgnoreZAccumulate boolean
---True when we had additive velocity applied last tick, checked to know if we should restore
---LastPreAdditiveVelocity before a Velocity computation
---@field bIsAdditiveVelocityApplied boolean
---Aggregate Settings of the last group of accumulated sources
---@field LastAccumulatedSettings RootMotionSourceSettings
---Saved off pre-additive-applied Velocity, used for being able to reliably add/remove additive
---velocity from currently computed Velocity (otherwise we would be removing additive velocity
---that no longer exists, like if you run into a wall and your Velocity becomes 0 - subtracting
---the velocity that we added heading into the wall last tick would make you go backwards. With
---this method we override that resulting Velocity due to obstructions
---@field LastPreAdditiveVelocity Vector_NetQuantize10
local RootMotionSourceGroup = {}
return RootMotionSourceGroup
