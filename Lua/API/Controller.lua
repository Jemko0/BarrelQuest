---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Controller : Actor
---Controllers are non-physical actors that can possess a Pawn to control
---its actions.  PlayerControllers are used by human players to control pawns, while
---AIControllers implement the artificial intelligence for the pawns they control.
---Controllers take control of a pawn using their Possess() method, and relinquish
---control of the pawn by calling UnPossess().
---Controllers receive notifications for many of the events occurring for the Pawn they
---are controlling.  This gives the controller the opportunity to implement the behavior
---in response to this event, intercepting the event and superseding the Pawn's default
---behavior.
---ControlRotation (accessed via GetControlRotation()), determines the viewing/aiming
---direction of the controlled Pawn and is affected by input such as from a mouse or gamepad.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/Controller/
---
--- Properties
---
---PlayerState containing replicated information about the player using this controller (only exists for players, not NPCs).
---@field PlayerState PlayerState
---Called when the controller has instigated damage in any way
---@field OnInstigatedAnyDamage function
---Called on both authorities and clients when the possessed pawn changes (either OldPawn or NewPawn might be nullptr)
---@field OnPossessedPawnChanged function
---Current gameplay state this controller is in
---@field StateName string
---The control rotation of the Controller. See GetControlRotation.
---@field ControlRotation Rotator
---If true, the controller location will match the possessed Pawn's location. If false, it will not be updated. Rotation will match ControlRotation in either case.
---Since a Controller's location is normally inaccessible, this is intended mainly for purposes of being able to attach
---an Actor that follows the possessed Pawn location, but that still has the full aim rotation (since a Pawn might
---update only some components of the rotation).
---@field bAttachToPawn boolean
local Controller = {}

--- Methods
---Called to unpossess our pawn for any reason that is not the pawn being destroyed (destruction handled by PawnDestroyed()).
---@return nil
function Controller.UnPossess() end

---Aborts the move the controller is currently performing
---@return nil
function Controller.StopMovement() end

---Set the initial location and rotation of the controller, as well as the control rotation. Typically used when the controller is first created.
---@return nil
function Controller.SetInitialLocationAndRotation() end

---Locks or unlocks movement input, consecutive calls stack up and require the same amount of calls to undo, or can all be undone using ResetIgnoreMoveInput.
---@param bNewMoveInput boolean
---@return nil
function Controller.SetIgnoreMoveInput(bNewMoveInput) end

---Locks or unlocks look input, consecutive calls stack up and require the same amount of calls to undo, or can all be undone using ResetIgnoreLookInput.
---@param bNewLookInput boolean
---@return nil
function Controller.SetIgnoreLookInput(bNewLookInput) end

---Set the control rotation.
---@return nil
function Controller.SetControlRotation() end

---Stops ignoring move input by resetting the ignore move input state.
---@return nil
function Controller.ResetIgnoreMoveInput() end

---Stops ignoring look input by resetting the ignore look input state.
---@return nil
function Controller.ResetIgnoreLookInput() end

---Reset move and look input ignore flags.
---@return nil
function Controller.ResetIgnoreInputFlags() end

---Handles attaching this controller to the specified pawn.
---Only runs on the network authority (where HasAuthority() returns true).
---Derived native classes can override OnPossess to filter the specified pawn.
---When possessed pawn changed, blueprint class gets notified by ReceivePossess
---and OnNewPawn delegate is broadcasted.
---\@see HasAuthority, OnPossess, ReceivePossess
---@param InPawn Pawn
---@return nil
function Controller.Possess(InPawn) end

---Checks line to center and top of other actor
---@param Other Actor
---@param ViewPoint Vector
---@param bAlternateChecks boolean
---@return boolean
function Controller.LineOfSightTo(Other, ViewPoint, bAlternateChecks) end

---Return the Pawn that is currently 'controlled' by this PlayerController
---@return Pawn
function Controller.K2_GetPawn() end

---Returns whether this Controller is a PlayerController.
---@return boolean
function Controller.IsPlayerController() end

---Returns true if movement input is ignored.
---@return boolean
function Controller.IsMoveInputIgnored() end

---Returns true if look input is ignored.
---@return boolean
function Controller.IsLookInputIgnored() end

---Returns whether this Controller is a locally controlled PlayerController.
---@return boolean
function Controller.IsLocalPlayerController() end

---Returns whether this Controller is a local controller.
---@return boolean
function Controller.IsLocalController() end

---Get the actor the controller is looking at
---@return Actor
function Controller.GetViewTarget() end

---Returns Player's Point of View
---For the AI this means the Pawn's 'Eyes' ViewPoint
---For a Human player, this means the Camera's ViewPoint
---@output      out_Location, view location of player
---@output      out_rotation, view rotation of player
---@return nil, Vector, Rotator
function Controller.GetPlayerViewPoint() end

---Get the desired pawn target rotation
---@return Rotator
function Controller.GetDesiredRotation() end

---Get the control rotation. This is the full aim rotation, which may be different than a camera orientation (for example in a third person view),
---and may differ from the rotation of the controlled Pawn (which may choose not to visually pitch or roll, for example).
---@return Rotator
function Controller.GetControlRotation() end

return Controller
