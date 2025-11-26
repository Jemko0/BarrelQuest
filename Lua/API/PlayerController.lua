---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PlayerController : Controller
---PlayerControllers are used by human players to control Pawns.
---ControlRotation (accessed via GetControlRotation()), determines the aiming
---orientation of the controlled Pawn.
---In networked games, PlayerControllers exist on the server for every player-controlled pawn,
---and also on the controlling client's machine. They do NOT exist on a client's
---machine for pawns controlled by remote players elsewhere on the network.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/Controller/PlayerController/
---
--- Properties
---
---UPlayer associated with this PlayerController.  Could be a local player or a net connection.
---@field Player Player
---Used in net games so client can acknowledge it possessed a specific pawn.
---@field AcknowledgedPawn Pawn
---Heads up display associated with this PlayerController.
---@field MyHUD HUD
---Camera manager associated with this Player Controller.
---@field PlayerCameraManager PlayerCameraManager
---PlayerCamera class should be set for each game, otherwise Engine.PlayerCameraManager is used
---@field PlayerCameraManagerClass Class
---True to allow this player controller to manage the camera target for you,
---typically by using the possessed pawn as the camera target. Set to false
---if you want to manually control the camera target.
---@field bAutoManageActiveCameraTarget boolean
---Used to replicate the view rotation of targets not owned/possessed by this PlayerController.
---@field TargetViewRotation Rotator
---Interp speed for blending remote view rotation for smoother client updates
---@field SmoothTargetViewRotationSpeed number
---The actors which the camera shouldn't see - e.g. used to hide actors which the camera penetrates
---@field HiddenActors Actor[]
---Explicit components the camera shouldn't see (helpful for external systems to hide a component from a single player)
---@field HiddenPrimitiveComponents any[]
---Used to make sure the client is kept synchronized when in a spectator state
---@field LastSpectatorStateSynchTime number
---Last location synced on the server for a spectator.
---@field LastSpectatorSyncLocation Vector
---Last rotation synced on the server for a spectator.
---@field LastSpectatorSyncRotation Rotator
---Cap set by server on bandwidth from client to server in bytes/sec (only has impact if >=2600)
---@field ClientCap integer
---Object that manages "cheat" commands.
---By default:
---      - In Shipping configurations, the manager is always disabled because UE_WITH_CHEAT_MANAGER is 0
---  - When playing in the editor, cheats are always enabled
---  - In other cases, cheats are enabled by default in single player games but can be forced on with the EnableCheats console command
---This behavior can be changed either by overriding APlayerController::EnableCheats or AGameModeBase::AllowCheats.
---@field CheatManager CheatManager
---Class of my CheatManager.
---\@see CheatManager for more information about when it will be instantiated.
---@field CheatClass Class
---Object that manages player input.
---@field PlayerInput PlayerInput
---@field ActiveForceFeedbackEffects ActiveForceFeedbackEffect[]
---True if PlayerController is currently waiting for the match to start or to respawn. Only valid in Spectating state.
---@field bPlayerIsWaiting boolean
---Index identifying players using the same base connection (splitscreen clients)
---Used by netcode to match replicated PlayerControllers to the correct splitscreen viewport and child connection
---replicated via special internal code, not through normal variable replication
---@field NetPlayerIndex integer
---This is set on the OLD PlayerController when performing a swap over a network connection
---so we know what connection we're waiting on acknowledgment from to finish destroying this PC
---(or when the connection is closed)
---\@see GameModeBase::SwapPlayerControllers()
---@field PendingSwapConnection NetConnection
---The net connection this controller is communicating on, nullptr for local players on server
---@field NetConnection NetConnection
---Yaw input speed scaling
---@field InputYawScale number
---Pitch input speed scaling
---@field InputPitchScale number
---Roll input speed scaling
---@field InputRollScale number
---Whether the mouse cursor should be displayed.
---@field bShowMouseCursor boolean
---Whether actor/component click events should be generated.
---@field bEnableClickEvents boolean
---Whether actor/component touch events should be generated.
---@field bEnableTouchEvents boolean
---Whether actor/component mouse over events should be generated.
---@field bEnableMouseOverEvents boolean
---Whether actor/component touch over events should be generated.
---@field bEnableTouchOverEvents boolean
---@field bForceFeedbackEnabled boolean
---Whether or not to consider input from motion sources (tilt, acceleration, etc)
---@field bEnableMotionControls boolean
---Whether the PlayerController should be used as a World Partiton streaming source.
---@field bEnableStreamingSource boolean
---Whether the PlayerController streaming source should activate cells after loading.
---@field bStreamingSourceShouldActivate boolean
---Whether the PlayerController streaming source should block on slow streaming.
---@field bStreamingSourceShouldBlockOnSlowStreaming boolean
---PlayerController streaming source priority.
---@field StreamingSourcePriority EStreamingSourcePriority
---Color used for debugging.
---@field StreamingSourceDebugColor Color
---Optional aggregated shape list used to build a custom shape for the streaming source. When empty, fallbacks sphere shape with a radius equal to grid's loading range.
---@field StreamingSourceShapes StreamingSourceShape[]
---Scale applied to force feedback values
---@field ForceFeedbackScale number
---List of keys that will cause click events to be forwarded, default to left click
---@field ClickEventKeys Key[]
---Type of mouse cursor to show by default
---@field DefaultMouseCursor integer
---Currently visible mouse cursor
---@field CurrentMouseCursor integer
---Default trace channel used for determining what world object was clicked on.
---@field DefaultClickTraceChannel integer
---Trace channel currently being used for determining what world object was clicked on.
---@field CurrentClickTraceChannel integer
---Distance to trace when computing click events
---@field HitResultTraceDistance number
---Counter for this players seamless travels (used along with the below value, to restrict ServerNotifyLoadedWorld)
---@field SeamlessTravelCount any
---The value of SeamlessTravelCount, upon the last call to GameModeBase::HandleSeamlessTravelPlayer; used to detect seamless travel
---@field LastCompletedSeamlessTravelCount any
---InputComponent we use when player is in Inactive state.
---@field InactiveStateInputComponent InputComponent
---Whether we fully tick when the game is paused, if our tick function is allowed to do so. If false, we do a minimal update during the tick.
---@field bShouldPerformFullTickWhenPaused boolean
---The currently set touch interface
---@field CurrentTouchInterface TouchInterface
---If set, then this UPlayerInput class will be used instead of the Input Settings' DefaultPlayerInputClass
---@field OverridePlayerInputClass Class
---The location used internally when there is no pawn or spectator, to know where to spawn the spectator or focus the camera on death.
---@field SpawnLocation Vector
local PlayerController = {}

--- Methods
---Returns true if the given key/button was down last frame and up this frame.
---@param Key Key
---@return boolean
function PlayerController.WasInputKeyJustReleased(Key) end

---Returns true if the given key/button was up last frame and down this frame.
---@param Key Key
---@return boolean
function PlayerController.WasInputKeyJustPressed(Key) end

---Whether the PlayerController streaming source should block on slow streaming.
---Default implementation returns bStreamingSourceShouldBlockOnSlowStreaming but can be overriden in child classes.
---@return boolean
function PlayerController.StreamingSourceShouldBlockOnSlowStreaming() end

---Whether the PlayerController streaming source should activate cells after loading.
---Default implementation returns bStreamingSourceShouldActivate but can be overriden in child classes.
---@return boolean
function PlayerController.StreamingSourceShouldActivate() end

---Stops a playing haptic feedback curve
---@param Hand EControllerHand
---@return nil
function PlayerController.StopHapticEffect(Hand) end

---Set the virtual joystick visibility.
---@param bVisible boolean
---@return nil
function PlayerController.SetVirtualJoystickVisibility(bVisible) end

---Set the view target blending with variable control
---@param NewViewTarget Actor
---@param BlendTime number
---@param BlendFunc integer
---@param BlendExp number
---@param bLockOutgoing boolean
---@return nil
function PlayerController.SetViewTargetWithBlend(NewViewTarget, BlendTime, BlendFunc, BlendExp, bLockOutgoing) end

---Positions the mouse cursor in screen space, in pixels.
---@param X integer
---@param Y integer
---@return nil
function PlayerController.SetMouseLocation(X, Y) end

---Sets the Widget for the Mouse Cursor to display
---@param Cursor integer
---@param CursorWidget UserWidget
---@return nil
function PlayerController.SetMouseCursorWidget(Cursor, CursorWidget) end

---Set Motion Controls Enabled
---@param bEnabled boolean
---@return nil
function PlayerController.SetMotionControlsEnabled(bEnabled) end

---Sets the value of the haptics for the specified hand directly, using frequency and amplitude.  NOTE:  If a curve is already
---playing for this hand, it will be cancelled in favour of the specified values.
---@param Frequency number
---@param Amplitude number
---@param Hand EControllerHand
---@return nil
function PlayerController.SetHapticsByValue(Frequency, Amplitude, Hand) end

---Allows the player controller to disable all haptic requests from being fired, e.g. in the case of a level loading
---@param bNewDisabled boolean
---@return nil
function PlayerController.SetDisableHaptics(bNewDisabled) end

---Set Deprecated Input Yaw Scale
---@param NewValue number
---@return nil
function PlayerController.SetDeprecatedInputYawScale(NewValue) end

---Set Deprecated Input Roll Scale
---@param NewValue number
---@return nil
function PlayerController.SetDeprecatedInputRollScale(NewValue) end

---Set Deprecated Input Pitch Scale
---@param NewValue number
---@return nil
function PlayerController.SetDeprecatedInputPitchScale(NewValue) end

---Sets the trigger release thresholds of the player's controller
---@param LeftThreshold number
---@param RightThreshold number
---@return nil
function PlayerController.SetControllerTriggerReleaseThresholds(LeftThreshold, RightThreshold) end

---Sets the light color of the player's controller
---@param Color Color
---@return nil
function PlayerController.SetControllerLightColor(Color) end

---Sets whether the player's controller's gyro auto calibration is enabled
---@param bEnabled boolean
---@return nil
function PlayerController.SetControllerGyroAutoCalibration(bEnabled) end

---Sets the deadzones of the player's controller
---@param LeftDeadZone number
---@param RightDeadZone number
---@return nil
function PlayerController.SetControllerDeadZones(LeftDeadZone, RightDeadZone) end

---Server/SP only function for changing whether the player is in cinematic mode.  Updates values of various state variables, then replicates the call to the client
---to sync the current cinematic mode.
---@param bInCinematicMode boolean
---@param bHidePlayer boolean
---@param bAffectsHUD boolean
---@param bAffectsMovement boolean
---@param bAffectsTurning boolean
---@return nil
function PlayerController.SetCinematicMode(bInCinematicMode, bHidePlayer, bAffectsHUD, bAffectsMovement, bAffectsTurning) end

---Used to override the default positioning of the audio listener
---@param AttachToComponent SceneComponent
---@param Location Vector
---@param Rotation Rotator
---@return nil
function PlayerController.SetAudioListenerOverride(AttachToComponent, Location, Rotation) end

---Set Audio Listener Attenuation Override
---@param AttachToComponent SceneComponent
---@param AttenuationLocationOVerride Vector
---@return nil
function PlayerController.SetAudioListenerAttenuationOverride(AttachToComponent, AttenuationLocationOVerride) end

---Resets the player's controller trigger release thresholds to default
---@return nil
function PlayerController.ResetControllerTriggerReleaseThresholds() end

---Resets the light color of the player's controller to default
---@return nil
function PlayerController.ResetControllerLightColor() end

---Resets the player's controller deadzones to default
---@return nil
function PlayerController.ResetControllerDeadZones() end

---Convert a World Space 3D position into a 2D Screen Space position.
---@param WorldLocation Vector
---@param bPlayerViewportRelative boolean
---@return boolean
function PlayerController.ProjectWorldLocationToScreen(WorldLocation, bPlayerViewportRelative) end

---Play a haptic feedback curve on the player's controller
---@param HapticEffect HapticFeedbackEffect_Base
---@param Hand EControllerHand
---@param Scale number
---@param bLoop boolean
---@return nil
function PlayerController.PlayHapticEffect(HapticEffect, Hand, Scale, bLoop) end

---Latent action that controls the playing of force feedback
---Begins playing when Start is called.  Calling Update or Stop if the feedback is not active will have no effect.
---Completed will execute when Stop is called or the duration ends.
---When Update is called the Intensity, Duration, and affect values will be updated with the current inputs
---@param Intensity number
---@param Duration number
---@param bAffectsLeftLarge boolean
---@param bAffectsLeftSmall boolean
---@param bAffectsRightLarge boolean
---@param bAffectsRightSmall boolean
---@param Action integer
---@param LatentInfo LatentActionInfo
---@return nil
function PlayerController.PlayDynamicForceFeedback(Intensity, Duration, bAffectsLeftLarge, bAffectsLeftSmall, bAffectsRightLarge, bAffectsRightSmall, Action, LatentInfo) end

---Play a force feedback pattern on the player's controller
---@param ForceFeedbackEffect ForceFeedbackEffect
---@param Tag string
---@param bLooping boolean
---@param bIgnoreTimeDilation boolean
---@param bPlayWhilePaused boolean
---@return nil
function PlayerController.K2_ClientPlayForceFeedback(ForceFeedbackEffect, Tag, bLooping, bIgnoreTimeDilation, bPlayWhilePaused) end

---Whether the PlayerController should be used as a World Partiton streaming source.
---Default implementation returns bEnableStreamingSource but can be overriden in child classes.
---@return boolean
function PlayerController.IsStreamingSourceEnabled() end

---Wrapper for determining whether this player is the first player on their console.
---@return boolean
function PlayerController.IsPrimaryPlayer() end

---Returns true if the given key/button is pressed on the input of the controller (if present)
---@param Key Key
---@return boolean
function PlayerController.IsInputKeyDown(Key) end

---Helper to get the size of the HUD canvas for this player controller.  Returns 0 if there is no HUD
---@return nil, integer, integer
function PlayerController.GetViewportSize() end

---Gets the streaming source priority.
---Default implementation returns StreamingSourceShapes but can be overriden in child classes.
---@return nil, StreamingSourceShape[]
function PlayerController.GetStreamingSourceShapes() end

---Gets the streaming source priority.
---Default implementation returns StreamingSourcePriority but can be overriden in child classes.
---@return EStreamingSourcePriority
function PlayerController.GetStreamingSourcePriority() end

---Gets the streaming source location and rotation.
---Default implementation returns APlayerController::GetPlayerViewPoint but can be overriden in child classes.
---@return nil, Vector, Rotator
function PlayerController.GetStreamingSourceLocationAndRotation() end

---Get the Pawn used when spectating. nullptr when not spectating.
---@return SpectatorPawn
function PlayerController.GetSpectatorPawn() end

---Returns the platform user that is assigned to this Player Controller's Local Player.
---If there is no local player, then this will return PLATFORMUSERID_NONE
---@return PlatformUserId
function PlayerController.GetPlatformUserId() end

---Get Override Player Input Class
---@return Class
function PlayerController.GetOverridePlayerInputClass() end

---Retrieves the X and Y screen coordinates of the mouse cursor. Returns false if there is no associated mouse device
---@return boolean
function PlayerController.GetMousePosition() end

---Returns the vector value for the given key/button.
---@param Key Key
---@return Vector
function PlayerController.GetInputVectorKeyState(Key) end

---Retrieves the X and Y screen coordinates of the specified touch key. Returns false if the touch index is not down
---@param FingerIndex integer
---@return nil, number, number, boolean
function PlayerController.GetInputTouchState(FingerIndex) end

---Retrieves how far the mouse moved this frame.
---@return nil, number, number
function PlayerController.GetInputMouseDelta() end

---Retrieves the current motion state of the player's input device
---@return nil, Vector, Vector, Vector, Vector
function PlayerController.GetInputMotionState() end

---Returns how long the given key/button has been down.  Returns 0 if it's up or it just went down this frame.
---@param Key Key
---@return number
function PlayerController.GetInputKeyTimeDown(Key) end

---Retrieves the X and Y displacement of the given analog stick.
---@param WhichStick integer
---@return nil, number, number
function PlayerController.GetInputAnalogStickState(WhichStick) end

---Returns the analog value for the given key/button.  If analog isn't supported, returns 1 for down and 0 for up.
---@param Key Key
---@return number
function PlayerController.GetInputAnalogKeyState(Key) end

---Gets the HUD currently being used by this player controller
---@return HUD
function PlayerController.GetHUD() end

---Performs a collision query under the finger, looking for object types
---@param FingerIndex integer
---@param bTraceComplex boolean
---@return boolean
function PlayerController.GetHitResultUnderFingerForObjects(FingerIndex, bTraceComplex) end

---Performs a collision query under the finger, looking on a trace channel
---@param FingerIndex integer
---@param TraceChannel integer
---@param bTraceComplex boolean
---@return boolean
function PlayerController.GetHitResultUnderFingerByChannel(FingerIndex, TraceChannel, bTraceComplex) end

---Get Hit Result Under Finger
---@param FingerIndex integer
---@param TraceChannel integer
---@param bTraceComplex boolean
---@return boolean
function PlayerController.GetHitResultUnderFinger(FingerIndex, TraceChannel, bTraceComplex) end

---Performs a collision query under the mouse cursor, looking for object types
---@param bTraceComplex boolean
---@return boolean
function PlayerController.GetHitResultUnderCursorForObjects(bTraceComplex) end

---Performs a collision query under the mouse cursor, looking on a trace channel
---@param TraceChannel integer
---@param bTraceComplex boolean
---@return boolean
function PlayerController.GetHitResultUnderCursorByChannel(TraceChannel, bTraceComplex) end

---Get Hit Result Under Cursor
---@param TraceChannel integer
---@param bTraceComplex boolean
---@return boolean
function PlayerController.GetHitResultUnderCursor(TraceChannel, bTraceComplex) end

---Returns the location the PlayerController is focused on.
--- If there is a possessed Pawn, returns the Pawn's location.
--- If there is a spectator Pawn, returns that Pawn's location.
--- Otherwise, returns the PlayerController's spawn location (usually the last known Pawn location after it has died).
---@return Vector
function PlayerController.GetFocalLocation() end

---Get Deprecated Input Yaw Scale
---@return number
function PlayerController.GetDeprecatedInputYawScale() end

---Get Deprecated Input Roll Scale
---@return number
function PlayerController.GetDeprecatedInputRollScale() end

---Get Deprecated Input Pitch Scale
---@return number
function PlayerController.GetDeprecatedInputPitchScale() end

---Convert 2D screen position to World Space 3D position and direction. Returns false if unable to determine value. *
---@param ScreenX number
---@param ScreenY number
---@return boolean
function PlayerController.DeprojectScreenPositionToWorld(ScreenX, ScreenY) end

---Convert current mouse 2D position to World Space 3D position and direction. Returns false if unable to determine value. *
---@return boolean
function PlayerController.DeprojectMousePositionToWorld() end

---Stops a playing force feedback pattern
---@param ForceFeedbackEffect ForceFeedbackEffect
---@param Tag string
---@return nil
function PlayerController.ClientStopForceFeedback(ForceFeedbackEffect, Tag) end

---Stop camera shake on client.
---@param SourceComponent CameraShakeSourceComponent
---@param bImmediately boolean
---@return nil
function PlayerController.ClientStopCameraShakesFromSource(SourceComponent, bImmediately) end

---Stop camera shake on client.
---@param Shake Class
---@param bImmediately boolean
---@return nil
function PlayerController.ClientStopCameraShake(Shake, bImmediately) end

---Play Camera Shake localized to a given source
---@param Shake Class
---@param SourceComponent CameraShakeSourceComponent
---@return nil
function PlayerController.ClientStartCameraShakeFromSource(Shake, SourceComponent) end

---Play Camera Shake
---@param Shake Class
---@param Scale number
---@param PlaySpace ECameraShakePlaySpace
---@param UserPlaySpaceRot Rotator
---@return nil
function PlayerController.ClientStartCameraShake(Shake, Scale, PlaySpace, UserPlaySpaceRot) end

---Spawn a camera lens effect (e.g. blood).
---@param LensEffectEmitterClass Class
---@return nil
function PlayerController.ClientSpawnGenericCameraLensEffect(LensEffectEmitterClass) end

---Set the client's class of HUD and spawns a new instance of it. If there was already a HUD active, it is destroyed.
---@param NewHUDClass Class
---@return nil
function PlayerController.ClientSetHUD(NewHUDClass) end

---Removes all Camera Lens Effects.
---@return nil
function PlayerController.ClientClearCameraLensEffects() end

---Clear any overrides that have been applied to audio listener
---@return nil
function PlayerController.ClearAudioListenerOverride() end

---Clear Audio Listener Attenuation Override
---@return nil
function PlayerController.ClearAudioListenerAttenuationOverride() end

---Returns true if this controller thinks it's able to restart. Called from GameModeBase::PlayerCanRestart
---@return boolean
function PlayerController.CanRestartPlayer() end

---Add Yaw (turn) input. This value is multiplied by InputYawScale.
---@param Val number
---@return nil
function PlayerController.AddYawInput(Val) end

---Add Roll input. This value is multiplied by InputRollScale.
---@param Val number
---@return nil
function PlayerController.AddRollInput(Val) end

---Add Pitch (look up) input. This value is multiplied by InputPitchScale.
---@param Val number
---@return nil
function PlayerController.AddPitchInput(Val) end

---Activates a new touch interface for this player controller
---@param NewTouchInterface TouchInterface
---@return nil
function PlayerController.ActivateTouchInterface(NewTouchInterface) end

return PlayerController
