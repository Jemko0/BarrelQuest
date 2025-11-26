---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Character : Pawn
---Characters are Pawns that have a mesh, collision, and built-in movement logic.
---They are responsible for all physical interaction between the player or AI and the world, and also implement basic networking and input models.
---They are designed for a vertically-oriented player representation that can walk, jump, fly, and swim through the world using CharacterMovementComponent.
---@see APawn, UCharacterMovementComponent
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/Pawn/Character/
---
--- Properties
---
---Info about our current movement base (object we are standing on).
---@field BasedMovement BasedMovementInfo
---Replicated version of relative movement. Read-only on simulated proxies!
---@field ReplicatedBasedMovement BasedMovementInfo
---CharacterMovement ServerLastTransformUpdateTimeStamp value, replicated to simulated proxies.
---@field ReplicatedServerLastTransformUpdateTimeStamp number
---@field ReplayLastTransformUpdateTimeStamp number
---Saved rotation offset of mesh.
---@field BaseRotationOffset Quat
---Saved translation offset of mesh.
---@field BaseTranslationOffset Vector
---CharacterMovement Custom gravity direction replicated for simulated proxies.
---@field ReplicatedGravityDirection Vector_NetQuantizeNormal
---Scale to apply to root motion translation on this Character
---@field AnimRootMotionTranslationScale number
---Default crouched eye height
---@field CrouchedEyeHeight number
---Flag that we are receiving replication of the based movement.
---@field bInBaseReplication boolean
---Set by character movement to specify that this Character is currently crouched.
---@field bIsCrouched boolean
---Set to indicate that this Character is currently under the force of a jump (if JumpMaxHoldTime is non-zero). IsJumpProvidingForce() handles this as well.
---@field bProxyIsJumpForceApplied boolean
---When true, player wants to jump
---@field bPressedJump boolean
---When true, applying updates to network client (replaying saved moves for a locally controlled character)
---@field bClientUpdating boolean
---True if Pawn was initially falling when started to replay network moves.
---@field bClientWasFalling boolean
---If server disagrees with root motion track position, client has to resimulate root motion from last AckedMove.
---@field bClientResimulateRootMotion boolean
---If server disagrees with root motion state, client has to resimulate root motion from last AckedMove.
---@field bClientResimulateRootMotionSources boolean
---Disable simulated gravity (set when character encroaches geometry on client, to keep it from falling through floors)
---@field bSimGravityDisabled boolean
---@field bClientCheckEncroachmentOnNetUpdate boolean
---Disable root motion on the server. When receiving a DualServerMove, where the first move is not root motion and the second is.
---@field bServerMoveIgnoreRootMotion boolean
---Tracks whether or not the character was already jumping last frame.
---@field bWasJumping boolean
---CharacterMovement MovementMode (and custom mode) replicated for simulated proxies. Use CharacterMovementComponent::UnpackNetworkMovementMode() to translate it.
---@field ReplicatedMovementMode integer
---Jump key Held Time.
---This is the time that the player has held the jump key, in seconds.
---@field JumpKeyHoldTime number
---Amount of jump force time remaining, if JumpMaxHoldTime > 0.
---@field JumpForceTimeRemaining number
---Track last time a jump force started for a proxy.
---@field ProxyJumpForceStartedTime number
---The max time the jump key can be held.
---Note that if StopJumping() is not called before the max jump hold time is reached,
---then the character will carry on receiving vertical velocity. Therefore it is usually
---best to call StopJumping() when jump input has ceased (such as a button up event).
---@field JumpMaxHoldTime number
---The max number of jumps the character can perform.
---Note that if JumpMaxHoldTime is non zero and StopJumping is not called, the player
---may be able to perform and unlimited number of jumps. Therefore it is usually
---best to call StopJumping() when jump input has ceased (such as a button up event).
---@field JumpMaxCount integer
---Tracks the current number of jumps performed.
---This is incremented in CheckJumpInput, used in CanJump_Implementation, and reset in OnMovementModeChanged.
---When providing overrides for these methods, it's recommended to either manually
---increment / reset this value, or call the Super:: method.
---@field JumpCurrentCount integer
---Represents the current number of jumps performed before CheckJumpInput modifies JumpCurrentCount.
---This is set in CheckJumpInput and is used in SetMoveFor and PrepMoveFor instead of JumpCurrentCount
---since CheckJumpInput can modify JumpCurrentCount.
---When providing overrides for these methods, it's recommended to either manually
---set this value, or call the Super:: method.
---@field JumpCurrentCountPreJump integer
---Broadcast when Character's jump reaches its apex. Needs CharacterMovement->bNotifyApex = true
---@field OnReachedJumpApex function
---Called upon landing when falling, to perform actions based on the Hit result.
---Note that movement mode is still "Falling" during this event. Current Velocity value is the velocity at the time of landing.
---Consider OnMovementModeChanged() as well, as that can be used once the movement mode changes to the new mode (most likely Walking).
---@param Hit Result describing the landing that resulted in a valid landing spot.
---\@see OnMovementModeChanged()
---@field LandedDelegate function
---Multicast delegate for MovementMode changing.
---@field MovementModeChangedDelegate function
---Event triggered at the end of a CharacterMovementComponent movement update.
---This is the preferred event to use rather than the Tick event when performing custom updates to CharacterMovement properties based on the current state.
---This is mainly due to the nature of network updates, where client corrections in position from the server can cause multiple iterations of a movement update,
---which allows this event to update as well, while a Tick event would not.
---@param       DeltaSeconds            Delta time in seconds for this update
---@param       InitialLocation         Location at the start of the update. May be different than the current location if movement occurred.
---@param       InitialVelocity         Velocity at the start of the update. May be different than the current velocity.
---@field OnCharacterMovementUpdated function
---For LocallyControlled Autonomous clients.
---During a PerformMovement() after root motion is prepared, we save it off into this and
---then record it into our SavedMoves.
---During SavedMove playback we use it as our "Previous Move" SavedRootMotion which includes
---last received root motion from the Server
---@field SavedRootMotion RootMotionSourceGroup
---For LocallyControlled Autonomous clients. Saved root motion data to be used by SavedMoves.
---@field ClientRootMotionParams RootMotionMovementParams
---Array of previously received root motion moves from the server.
---@field RootMotionRepMoves SimulatedRootMotionReplicatedMove[]
---Replicated Root Motion montage
---@field RepRootMotion RepRootMotionMontage
local Character = {}

--- Methods
---Request the character to stop crouching. The request is processed on the next update of the CharacterMovementComponent.
---\@see OnEndCrouch
---\@see IsCrouched
---\@see CharacterMovement->WantsToCrouch
---@param bClientSimulation boolean
---@return nil
function Character.UnCrouch(bClientSimulation) end

---Stop the character from jumping on the next update.
---Call this from an input event (such as a button 'up' event) to cease applying
---jump Z-velocity. If this is not called, then jump z-velocity will be applied
---until JumpMaxHoldTime is reached.
---@return nil
function Character.StopJumping() end

---Stop Animation Montage. If nullptr, it will stop what's currently active. The Blend Out Time is taken from the montage asset that is being stopped. *
---@param AnimMontage AnimMontage
---@return nil
function Character.StopAnimMontage(AnimMontage) end

---Play Animation Montage on the character mesh. Returns the length of the animation montage in seconds, or 0.f if failed to play. *
---@param AnimMontage AnimMontage
---@param InPlayRate number
---@param StartSectionName string
---@return number
function Character.PlayAnimMontage(AnimMontage, InPlayRate, StartSectionName) end

---Set a pending launch velocity on the Character. This velocity will be processed on the next CharacterMovementComponent tick,
---and will set it to the "falling" state. Triggers the OnLaunched event.
---@param LaunchVelocity Vector
---@param bXYOverride boolean
---@param bZOverride boolean
---@return nil
function Character.LaunchCharacter(LaunchVelocity, bXYOverride, bZOverride) end

---Make the character jump on the next update.
---If you want your character to jump according to the time that the jump key is held,
---then you can set JumpMaxHoldTime to some non-zero value. Make sure in this case to
---call StopJumping() when you want the jump's z-velocity to stop being applied (such
---as on a button up event), otherwise the character will carry on receiving the
---velocity until JumpKeyHoldTime reaches JumpMaxHoldTime.
---@return nil
function Character.Jump() end

---True if we are playing Anim root motion right now
---@return boolean
function Character.IsPlayingRootMotion() end

---True if we are playing Root Motion right now, through a Montage with RootMotionMode == ERootMotionMode::RootMotionFromMontagesOnly.
---This means code path for networked root motion is enabled.
---@return boolean
function Character.IsPlayingNetworkedRootMotionMontage() end

---True if jump is actively providing a force, such as when the jump key is held and the time it has been held is less than JumpMaxHoldTime.
---\@see CharacterMovement->IsFalling
---@return boolean
function Character.IsJumpProvidingForce() end

---True if we are playing root motion from any source right now (anim root motion, root motion source)
---@return boolean
function Character.HasAnyRootMotion() end

---Return current playing Montage *
---@return AnimMontage
function Character.GetCurrentMontage() end

---Get the saved translation offset of mesh. This is how much extra offset is applied from the center of the capsule.
---@return Vector
function Character.GetBaseTranslationOffset() end

---Get the saved rotation offset of mesh. This is how much extra rotation is applied from the capsule rotation.
---@return Rotator
function Character.GetBaseRotationOffsetRotator() end

---Scale to apply to root motion translation on this Character. Returns current value of AnimRootMotionScale.
---@return number
function Character.GetAnimRootMotionTranslationScale() end

---Request the character to start crouching. The request is processed on the next update of the CharacterMovementComponent.
---\@see OnStartCrouch
---\@see IsCrouched
---\@see CharacterMovement->WantsToCrouch
---@param bClientSimulation boolean
---@return nil
function Character.Crouch(bClientSimulation) end

---Check if the character can jump in the current state.
---The default implementation may be overridden or extended by implementing the custom CanJump event in Blueprints.
---@return boolean
function Character.CanJump() end

---@return boolean
function Character.CanCrouch() end

---Cache mesh offset from capsule. This is used as the target for network smoothing interpolation, when the mesh is offset with lagged smoothing.
---This is automatically called during initialization; call this at runtime if you intend to change the default mesh offset from the capsule.
---\@see GetBaseTranslationOffset(), GetBaseRotationOffset()
---@param MeshRelativeLocation Vector
---@param MeshRelativeRotation Rotator
---@return nil
function Character.CacheInitialMeshOffset(MeshRelativeLocation, MeshRelativeRotation) end

return Character
