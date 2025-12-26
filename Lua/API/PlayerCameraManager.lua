---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class PlayerCameraManager : Actor
---A PlayerCameraManager is responsible for managing the camera for a particular
---player. It defines the final view properties used by other systems (e.g. the renderer),
---meaning you can think of it as your virtual eyeball in the world. It can compute the
---final camera properties directly, or it can arbitrate/blend between other objects or
---actors that influence the camera (e.g. blending from one CameraActor to another).
---The PlayerCameraManagers primary external responsibility is to reliably respond to
---various Get*() functions, such as GetCameraViewPoint. Most everything else is
---implementation detail and overrideable by user projects.
---By default, a PlayerCameraManager maintains a "view target", which is the primary actor
---the camera is associated with. It can also apply various "post" effects to the final
---view state, such as camera animations, shakes, post-process effects or special
---effects such as dirt on the lens.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/Camera/
---
--- Properties
---
---PlayerController that owns this Camera actor
---@field PCOwner PlayerController
---FOV to use by default.
---@field DefaultFOV number
---The default desired width (in world units) of the orthographic view (ignored in Perspective mode)
---@field DefaultOrthoWidth number
---Default aspect ratio. Most of the time the value from a camera component will be used instead.
---@field DefaultAspectRatio number
---Current ViewTarget
---@field ViewTarget TViewTarget
---Pending view target for blending
---@field PendingViewTarget TViewTarget
---List of active camera modifier instances that have a chance to update the final camera POV
---@field ModifierList CameraModifier[]
---List of modifiers to create by default for this camera
---@field DefaultModifiers Class[]
---Distance to place free camera from view target (used in certain CameraStyles)
---@field FreeCamDistance number
---Offset to Z free camera position (used in certain CameraStyles)
---@field FreeCamOffset Vector
---Offset to view target (used in certain CameraStyles)
---@field ViewTargetOffset Vector
---If bound, broadcast on fade start (with fade time) instead of manually altering audio device's primary volume directly
---@field OnAudioFadeChangeEvent OnAudioFadeChangeEventDelegate
---CameraBlood emitter attached to this camera
---@field CameraLensEffects any[]
---Cached ref to modifier for code-driven screen shakes
---@field CachedCameraShakeMod CameraModifier_CameraShake
---Internal list of active post process effects. Parallel array to PostProcessBlendCacheWeights.
---@field PostProcessBlendCache PostProcessSettings[]
---Internal. Receives the output of individual camera animations.
---@field AnimCameraActor CameraActor
---True when this camera should use an orthographic perspective instead of FOV
---@field bIsOrthographic boolean
---True when this camera should automatically calculated the Near+Far planes
---@field bAutoCalculateOrthoPlanes boolean
---Manually adjusts the planes of this camera, maintaining the distance between them. Positive moves out to the farplane, negative towards the near plane
---@field AutoPlaneShift number
---Adjusts the near/far planes and the view origin of the current camera automatically to avoid clipping and light artefacting
---@field bUpdateOrthoPlanes boolean
---If UpdateOrthoPlanes is enabled, this setting will use the cameras current height to compensate the distance to the general view (as a pseudo distance to view target when one isn't present)
---@field bUseCameraHeightAsViewTarget boolean
---True if black bars should be added if the destination view has a different aspect ratio (only used when a view target doesn't specify whether or not to constrain the aspect ratio; most of the time the value from a camera component is used instead)
---@field bDefaultConstrainAspectRatio boolean
---True if clients are handling setting their own viewtarget and the server should not replicate it.
---@field bClientSimulatingViewTarget boolean
---True if server will use camera positions replicated from the client instead of calculating them locally.
---@field bUseClientSideCameraUpdates boolean
---True if we did a camera cut this frame. Automatically reset to false every frame.
---This flag affects various things in the renderer (such as whether to use the occlusion queries from last frame, and motion blur).
---@field bGameCameraCutThisFrame boolean
---Minimum view pitch, in degrees.
---@field ViewPitchMin number
---Maximum view pitch, in degrees.
---@field ViewPitchMax number
---Minimum view yaw, in degrees.
---@field ViewYawMin number
---Maximum view yaw, in degrees.
---@field ViewYawMax number
---Minimum view roll, in degrees.
---@field ViewRollMin number
---Maximum view roll, in degrees.
---@field ViewRollMax number
local PlayerCameraManager = {}

--- Methods
---Immediately stops the given shake instance and invalidates it.
---@param ShakeInstance CameraShakeBase
---@param bImmediately boolean
---@return nil
function PlayerCameraManager.StopCameraShake(ShakeInstance, bImmediately) end

---Stops camera fading.
---@return nil
function PlayerCameraManager.StopCameraFade() end

---Stops playing all shakes of the given class originating from the given source.
---@param Shake Class
---@param SourceComponent CameraShakeSourceComponent
---@param bImmediately boolean
---@return nil
function PlayerCameraManager.StopAllInstancesOfCameraShakeFromSource(Shake, SourceComponent, bImmediately) end

---Stops playing all shakes of the given class.
---@param Shake Class
---@param bImmediately boolean
---@return nil
function PlayerCameraManager.StopAllInstancesOfCameraShake(Shake, bImmediately) end

---Stops playing all shakes originating from the given source.
---@param SourceComponent CameraShakeSourceComponent
---@param bImmediately boolean
---@return nil
function PlayerCameraManager.StopAllCameraShakesFromSource(SourceComponent, bImmediately) end

---Stops all active camera shakes on this camera.
---@param bImmediately boolean
---@return nil
function PlayerCameraManager.StopAllCameraShakes(bImmediately) end

---Plays a camera shake on this camera.
---@param ShakeClass Class
---@param SourceComponent CameraShakeSourceComponent
---@param Scale number
---@param PlaySpace ECameraShakePlaySpace
---@param UserPlaySpaceRot Rotator
---@return CameraShakeBase
function PlayerCameraManager.StartCameraShakeFromSource(ShakeClass, SourceComponent, Scale, PlaySpace, UserPlaySpaceRot) end

---Plays a camera shake on this camera.
---@param ShakeClass Class
---@param Scale number
---@param PlaySpace ECameraShakePlaySpace
---@param UserPlaySpaceRot Rotator
---@return CameraShakeBase
function PlayerCameraManager.StartCameraShake(ShakeClass, Scale, PlaySpace, UserPlaySpaceRot) end

---Does a camera fade to/from a solid color.  Animates automatically.
---@param FromAlpha number
---@param ToAlpha number
---@param Duration number
---@param Color LinearColor
---@param bShouldFadeAudio boolean
---@param bHoldWhenFinished boolean
---@return nil
function PlayerCameraManager.StartCameraFade(FromAlpha, ToAlpha, Duration, Color, bShouldFadeAudio, bHoldWhenFinished) end

---Turns on camera fading at the given opacity. Does not auto-animate, allowing user to animate themselves.
---Call StopCameraFade to turn fading back off.
---@param InFadeAmount number
---@param Color LinearColor
---@param bInFadeAudio boolean
---@return nil
function PlayerCameraManager.SetManualCameraFade(InFadeAmount, Color, bInFadeAudio) end

---Sets the bGameCameraCutThisFrame flag to true (indicating we did a camera cut this frame; useful for game code to call, e.g., when performing a teleport that should be seamless)
---@return nil
function PlayerCameraManager.SetGameCameraCutThisFrame() end

---Removes the given lens effect from the camera.
---@param Emitter any
---@return nil
function PlayerCameraManager.RemoveGenericCameraLensEffect(Emitter) end

---Removes the given camera modifier from this camera (if it's on the camera in the first place) and discards it.
---@param ModifierToRemove CameraModifier
---@return boolean
function PlayerCameraManager.RemoveCameraModifier(ModifierToRemove) end

---Returns the PlayerController that owns this camera.
---@return PlayerController
function PlayerCameraManager.GetOwningPlayerController() end

---Returns the camera's current full FOV angle, in degrees.
---@return number
function PlayerCameraManager.GetFOVAngle() end

---Returns camera's current rotation.
---@return Rotator
function PlayerCameraManager.GetCameraRotation() end

---Returns camera's current location.
---@return Vector
function PlayerCameraManager.GetCameraLocation() end

---Returns camera modifier for this camera of the given class, if it exists.
---Exact class match only. If there are multiple modifiers of the same class, the first one is returned.
---@param ModifierClass Class
---@return CameraModifier
function PlayerCameraManager.FindCameraModifierByClass(ModifierClass) end

---Removes all camera lens effects.
---@return nil
function PlayerCameraManager.ClearCameraLensEffects() end

---Creates and initializes a new camera modifier of the specified class.
---@param ModifierClass Class
---@return CameraModifier
function PlayerCameraManager.AddNewCameraModifier(ModifierClass) end

---Creates a camera lens effect of the given class on this camera.
---@param LensEffectEmitterClass Class
---@return any
function PlayerCameraManager.AddGenericCameraLensEffect(LensEffectEmitterClass) end

return PlayerCameraManager
