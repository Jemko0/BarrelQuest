---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CharacterMovementComponent : PawnMovementComponent
---CharacterMovementComponent handles movement logic for the associated Character owner.
---It supports various movement modes including: walking, falling, swimming, flying, custom.
---Movement is affected primarily by current Velocity and Acceleration. Acceleration is updated each frame
---based on the input vector accumulated thus far (see UPawnMovementComponent::GetPendingInputVector()).
---Networking is fully implemented, with server-client correction and prediction included.
---@see ACharacter, UPawnMovementComponent
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/Pawn/Character/
---
--- Properties
---Character movement component belongs to
---@field CharacterOwner Character
---Custom gravity scale. Gravity is multiplied by this amount for the character.
---@field GravityScale number
---Maximum height character can step up
---@field MaxStepHeight number
---Initial velocity (instantaneous vertical acceleration) when jumping.
---@field JumpZVelocity number
---Fraction of JumpZVelocity to use when automatically "jumping off" of a base actor that's not allowed to be a base for a character. (For example, if you're not allowed to stand on other players.)
---@field JumpOffJumpZFactor number
---Actor's current movement mode (walking, falling, etc).
---   - walking:  Walking on a surface, under the effects of friction, and able to "step up" barriers. Vertical velocity is zero.
---   - falling:  Falling under the effects of gravity, after jumping or walking off the edge of a surface.
---   - flying:   Flying, ignoring the effects of gravity.
---   - swimming: Swimming through a fluid volume, under the effects of gravity and buoyancy.
---   - custom:   User-defined custom movement mode, including many possible sub-modes.
---This is automatically replicated through the Character owner and for client-server movement functions.
---@see SetMovementMode(), CustomMovementMode
---@field MovementMode integer
---Current custom sub-mode if MovementMode is set to Custom.
---This is automatically replicated through the Character owner and for client-server movement functions.
---@see SetMovementMode()
---@field CustomMovementMode integer
---Smoothing mode for simulated proxies in network game.
---@field NetworkSmoothingMode ENetworkSmoothingMode
---Setting that affects movement control. Higher values allow faster changes in direction.
---If bUseSeparateBrakingFriction is false, also affects the ability to stop more quickly when braking (whenever Acceleration is zero), where it is multiplied by BrakingFrictionFactor.
---When braking, this property allows you to control how much friction is applied when moving across the ground, applying an opposing force that scales with current velocity.
---This can be used to simulate slippery surfaces such as ice or oil by changing the value (possibly based on the material pawn is standing on).
---@see BrakingDecelerationWalking, BrakingFriction, bUseSeparateBrakingFriction, BrakingFrictionFactor
---@field GroundFriction number
---The maximum ground speed when walking. Also determines maximum lateral speed when falling.
---@field MaxWalkSpeed number
---The maximum ground speed when walking and crouched.
---@field MaxWalkSpeedCrouched number
---The maximum swimming speed.
---@field MaxSwimSpeed number
---The maximum flying speed.
---@field MaxFlySpeed number
---The maximum speed when using Custom movement mode.
---@field MaxCustomMovementSpeed number
---Max Acceleration (rate of change of velocity)
---@field MaxAcceleration number
---The ground speed that we should accelerate up to when walking at minimum analog stick tilt
---@field MinAnalogWalkSpeed number
---Factor used to multiply actual value of friction used when braking.
---This applies to any friction value that is currently used, which may depend on bUseSeparateBrakingFriction.
---@note This is 2 by default for historical reasons, a value of 1 gives the true drag equation.
---@see bUseSeparateBrakingFriction, GroundFriction, BrakingFriction
---@field BrakingFrictionFactor number
---Friction (drag) coefficient applied when braking (whenever Acceleration = 0, or if character is exceeding max speed); actual value used is this multiplied by BrakingFrictionFactor.
---When braking, this property allows you to control how much friction is applied when moving across the ground, applying an opposing force that scales with current velocity.
---Braking is composed of friction (velocity-dependent drag) and constant deceleration.
---This is the current value, used in all movement modes; if this is not desired, override it or bUseSeparateBrakingFriction when movement mode changes.
---@note Only used if bUseSeparateBrakingFriction setting is true, otherwise current friction such as GroundFriction is used.
---@see bUseSeparateBrakingFriction, BrakingFrictionFactor, GroundFriction, BrakingDecelerationWalking
---@field BrakingFriction number
---Time substepping when applying braking friction. Smaller time steps increase accuracy at the slight cost of performance, especially if there are large frame times.
---@field BrakingSubStepTime number
---Deceleration when walking and not applying acceleration. This is a constant opposing force that directly lowers velocity by a constant value.
---@see GroundFriction, MaxAcceleration
---@field BrakingDecelerationWalking number
---Lateral deceleration when falling and not applying acceleration.
---@see MaxAcceleration
---@field BrakingDecelerationFalling number
---Deceleration when swimming and not applying acceleration.
---@see MaxAcceleration
---@field BrakingDecelerationSwimming number
---Deceleration when flying and not applying acceleration.
---@see MaxAcceleration
---@field BrakingDecelerationFlying number
---When falling, amount of lateral movement control available to the character.
---0 = no control, 1 = full control at max speed of MaxWalkSpeed.
---@field AirControl number
---When falling, multiplier applied to AirControl when lateral velocity is less than AirControlBoostVelocityThreshold.
---Setting this to zero will disable air control boosting. Final result is clamped at 1.
---@field AirControlBoostMultiplier number
---When falling, if lateral velocity magnitude is less than this value, AirControl is multiplied by AirControlBoostMultiplier.
---Setting this to zero will disable air control boosting.
---@field AirControlBoostVelocityThreshold number
---Friction to apply to lateral air movement when falling.
---If bUseSeparateBrakingFriction is false, also affects the ability to stop more quickly when braking (whenever Acceleration is zero).
---@see BrakingFriction, bUseSeparateBrakingFriction
---@field FallingLateralFriction number
---@field CrouchedHalfHeight number
---Water buoyancy. A ratio (1.0 = neutral buoyancy, 0.0 = no buoyancy)
---@field Buoyancy number
---Don't allow the character to perch on the edge of a surface if the contact is this close to the edge of the capsule.
---Note that characters will not fall off if they are within MaxStepHeight of a walkable surface below.
---@field PerchRadiusThreshold number
---When perching on a ledge, add this additional distance to MaxStepHeight when determining how high above a walkable floor we can perch.
---Note that we still enforce MaxStepHeight to start the step up; this just allows the character to hang off the edge or step slightly higher off the floor.
---(@see PerchRadiusThreshold)
---@field PerchAdditionalHeight number
---Change in rotation per second, used when UseControllerDesiredRotation or OrientRotationToMovement are true. Set a negative value for infinite rotation rate and instant turns.
---@field RotationRate Rotator
---If true, BrakingFriction will be used to slow the character to a stop (when there is no Acceleration).
---If false, braking uses the same friction passed to CalcVelocity() (ie GroundFriction when walking), multiplied by BrakingFrictionFactor.
---This setting applies to all movement modes; if only desired in certain modes, consider toggling it when movement modes change.
---@see BrakingFriction
---@field bUseSeparateBrakingFriction boolean
---True means while the jump key is held, we will not allow the vertical speed to fall below the JumpZVelocity tuning value
---even if a stronger force, such as gravity, is opposing the jump.
---@field bDontFallBelowJumpZVelocityDuringJump boolean
---Apply gravity while the character is actively jumping (e.g. holding the jump key).
---Helps remove frame-rate dependent jump height, but may alter base jump height.
---@field bApplyGravityWhileJumping boolean
---If true, smoothly rotate the Character toward the Controller's desired rotation (typically Controller->ControlRotation), using RotationRate as the rate of rotation change. Overridden by OrientRotationToMovement.
---Normally you will want to make sure that other settings are cleared, such as bUseControllerRotationYaw on the Character.
---@field bUseControllerDesiredRotation boolean
---If true, rotate the Character toward the direction of acceleration, using RotationRate as the rate of rotation change. Overrides UseControllerDesiredRotation.
---Normally you will want to make sure that other settings are cleared, such as bUseControllerRotationYaw on the Character.
---@field bOrientRotationToMovement boolean
---Whether or not the character should sweep for collision geometry while walking.
---@see USceneComponent::MoveComponent.
---@field bSweepWhileNavWalking boolean
---True during movement update.
---Used internally so that attempts to change CharacterOwner and UpdatedComponent are deferred until after an update.
---@see IsMovementInProgress()
---@field bMovementInProgress boolean
---If true, high-level movement updates will be wrapped in a movement scope that accumulates updates and defers a bulk of the work until the end.
---When enabled, touch and hit events will not be triggered until the end of multiple moves within an update, which can improve performance.
---@see FScopedMovementUpdate
---@field bEnableScopedMovementUpdates boolean
---Optional scoped movement update to combine moves for cheaper performance on the server when the client sends two moves in one packet.
---Be warned that since this wraps a larger scope than is normally done with bEnableScopedMovementUpdates, this can result in subtle changes in behavior
---in regards to when overlap events are handled, when attached components are moved, etc.
---@see bEnableScopedMovementUpdates
---@field bEnableServerDualMoveScopedMovementUpdates boolean
---Ignores size of acceleration component, and forces max acceleration to drive character at full velocity.
---@field bForceMaxAccel boolean
---If true, movement will be performed even if there is no Controller for the Character owner.
---Normally without a Controller, movement will be aborted and velocity and acceleration are zeroed if the character is walking.
---Characters that are spawned without a Controller but with this flag enabled will initialize the movement mode to DefaultLandMovementMode or DefaultWaterMovementMode appropriately.
---@see DefaultLandMovementMode, DefaultWaterMovementMode
---@field bRunPhysicsWithNoController boolean
---Force the Character in MOVE_Walking to do a check for a valid floor even if it hasn't moved. Cleared after next floor check.
---Normally if bAlwaysCheckFloor is false we try to avoid the floor check unless some conditions are met, but this can be used to force the next check to always run.
---@field bForceNextFloorCheck boolean
---If true, the capsule needs to be shrunk on this simulated proxy, to avoid replication rounding putting us in geometry.
---Whenever this is set to true, this will cause the capsule to be shrunk again on the next update, and then set to false.
---@field bShrinkProxyCapsule boolean
---If true, Character can walk off a ledge.
---@field bCanWalkOffLedges boolean
---If true, Character can walk off a ledge when crouching.
---@field bCanWalkOffLedgesWhenCrouching boolean
---Whether we skip prediction on frames where a proxy receives a network update. This can avoid expensive prediction on those frames,
---with the side-effect of predicting with a frame of additional latency.
---@field bNetworkSkipProxyPredictionOnNetUpdate boolean
---Flag used on the server to determine whether to always replicate ReplicatedServerLastTransformUpdateTimeStamp to clients.
---Normally this is only sent when the network smoothing mode on character movement is set to Linear smoothing (on the server), to save bandwidth.
---Setting this to true will force the timestamp to replicate regardless, in case the server doesn't know about the smoothing mode, or if the timestamp is used for another purpose.
---@field bNetworkAlwaysReplicateTransformUpdateTimestamp boolean
---true to update CharacterOwner and UpdatedComponent after movement ends
---@field bDeferUpdateMoveComponent boolean
---If enabled, the player will interact with physics objects when walking into them.
---@field bEnablePhysicsInteraction boolean
---If enabled, the TouchForceFactor is applied per kg mass of the affected object.
---@field bTouchForceScaledToMass boolean
---If enabled, the PushForceFactor is applied per kg mass of the affected object.
---@field bPushForceScaledToMass boolean
---If enabled, the PushForce location is moved using PushForcePointZOffsetFactor. Otherwise simply use the impact point.
---@field bPushForceUsingZOffset boolean
---If enabled, the applied push force will try to get the physics object to the same velocity than the player, not faster. This will only
---              scale the force down, it will never apply more force than defined by PushForceFactor.
---@field bScalePushForceToVelocity boolean
---What to update CharacterOwner and UpdatedComponent after movement ends
---@field DeferredUpdatedMoveComponent SceneComponent
---Maximum step height for getting out of water
---@field MaxOutOfWaterStepHeight number
---Z velocity applied when pawn tries to get out of water
---@field OutofWaterZ number
---Mass of pawn (for when momentum is imparted to it).
---@field Mass number
---Force applied to objects we stand on (due to Mass and Gravity) is scaled by this amount.
---@field StandingDownwardForceScale number
---Initial impulse force to apply when the player bounces into a blocking physics object.
---@field InitialPushForceFactor number
---Force to apply when the player collides with a blocking physics object.
---@field PushForceFactor number
---Z-Offset for the position the force is applied to. 0.0f is the center of the physics object, 1.0f is the top and -1.0f is the bottom of the object.
---@field PushForcePointZOffsetFactor number
---Force to apply to physics objects that are touched by the player.
---@field TouchForceFactor number
---Minimum Force applied to touched physics objects. If < 0.0f, there is no minimum.
---@field MinTouchForce number
---Maximum force applied to touched physics objects. If < 0.0f, there is no maximum.
---@field MaxTouchForce number
---Force per kg applied constantly to all overlapping components.
---@field RepulsionForce number
---Deprecated properties
---@field bForceBraking boolean
---Multiplier to max ground speed to use when crouched
---@field CrouchedSpeedMultiplier number
---@field UpperImpactNormalScale number
---Current acceleration vector (with magnitude).
---This is calculated each update based on the input vector and the constraints of MaxAcceleration and the current movement mode.
---@field Acceleration Vector
---Rotation after last PerformMovement or SimulateMovement update.
---@field LastUpdateRotation Quat
---Location after last PerformMovement or SimulateMovement update. Used internally to detect changes in position from outside character movement to try to validate the current floor.
---@field LastUpdateLocation Vector
---Velocity after last PerformMovement or SimulateMovement update. Used internally to detect changes in velocity from external sources.
---@field LastUpdateVelocity Vector
---Timestamp when location or rotation last changed during an update. Only valid on the server.
---@field ServerLastTransformUpdateTimeStamp number
---Timestamp of last client adjustment sent. See NetworkMinTimeBetweenClientAdjustments.
---@field ServerLastClientGoodMoveAckTime number
---Timestamp of last client adjustment sent. See NetworkMinTimeBetweenClientAdjustments.
---@field ServerLastClientAdjustmentTime number
---Accumulated impulse to be added next tick.
---@field PendingImpulseToApply Vector
---Accumulated force to be added next tick.
---@field PendingForceToApply Vector
---Modifier to applied to values such as acceleration and max speed due to analog input.
---@field AnalogInputModifier number
---Max time delta for each discrete simulation step.
---Used primarily in the the more advanced movement modes that break up larger time steps (usually those applying gravity such as falling and walking).
---Lowering this value can address issues with fast-moving objects or complex collision scenarios, at the cost of performance.
---WARNING: if (MaxSimulationTimeStep * MaxSimulationIterations) is too low for the min framerate, the last simulation step may exceed MaxSimulationTimeStep to complete the simulation.
---@see MaxSimulationIterations
---@field MaxSimulationTimeStep number
---Max number of iterations used for each discrete simulation step.
---Used primarily in the the more advanced movement modes that break up larger time steps (usually those applying gravity such as falling and walking).
---Increasing this value can address issues with fast-moving objects or complex collision scenarios, at the cost of performance.
---WARNING: if (MaxSimulationTimeStep * MaxSimulationIterations) is too low for the min framerate, the last simulation step may exceed MaxSimulationTimeStep to complete the simulation.
---@see MaxSimulationTimeStep
---@field MaxSimulationIterations integer
---Max number of attempts per simulation to attempt to exactly reach the jump apex when falling movement reaches the top of the arc.
---Limiting this prevents deep recursion when special cases cause collision or other conditions which reactivate the apex condition.
---@field MaxJumpApexAttemptsPerSimulation integer
---Max distance we allow simulated proxies to depenetrate when moving out of anything but Pawns.
---This is generally more tolerant than with Pawns, because other geometry is either not moving, or is moving predictably with a bit of delay compared to on the server.
---@see MaxDepenetrationWithGeometryAsProxy, MaxDepenetrationWithPawn, MaxDepenetrationWithPawnAsProxy
---@field MaxDepenetrationWithGeometry number
---Max distance we allow simulated proxies to depenetrate when moving out of anything but Pawns.
---This is generally more tolerant than with Pawns, because other geometry is either not moving, or is moving predictably with a bit of delay compared to on the server.
---@see MaxDepenetrationWithGeometry, MaxDepenetrationWithPawn, MaxDepenetrationWithPawnAsProxy
---@field MaxDepenetrationWithGeometryAsProxy number
---Max distance we are allowed to depenetrate when moving out of other Pawns.
---@see MaxDepenetrationWithGeometry, MaxDepenetrationWithGeometryAsProxy, MaxDepenetrationWithPawnAsProxy
---@field MaxDepenetrationWithPawn number
---Max distance we allow simulated proxies to depenetrate when moving out of other Pawns.
---Typically we don't want a large value, because we receive a server authoritative position that we should not then ignore by pushing them out of the local player.
---@see MaxDepenetrationWithGeometry, MaxDepenetrationWithGeometryAsProxy, MaxDepenetrationWithPawn
---@field MaxDepenetrationWithPawnAsProxy number
---How long to take to smoothly interpolate from the old pawn position on the client to the corrected one sent by the server. Not used by Linear smoothing.
---@field NetworkSimulatedSmoothLocationTime number
---How long to take to smoothly interpolate from the old pawn rotation on the client to the corrected one sent by the server. Not used by Linear smoothing.
---@field NetworkSimulatedSmoothRotationTime number
---Similar setting as NetworkSimulatedSmoothLocationTime but only used on Listen servers.
---@field ListenServerNetworkSimulatedSmoothLocationTime number
---Similar setting as NetworkSimulatedSmoothRotationTime but only used on Listen servers.
---@field ListenServerNetworkSimulatedSmoothRotationTime number
---Shrink simulated proxy capsule radius by this amount, to account for network rounding that may cause encroachment. Changing during gameplay is not supported.
---@see AdjustProxyCapsuleSize()
---@field NetProxyShrinkRadius number
---Shrink simulated proxy capsule half height by this amount, to account for network rounding that may cause encroachment. Changing during gameplay is not supported.
---@see AdjustProxyCapsuleSize()
---@field NetProxyShrinkHalfHeight number
---Maximum distance character is allowed to lag behind server location when interpolating between updates.
---@field NetworkMaxSmoothUpdateDistance number
---Maximum distance beyond which character is teleported to the new server location without any smoothing.
---@field NetworkNoSmoothUpdateDistance number
---Minimum time on the server between acknowledging good client moves. This can save on bandwidth. Set to 0 to disable throttling.
---@field NetworkMinTimeBetweenClientAckGoodMoves number
---Minimum time on the server between sending client adjustments when client has exceeded allowable position error.
---Should be >= NetworkMinTimeBetweenClientAdjustmentsLargeCorrection (the larger value is used regardless).
---This can save on bandwidth. Set to 0 to disable throttling.
---@see ServerLastClientAdjustmentTime
---@field NetworkMinTimeBetweenClientAdjustments number
---Minimum time on the server between sending client adjustments when client has exceeded allowable position error by a large amount (NetworkLargeClientCorrectionDistance).
---Should be <= NetworkMinTimeBetweenClientAdjustments (the smaller value is used regardless).
---@see NetworkMinTimeBetweenClientAdjustments
---@field NetworkMinTimeBetweenClientAdjustmentsLargeCorrection number
---If client error is larger than this, sets bNetworkLargeClientCorrection to reduce delay between client adjustments.
---@see NetworkMinTimeBetweenClientAdjustments, NetworkMinTimeBetweenClientAdjustmentsLargeCorrection
---@field NetworkLargeClientCorrectionDistance number
---Used in determining if pawn is going off ledge.  If the ledge is "shorter" than this value then the pawn will be able to walk off it. *
---@field LedgeCheckThreshold number
---When exiting water, jump if control pitch angle is this high or above.
---@field JumpOutOfWaterPitch number
---Information about the floor the Character is standing on (updated only during walking movement).
---@field CurrentFloor FindFloorResult
---Default movement mode when not in water. Used at player startup or when teleported.
---@see DefaultWaterMovementMode
---@see bRunPhysicsWithNoController
---@field DefaultLandMovementMode integer
---Default movement mode when in water. Used at player startup or when teleported.
---@see DefaultLandMovementMode
---@see bRunPhysicsWithNoController
---@field DefaultWaterMovementMode integer
---If true, walking movement always maintains horizontal velocity when moving up ramps, which causes movement up ramps to be faster parallel to the ramp surface.
---If false, then walking movement maintains velocity magnitude parallel to the ramp surface.
---@field bMaintainHorizontalGroundVelocity boolean
---If true, impart the base actor's X velocity when falling off it (which includes jumping)
---@field bImpartBaseVelocityX boolean
---If true, impart the base actor's Y velocity when falling off it (which includes jumping)
---@field bImpartBaseVelocityY boolean
---If true, impart the base actor's Z velocity when falling off it (which includes jumping)
---@field bImpartBaseVelocityZ boolean
---If true, impart the base component's tangential components of angular velocity when jumping or falling off it.
---Only those components of the velocity allowed by the separate component settings (bImpartBaseVelocityX etc) will be applied.
---@see bImpartBaseVelocityX, bImpartBaseVelocityY, bImpartBaseVelocityZ
---@field bImpartBaseAngularVelocity boolean
---Used by movement code to determine if a change in position is based on normal movement or a teleport. If not a teleport, velocity can be recomputed based on the change in position.
---@field bJustTeleported boolean
---True when a network replication update is received for simulated proxies.
---@field bNetworkUpdateReceived boolean
---True when the networked movement mode has been replicated.
---@field bNetworkMovementModeChanged boolean
---True when the networked gravity direction has been replicated.
---@field bNetworkGravityDirectionChanged boolean
---If true, we should ignore server location difference checks for client error on this movement component.
---This can be useful when character is moving at extreme speeds for a duration and you need it to look
---smooth on clients without the server correcting the client. Make sure to disable when done, as this would
---break this character's server-client movement correction.
---@see bServerAcceptClientAuthoritativePosition, ServerCheckClientError()
---@field bIgnoreClientMovementErrorChecksAndCorrection boolean
---If true, and server does not detect client position error, server will copy the client movement location/velocity/etc after simulating the move.
---This can be useful for short bursts of movement that are difficult to sync over the network.
---Note that if bIgnoreClientMovementErrorChecksAndCorrection is used, this means the server will not detect an error.
---Also see GameNetworkManager->ClientAuthorativePosition which permanently enables this behavior.
---@see bIgnoreClientMovementErrorChecksAndCorrection, ServerShouldUseAuthoritativePosition()
---@field bServerAcceptClientAuthoritativePosition boolean
---If true, event NotifyJumpApex() to CharacterOwner's controller when at apex of jump. Is cleared when event is triggered.
---By default this is off, and if you want the event to fire you typically set it to true when movement mode changes to "Falling" from another mode (see OnMovementModeChanged).
---@field bNotifyApex boolean
---Instantly stop when in flying mode and no acceleration is being applied.
---@field bCheatFlying boolean
---If true, try to crouch (or keep crouching) on next update. If false, try to stop crouching on next update.
---@field bWantsToCrouch boolean
---If true, crouching should keep the base of the capsule in place by lowering the center of the shrunken capsule. If false, the base of the capsule moves up and the center stays in place.
---The same behavior applies when the character uncrouches: if true, the base is kept in the same location and the center moves up. If false, the capsule grows and only moves up if the base impacts something.
---By default this variable is set when the movement mode changes: set to true when walking and false otherwise. Feel free to override the behavior when the movement mode changes.
---@field bCrouchMaintainsBaseLocation boolean
---Whether the character ignores changes in rotation of the base it is standing on.
---If true, the character maintains current world rotation.
---If false, the character rotates with the moving base.
---@field bIgnoreBaseRotation boolean
---Set this to true if riding on a moving base that you know is clear from non-moving world obstructions.
---Optimization to avoid sweeps during based movement, use with care.
---@field bFastAttachedMove boolean
---Whether we always force floor checks for stationary Characters while walking.
---Normally floor checks are avoided if possible when not moving, but this can be used to force them if there are use-cases where they are being skipped erroneously
---(such as objects moving up into the character from below).
---@field bAlwaysCheckFloor boolean
---Performs floor checks as if the character is using a shape with a flat base.
---This avoids the situation where characters slowly lower off the side of a ledge (as their capsule 'balances' on the edge).
---@field bUseFlatBaseForFloorChecks boolean
---Used to prevent reentry of JumpOff()
---@field bPerformingJumpOff boolean
---Used to safely leave NavWalking movement mode
---@field bWantsToLeaveNavWalking boolean
---If set, component will use RVO avoidance. This only runs on the server.
---@field bUseRVOAvoidance boolean
---Should use acceleration for path following?
---If true, acceleration is applied when path following to reach the target velocity.
---If false, path following velocity is set directly, disregarding acceleration.
---@field bRequestedMoveUseAcceleration boolean
---True when SimulatedProxies are simulating RootMotion
---@field bWasSimulatingRootMotion boolean
---@field bAllowPhysicsRotationDuringAnimRootMotion boolean
---When applying a root motion override while falling off a moving object, this controls how long it takes to lose half the former base's velocity (in seconds).
---Set to 0 to ignore former bases (default).
---Set to -1 for no decay.
---Any other positive value sets the half-life for exponential decay.
---@field FormerBaseVelocityDecayHalfLife number
---Was velocity requested by path following?
---@field bHasRequestedVelocity boolean
---Was acceleration requested to be always max speed?
---@field bRequestedMoveWithMaxSpeed boolean
---Was avoidance updated in this frame?
---@field bWasAvoidanceUpdated boolean
---Whether to raycast to underlying geometry to better conform navmesh-walking characters
---@field bProjectNavMeshWalking boolean
---Use both WorldStatic and WorldDynamic channels for NavWalking geometry conforming
---@field bProjectNavMeshOnBothWorldChannels boolean
---@field AvoidanceConsiderationRadius number
---Velocity requested by path following.
---@see RequestDirectMove()
---@field RequestedVelocity Vector
---Velocity requested by path following during last Update
---Updated when we consume the value
---@field LastUpdateRequestedVelocity Vector
---No default value, for now it's assumed to be valid if GetAvoidanceManager() returns non-NULL.
---@field AvoidanceUID integer
---Moving actor's group mask
---@field AvoidanceGroup NavAvoidanceMask
---Will avoid other agents if they are in one of specified groups
---@field GroupsToAvoid NavAvoidanceMask
---Will NOT avoid other agents if they are in one of specified groups, higher priority than GroupsToAvoid
---@field GroupsToIgnore NavAvoidanceMask
---De facto default value 0.5 (due to that being the default in the avoidance registration function), indicates RVO behavior.
---@field AvoidanceWeight number
---Temporarily holds launch velocity when pawn is to be launched so it happens at end of movement.
---@field PendingLaunchVelocity Vector
---How often we should raycast to project from navmesh to underlying geometry
---@field NavMeshProjectionInterval number
---@field NavMeshProjectionTimer number
---Speed at which to interpolate agent navmesh offset between traces. 0: Instant (no interp) > 0: Interp speed")
---@field NavMeshProjectionInterpSpeed number
---Scale of the total capsule height to use for projection from navmesh to underlying geometry in the upward direction.
---In other words, start the trace at [CapsuleHeight * NavMeshProjectionHeightScaleUp] above nav mesh.
---@field NavMeshProjectionHeightScaleUp number
---Scale of the total capsule height to use for projection from navmesh to underlying geometry in the downward direction.
---In other words, trace down to [CapsuleHeight * NavMeshProjectionHeightScaleDown] below nav mesh.
---@field NavMeshProjectionHeightScaleDown number
---Ignore small differences in ground height between server and client data during NavWalking mode
---@field NavWalkingFloorDistTolerance number
---Property to set if UpdateBasedMovement should ignore collision with actors part of the current MovementBase, if the base is simulated by physics
---@field bBasedMovementIgnorePhysicsBase boolean
---Property to set if characters should stay based on objects attachment root instead of the traced object
---@field bBaseOnAttachmentRoot boolean
---Property to set if characters should stay based on objects while jumping
---@field bStayBasedInAir boolean
---Property used to set how high above base characters should stay based on objects while jumping if bStayBasedInAir is set
---@field StayBasedInAirHeight number
---Post-physics tick function for this character
---@field PostPhysicsTickFunction CharacterMovementComponentPostPhysicsTickFunction
---Minimum time between client TimeStamp resets.
---       !! This has to be large enough so that we don't confuse the server if the client can stall or timeout.
---       We do this as we use floats for TimeStamps, and server derives DeltaTime from two TimeStamps.
---       As time goes on, accuracy decreases from those floating point numbers.
---       So we trigger a TimeStamp reset at regular intervals to maintain a high level of accuracy.
---@field MinTimeBetweenTimeStampResets number
---Root Motion Group containing active root motion sources being applied to movement
---@field CurrentRootMotion RootMotionSourceGroup
---@field ServerCorrectionRootMotion RootMotionSourceGroup
---Root Motion movement params. Holds result of anim montage root motion during PerformMovement(), and is overridden
--- during autonomous move playback to force historical root motion for MoveAutonomous() calls
---@field RootMotionParams RootMotionMovementParams
---Velocity extracted from RootMotionParams when there is anim root motion active. Invalid to use when HasAnimRootMotion() returns false.
---@field AnimRootMotionVelocity Vector
local CharacterMovementComponent = {}

--- Methods
---Set the Z component of the normal of the steepest walkable surface for the character. Also computes WalkableFloorAngle.
---@param InWalkableFloorZ number
---@return nil
function CharacterMovementComponent.SetWalkableFloorZ(InWalkableFloorZ) end

---Set the max angle in degrees of a walkable surface for the character. Also computes WalkableFloorZ.
---@param InWalkableFloorAngle number
---@return nil
function CharacterMovementComponent.SetWalkableFloorAngle(InWalkableFloorAngle) end

---Change movement mode.
---@param NewMovementMode integer
---@param NewCustomMode integer
---@return nil
function CharacterMovementComponent.SetMovementMode(NewMovementMode, NewCustomMode) end

---Set Groups to Ignore Mask
---@return nil
function CharacterMovementComponent.SetGroupsToIgnoreMask() end

---Set Groups to Ignore
---@param GroupFlags integer
---@return nil
function CharacterMovementComponent.SetGroupsToIgnore(GroupFlags) end

---Set Groups to Avoid Mask
---@return nil
function CharacterMovementComponent.SetGroupsToAvoidMask() end

---Set Groups to Avoid
---@param GroupFlags integer
---@return nil
function CharacterMovementComponent.SetGroupsToAvoid(GroupFlags) end

---Set a custom, local gravity direction to use during movement simulation.
---The gravity direction must be synchronized by external systems between the autonomous
---and authority processes. The gravity direction will be corrected as part of movement
---corrections should the movement state diverge.
---SetGravityDirection is responsible for initializing cached values used to tranform to
---from gravity relative space.
---@return nil
function CharacterMovementComponent.SetGravityDirection() end

---Sets collision half-height when crouching and updates dependent computations
---@param NewValue number
---@return nil
function CharacterMovementComponent.SetCrouchedHalfHeight(NewValue) end

---Set Avoidance Group Mask
---@return nil
function CharacterMovementComponent.SetAvoidanceGroupMask() end

---Set Avoidance Group
---@param GroupFlags integer
---@return nil
function CharacterMovementComponent.SetAvoidanceGroup(GroupFlags) end

---Change avoidance state and registers in RVO manager if needed
---@param bEnable boolean
---@return nil
function CharacterMovementComponent.SetAvoidanceEnabled(bEnable) end

---Returns true if the character is in the 'Walking' movement mode.
---@return boolean
function CharacterMovementComponent.IsWalking() end

---Return true if the hit result should be considered a walkable surface for the character.
---@return boolean
function CharacterMovementComponent.IsWalkable() end

---Whether the gravity direction is different from UCharacterMovementComponent::DefaultGravityDirection.
---@return boolean
function CharacterMovementComponent.HasCustomGravity() end

---Returns the radius within which we can stand on the edge of a surface without falling (if this is a walkable surface).
---Simply computed as the capsule radius minus the result of GetPerchRadiusThreshold().
---@return number
function CharacterMovementComponent.GetValidPerchRadius() end

---Returns The distance from the edge of the capsule within which we don't allow the character to perch on the edge of a surface.
---@return number
function CharacterMovementComponent.GetPerchRadiusThreshold() end

---Return PrimitiveComponent we are based on (standing and walking on).
---@return PrimitiveComponent
function CharacterMovementComponent.GetMovementBase() end

---Returns maximum acceleration for the current state.
---@return number
function CharacterMovementComponent.GetMinAnalogSpeed() end

---Compute the max jump height based on the JumpZVelocity velocity and gravity.
---This does take into account the CharacterOwner's MaxJumpHoldTime.
---@return number
function CharacterMovementComponent.GetMaxJumpHeightWithJumpTime() end

---Compute the max jump height based on the JumpZVelocity velocity and gravity.
---This does not take into account the CharacterOwner's MaxJumpHoldTime.
---@return number
function CharacterMovementComponent.GetMaxJumpHeight() end

---Returns maximum deceleration for the current state when braking (ie when there is no acceleration).
---@return number
function CharacterMovementComponent.GetMaxBrakingDeceleration() end

---Returns maximum acceleration for the current state.
---@return number
function CharacterMovementComponent.GetMaxAcceleration() end

---Returns the velocity at the end of the last tick.
---@return Vector
function CharacterMovementComponent.GetLastUpdateVelocity() end

---Returns the rotation at the end of the last tick.
---@return Rotator
function CharacterMovementComponent.GetLastUpdateRotation() end

---Returns velocity requested by path following
---@return Vector
function CharacterMovementComponent.GetLastUpdateRequestedVelocity() end

---Returns the location at the end of the last tick.
---@return Vector
function CharacterMovementComponent.GetLastUpdateLocation() end

---If we have a movement base, get the velocity that should be imparted by that base, usually when jumping off of it.
---Only applies the components of the velocity enabled by bImpartBaseVelocityX, bImpartBaseVelocityY, bImpartBaseVelocityZ.
---@return Vector
function CharacterMovementComponent.GetImpartedMovementBaseVelocity() end

---Returns the current gravity direction.
---@return Vector
function CharacterMovementComponent.GetGravityDirection() end

---Returns current acceleration, computed from input vector each update.
---@return Vector
function CharacterMovementComponent.GetCurrentAcceleration() end

---Returns the collision half-height when crouching (component scale is applied separately)
---@return number
function CharacterMovementComponent.GetCrouchedHalfHeight() end

---Get the Character that owns UpdatedComponent.
---@return Character
function CharacterMovementComponent.GetCharacterOwner() end

---Returns modifier [0..1] based on the magnitude of the last input vector, which is used to modify the acceleration and max speed during movement.
---@return number
function CharacterMovementComponent.GetAnalogInputModifier() end

---Make movement impossible (sets movement mode to MOVE_None).
---@return nil
function CharacterMovementComponent.DisableMovement() end

---Clears forces accumulated through AddImpulse() and AddForce(), and also pending launch velocity.
---@return nil
function CharacterMovementComponent.ClearAccumulatedForces() end

---Updates Velocity and Acceleration based on the current state, applying the effects of friction and acceleration or deceleration. Does not apply gravity.
---This is used internally during movement updates. Normally you don't need to call this from outside code, but you might want to use it for custom movement modes.
---@param DeltaTime number
---@param Friction number
---@param bFluid boolean
---@param BrakingDeceleration number
---@return nil
function CharacterMovementComponent.CalcVelocity(DeltaTime, Friction, bFluid, BrakingDeceleration) end

---Add impulse to character. Impulses are accumulated each tick and applied together
---so multiple calls to this function will accumulate.
---An impulse is an instantaneous force, usually applied once. If you want to continually apply
---forces each frame, use AddForce().
---Note that changing the momentum of characters like this can change the movement mode.
---@param Impulse Vector
---@param bVelocityChange boolean
---@return nil
function CharacterMovementComponent.AddImpulse(Impulse, bVelocityChange) end

---Add force to character. Forces are accumulated each tick and applied together
---so multiple calls to this function will accumulate.
---Forces are scaled depending on timestep, so they can be applied each frame. If you want an
---instantaneous force, use AddImpulse.
---Adding a force always takes the actor's mass into account.
---Note that changing the momentum of characters like this can change the movement mode.
---@param Force Vector
---@return nil
function CharacterMovementComponent.AddForce(Force) end

return CharacterMovementComponent
