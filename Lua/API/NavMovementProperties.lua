---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NavMovementProperties
---Struct to hold properties a user might set for navigation movement
---
--- Properties
---Braking distance override used with acceleration driven path following (bUseAccelerationForPaths)
---@field FixedPathBrakingDistance number
---If set to true, NavAgentProperties' radius and height will be updated with Owner's collision capsule size
---@field bUpdateNavAgentWithOwnersCollision boolean
---If set, pathfollowing will control character movement via acceleration values. If false, it will set velocities directly.
---@field bUseAccelerationForPaths boolean
---If set, FixedPathBrakingDistance will be used for path following deceleration
---@field bUseFixedBrakingDistanceForPaths boolean
---If set, StopActiveMovement call will abort current path following request
---@field bStopMovementAbortPaths boolean
local NavMovementProperties = {}
return NavMovementProperties
