---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class DefaultPawn : Pawn
---DefaultPawn implements a simple Pawn with spherical collision and built-in flying movement.
---@see UFloatingPawnMovement
---
--- Properties
---Base turn rate, in deg/sec. Other scaling may affect final turn rate.
---@field BaseTurnRate number
---Base lookup rate, in deg/sec. Other scaling may affect final lookup rate.
---@field BaseLookUpRate number
---DefaultPawn movement component
---@field MovementComponent PawnMovementComponent
---If true, adds default input bindings for movement and camera look.
---@field bAddDefaultMovementBindings boolean
local DefaultPawn = {}

--- Methods
---Called via input to turn at a given rate.
---@param Rate number
---@return nil
function DefaultPawn.TurnAtRate(Rate) end

---Input callback to move up in world space (or down if Val is negative).
---@see APawn::AddMovementInput()
---@param Val number
---@return nil
function DefaultPawn.MoveUp_World(Val) end

---Input callback to strafe right in local space (or left if Val is negative).
---@see APawn::AddMovementInput()
---@param Val number
---@return nil
function DefaultPawn.MoveRight(Val) end

---Input callback to move forward in local space (or backward if Val is negative).
---@see APawn::AddMovementInput()
---@param Val number
---@return nil
function DefaultPawn.MoveForward(Val) end

---Called via input to look up at a given rate (or down if Rate is negative).
---@param Rate number
---@return nil
function DefaultPawn.LookUpAtRate(Rate) end

return DefaultPawn
