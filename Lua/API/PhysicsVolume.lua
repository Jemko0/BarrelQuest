---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PhysicsVolume : Volume
---PhysicsVolume: A bounding volume which affects actor physics.
---Each AActor is affected at any time by one PhysicsVolume.
---
--- Properties
---Terminal velocity of pawns using CharacterMovement when falling.
---@field TerminalVelocity number
---Determines which PhysicsVolume takes precedence if they overlap (higher number = higher priority).
---@field Priority integer
---This property controls the amount of friction applied by the volume as pawns using CharacterMovement move through it. The higher this value, the harder it will feel to move through
---@field FluidFriction number
---True if this volume contains a fluid like water
---@field bWaterVolume boolean
---By default, the origin of an AActor must be inside a PhysicsVolume for it to affect the actor. However if this flag is true, the other actor only has to touch the volume to be affected by it.
---@field bPhysicsOnContact boolean
local PhysicsVolume = {}

--- Methods
return PhysicsVolume
