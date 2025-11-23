---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class MovementProperties
---Movement capabilities, determining available movement options for Pawns and used by AI for reachability tests.
---
--- Properties
---If true, this Pawn is capable of crouching.
---@field bCanCrouch boolean
---If true, this Pawn is capable of jumping.
---@field bCanJump boolean
---If true, this Pawn is capable of walking or moving on the ground.
---@field bCanWalk boolean
---If true, this Pawn is capable of swimming or moving through fluid volumes.
---@field bCanSwim boolean
---If true, this Pawn is capable of flying.
---@field bCanFly boolean
local MovementProperties = {}
return MovementProperties
