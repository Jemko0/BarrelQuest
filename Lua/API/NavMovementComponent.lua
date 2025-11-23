---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NavMovementComponent : MovementComponent
---NavMovementComponent defines base functionality for MovementComponents that move any 'agent' that may be involved in AI pathfinding.
---
--- Properties
---@field FixedPathBrakingDistance number
---@field bUpdateNavAgentWithOwnersCollision boolean
---@field bUseAccelerationForPaths boolean
---@field bUseFixedBrakingDistanceForPaths boolean
---@field NavMovementProperties NavMovementProperties
---Properties that define how the component can move.
---@field NavAgentProps NavAgentProperties
---Expresses runtime state of character's movement. Put all temporal changes to movement properties here
---@field MovementState MovementProperties
local NavMovementComponent = {}

--- Methods
---Returns true if currently swimming (moving through a fluid volume)
---@return boolean
function NavMovementComponent.IsSwimming() end

---Returns true if currently moving on the ground (e.g. walking or driving)
---@return boolean
function NavMovementComponent.IsMovingOnGround() end

---Returns true if currently flying (moving through a non-fluid volume without resting on the ground)
---@return boolean
function NavMovementComponent.IsFlying() end

---Returns true if currently falling (not flying, in a non-fluid volume, and not on the ground)
---@return boolean
function NavMovementComponent.IsFalling() end

---Returns true if currently crouching
---@return boolean
function NavMovementComponent.IsCrouching() end

---Get the current velocity of the movement component
---@return Vector
function NavMovementComponent.GetVelocityForNavMovement() end

return NavMovementComponent
