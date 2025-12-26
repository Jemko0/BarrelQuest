---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class PawnMovementComponent : NavMovementComponent
---PawnMovementComponent can be used to update movement for an associated Pawn.
---It also provides ways to accumulate and read directional input in a generic way (with AddInputVector(), ConsumeInputVector(), etc).
---@see APawn
---
--- Properties
---
---Pawn that owns this component.
---@field PawnOwner Pawn
local PawnMovementComponent = {}

--- Methods
---Helper to see if move input is ignored. If there is no Pawn or UpdatedComponent, returns true, otherwise defers to the Pawn's implementation of IsMoveInputIgnored().
---@return boolean
function PawnMovementComponent.IsMoveInputIgnored() end

---Return the pending input vector in world space. This is the most up-to-date value of the input vector, pending ConsumeMovementInputVector() which clears it.
---PawnMovementComponents implementing movement usually want to use either this or ConsumeInputVector() as these functions represent the most recent state of input.
---\@see AddInputVector(), ConsumeInputVector(), GetLastInputVector()
---@return Vector
function PawnMovementComponent.GetPendingInputVector() end

---Return the Pawn that owns UpdatedComponent.
---@return Pawn
function PawnMovementComponent.GetPawnOwner() end

---Return the last input vector in world space that was processed by ConsumeInputVector(), which is usually done by the Pawn or PawnMovementComponent.
---Any user that needs to know about the input that last affected movement should use this function.
---\@see AddInputVector(), ConsumeInputVector(), GetPendingInputVector()
---@return Vector
function PawnMovementComponent.GetLastInputVector() end

---Returns the pending input vector and resets it to zero.
---       * This should be used during a movement update (by the Pawn or PawnMovementComponent) to prevent accumulation of control input between frames.
---       * Copies the pending input vector to the saved input vector (GetLastMovementInputVector()).
---       * @return The pending input vector.
---@return Vector
function PawnMovementComponent.ConsumeInputVector() end

---Adds the given vector to the accumulated input in world space. Input vectors are usually between 0 and 1 in magnitude.
---They are accumulated during a frame then applied as acceleration during the movement update.
---\@see APawn::AddMovementInput()
---@param WorldVector Vector
---@param bForce boolean
---@return nil
function PawnMovementComponent.AddInputVector(WorldVector, bForce) end

return PawnMovementComponent
