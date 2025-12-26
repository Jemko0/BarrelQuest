---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class Pawn : Actor
---Pawn is the base class of all actors that can be possessed by players or AI.
---They are the physical representations of players and creatures in a level.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/Pawn/
---
--- Properties
---
---If true, this Pawn's pitch will be updated to match the Controller's ControlRotation pitch, if controlled by a PlayerController.
---@field bUseControllerRotationPitch boolean
---If true, this Pawn's yaw will be updated to match the Controller's ControlRotation yaw, if controlled by a PlayerController.
---@field bUseControllerRotationYaw boolean
---If true, this Pawn's roll will be updated to match the Controller's ControlRotation roll, if controlled by a PlayerController.
---@field bUseControllerRotationRoll boolean
---If set to false (default) given pawn instance will never affect navigation generation (but components could).
---Setting it to true will result in using regular AActor's navigation relevancy
---calculation to check if this pawn instance should affect navigation generation.
---@note Use SetCanAffectNavigationGeneration() to change this value at runtime.
---@note Modifying this value at runtime will result in any navigation change only if runtime navigation generation is enabled.
---@note Override UpdateNavigationRelevance() to propagate the flag to the desired components.
---\@see SetCanAffectNavigationGeneration(), UpdateNavigationRelevance()
---@field bCanAffectNavigationGeneration boolean
---@field bIsLocalViewTarget boolean
---Base eye height above collision center.
---@field BaseEyeHeight number
---Determines which PlayerController, if any, should automatically possess the pawn when the level starts or when the pawn is spawned.
---\@see AutoPossessAI
---@field AutoPossessPlayer integer
---Determines when the Pawn creates and is possessed by an AI Controller (on level start, when spawned, etc).
---Only possible if AIControllerClassRef is set, and ignored if AutoPossessPlayer is enabled.
---\@see AutoPossessPlayer
---@field AutoPossessAI EAutoPossessAI
---Replicated so we can see where remote clients are looking.
---@field RemoteViewPitch16 any
---@field RemoteViewPitch integer
---Default class to use when pawn is controlled by AI.
---@field AIControllerClass Class
---Controller of the last Actor that caused us damage.
---@field LastHitBy Controller
---Controller currently possessing this Actor
---@field Controller Controller
---Previous controller that was controlling this pawn since the last controller change notification
---@field PreviousController Controller
---Event called after a pawn's controller has changed, on the server and owning client. This will happen at the same time as the delegate on GameInstance
---@field ReceiveControllerChangedDelegate ReceiveControllerChangedDelegateDelegate
---Event called after a pawn has been restarted, usually by a possession change. This is called on the server for all pawns and the owning client for player pawns
---@field ReceiveRestartedDelegate ReceiveRestartedDelegateDelegate
---Accumulated control input vector, stored in world space. This is the pending input, which is cleared (zeroed) once consumed.
---\@see GetPendingMovementInputVector(), AddMovementInput()
---@field ControlInputVector Vector
---The last control input vector that was processed by ConsumeMovementInputVector().
---\@see GetLastMovementInputVector()
---@field LastControlInputVector Vector
---If set, then this InputComponent class will be used instead of the Input Settings' DefaultInputComponentClass
---@field OverrideInputComponentClass Class
local Pawn = {}

--- Methods
---Spawn default controller for this Pawn, and get possessed by it.
---@return nil
function Pawn.SpawnDefaultController() end

---Use SetCanAffectNavigationGeneration to change this value at runtime.
---Note that calling this function at runtime will result in any navigation change only if runtime navigation generation is enabled.
---@param bNewValue boolean
---@param bForceUpdate boolean
---@return nil
function Pawn.SetCanAffectNavigationGeneration(bNewValue, bForceUpdate) end

---Inform AIControllers that you've made a noise they might hear (they are sent a HearNoise message if they have bHearNoises==true)
---The instigator of this sound is the pawn which is used to call MakeNoise.
---@param Loudness number
---@param NoiseLocation Vector
---@param bUseNoiseMakerLocation boolean
---@param NoiseMaker Actor
---@return nil
function Pawn.PawnMakeNoise(Loudness, NoiseLocation, bUseNoiseMakerLocation, NoiseMaker) end

---Returns true if controlled by a human player (possessed by a PlayerController).        This returns true for players controlled by remote clients
---@return boolean
function Pawn.IsPlayerControlled() end

---Check if this actor is currently being controlled at all (the actor has a valid Controller, which will be false for remote clients)
---@return boolean
function Pawn.IsPawnControlled() end

---Helper to see if move input is ignored. If our controller is a PlayerController, checks Controller->IsMoveInputIgnored().
---@return boolean
function Pawn.IsMoveInputIgnored() end

---Is this pawn the ViewTarget of a local PlayerController?  Helpful for determining whether the pawn is
---visible/critical for any VFX.  NOTE: Technically there may be some cases where locally controlled pawns return
---false for this, such as if you are using a remote camera view of some sort.  But generally it will be true for
---locally controlled pawns, and it will always be true for pawns that are being spectated in-game or in Replays.
---@return boolean
function Pawn.IsLocallyViewed() end

---Returns true if controlled by a local (not network) Controller.
---@return boolean
function Pawn.IsLocallyControlled() end

---Is Controlled
---@return boolean
function Pawn.IsControlled() end

---Returns true if controlled by a bot.
---@return boolean
function Pawn.IsBotControlled() end

---Returns the Platform User ID of the PlayerController that is controlling this character.
---Returns an invalid Platform User ID if this character is not controlled by a local player.
---@return PlatformUserId
function Pawn.GetPlatformUserId() end

---Return the pending input vector in world space. This is the most up-to-date value of the input vector, pending ConsumeMovementInputVector() which clears it,
---Usually only a PawnMovementComponent will want to read this value, or the Pawn itself if it is responsible for movement.
---\@see AddMovementInput(), GetLastMovementInputVector(), ConsumeMovementInputVector()
---@return Vector
function Pawn.GetPendingMovementInputVector() end

---Get Override Input Component Class
---@return Class
function Pawn.GetOverrideInputComponentClass() end

---Basically retrieved pawn's location on navmesh
---@return Vector
function Pawn.GetNavAgentLocation() end

---Return our PawnMovementComponent, if we have one.
---@return PawnMovementComponent
function Pawn.GetMovementComponent() end

---Gets the owning actor of the Movement Base Component on which the pawn is standing.
---@param Pawn Pawn
---@return Actor
function Pawn.GetMovementBaseActor(Pawn) end

---Returns local Player Controller viewing this pawn, whether it is controlling or spectating
---@return PlayerController
function Pawn.GetLocalViewingPlayerController() end

---Return the last input vector in world space that was processed by ConsumeMovementInputVector(), which is usually done by the Pawn or PawnMovementComponent.
---Any user that needs to know about the input that last affected movement should use this function.
---For example an animation update would want to use this, since by default the order of updates in a frame is:
---PlayerController (device input) -> MovementComponent -> Pawn -> Mesh (animations)
---\@see AddMovementInput(), GetPendingMovementInputVector(), ConsumeMovementInputVector()
---@return Vector
function Pawn.GetLastMovementInputVector() end

---Get the rotation of the Controller, often the 'view' rotation of this Pawn.
---@return Rotator
function Pawn.GetControlRotation() end

---Returns controller for this actor.
---@return Controller
function Pawn.GetController() end

---Return the aim rotation for the Pawn.
---If we have a controller, by default we aim at the player's 'eyes' direction
---that is by default the Pawn rotation for AI, and camera (crosshair) rotation for human players.
---@return Rotator
function Pawn.GetBaseAimRotation() end

---Call this function to detach safely pawn from its controller, knowing that we will be destroyed soon.
---@return nil
function Pawn.DetachFromControllerPendingDestroy() end

---Returns the pending input vector and resets it to zero.
---This should be used during a movement update (by the Pawn or PawnMovementComponent) to prevent accumulation of control input between frames.
---Copies the pending input vector to the saved input vector (GetLastMovementInputVector()).
---@return Vector
function Pawn.ConsumeMovementInputVector() end

---Add movement input along the given world direction vector (usually normalized) scaled by 'ScaleValue'. If ScaleValue < 0, movement will be in the opposite direction.
---Base Pawn classes won't automatically apply movement, it's up to the user to do so in a Tick event. Subclasses such as Character and DefaultPawn automatically handle this input and move.
---\@see GetPendingMovementInputVector(), GetLastMovementInputVector(), ConsumeMovementInputVector()
---@param WorldDirection Vector
---@param ScaleValue number
---@param bForce boolean
---@return nil
function Pawn.AddMovementInput(WorldDirection, ScaleValue, bForce) end

---Add input (affecting Yaw) to the Controller's ControlRotation, if it is a local PlayerController.
---This value is multiplied by the PlayerController's InputYawScale value.
---\@see PlayerController::InputYawScale
---@param Val number
---@return nil
function Pawn.AddControllerYawInput(Val) end

---Add input (affecting Roll) to the Controller's ControlRotation, if it is a local PlayerController.
---This value is multiplied by the PlayerController's InputRollScale value.
---\@see PlayerController::InputRollScale
---@param Val number
---@return nil
function Pawn.AddControllerRollInput(Val) end

---Add input (affecting Pitch) to the Controller's ControlRotation, if it is a local PlayerController.
---This value is multiplied by the PlayerController's InputPitchScale value.
---\@see PlayerController::InputPitchScale
---@param Val number
---@return nil
function Pawn.AddControllerPitchInput(Val) end

return Pawn
