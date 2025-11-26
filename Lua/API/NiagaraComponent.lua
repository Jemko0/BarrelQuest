---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraComponent : FXSystemComponent
---UNiagaraComponent is the primitive component for a Niagara System.
---@see ANiagaraActor
---@see UNiagaraSystem
---
--- Properties
---True if we should automatically attach to AutoAttachParent when activated, and detach from our parent when completed.
---This overrides any current attachment that may be present at the time of activation (deferring initial attachment until activation, if AutoAttachParent is null).
---When enabled, detachment occurs regardless of whether AutoAttachParent is assigned, and the relative transform from the time of activation is restored.
---This also disables attachment on dedicated servers, where we don't actually activate even if bAutoActivate is true.
---@see AutoAttachParent, AutoAttachSocketName, AutoAttachLocationType
---@field bAutoManageAttachment boolean
---Option for how we handle bWeldSimulatedBodies when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment
---@field bAutoAttachWeldSimulatedBodies boolean
---Time between forced UpdateTransforms for systems that use dynamically calculated bounds,
---Which is effectively how often the bounds are shrunk.
---@field MaxTimeBeforeForceUpdateTransform number
---@field OcclusionQueryMode ENiagaraOcclusionQueryMode
---Called when the particle system is done
---@field OnSystemFinished function
---Component we automatically attach to when activated, if bAutoManageAttachment is true.
---If null during registration, we assign the existing AttachParent and defer attachment until we activate.
---@see bAutoManageAttachment
---@field AutoAttachParent any
---Socket we automatically attach to on the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment
---@field AutoAttachSocketName string
---Options for how we handle our location when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment, EAttachmentRule
---@field AutoAttachLocationRule EAttachmentRule
---Options for how we handle our rotation when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment, EAttachmentRule
---@field AutoAttachRotationRule EAttachmentRule
---Options for how we handle our scale when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment, EAttachmentRule
---@field AutoAttachScaleRule EAttachmentRule
---@field bWaitForCompilationOnActivate boolean
local NiagaraComponent = {}

--- Methods
---Sets a Niagara Vector4 parameter by name, overriding locally if necessary.
---@param InVariableName string
---@return nil
function NiagaraComponent.SetVariableVec4(InVariableName) end

---Sets a Niagara Vector3 parameter by name, overriding locally if necessary.
---@param InVariableName string
---@param InValue Vector
---@return nil
function NiagaraComponent.SetVariableVec3(InVariableName, InValue) end

---Sets a Niagara Vector2 parameter by name, overriding locally if necessary.
---@param InVariableName string
---@param InValue Vector2D
---@return nil
function NiagaraComponent.SetVariableVec2(InVariableName, InValue) end

---Set Variable Texture Render Target
---@param InVariableName string
---@param TextureRenderTarget TextureRenderTarget
---@return nil
function NiagaraComponent.SetVariableTextureRenderTarget(InVariableName, TextureRenderTarget) end

---Set Variable Texture
---@param InVariableName string
---@param Texture Texture
---@return nil
function NiagaraComponent.SetVariableTexture(InVariableName, Texture) end

---Set Variable Static Mesh
---@param InVariableName string
---@param InValue StaticMesh
---@return nil
function NiagaraComponent.SetVariableStaticMesh(InVariableName, InValue) end

---Sets a Niagara quaternion parameter by name, overriding locally if necessary.
---@param InVariableName string
---@return nil
function NiagaraComponent.SetVariableQuat(InVariableName) end

---Sets a Niagara Position parameter by name, overriding locally if necessary.
---@param InVariableName string
---@param InValue Vector
---@return nil
function NiagaraComponent.SetVariablePosition(InVariableName, InValue) end

---Set Variable Object
---@param InVariableName string
---@param Object Object
---@return nil
function NiagaraComponent.SetVariableObject(InVariableName, Object) end

---Sets a Niagara matrix parameter by name, overriding locally if necessary.
---@param InVariableName string
---@return nil
function NiagaraComponent.SetVariableMatrix(InVariableName) end

---Set Variable Material
---@param InVariableName string
---@param Object MaterialInterface
---@return nil
function NiagaraComponent.SetVariableMaterial(InVariableName, Object) end

---Sets a Niagara FLinearColor parameter by name, overriding locally if necessary.
---@param InVariableName string
---@return nil
function NiagaraComponent.SetVariableLinearColor(InVariableName) end

---Sets a Niagara int parameter by name, overriding locally if necessary.
---@param InVariableName string
---@param InValue integer
---@return nil
function NiagaraComponent.SetVariableInt(InVariableName, InValue) end

---Sets a Niagara float parameter by name, overriding locally if necessary.
---@param InVariableName string
---@param InValue number
---@return nil
function NiagaraComponent.SetVariableFloat(InVariableName, InValue) end

---Sets a Niagara bool parameter by name, overriding locally if necessary.
---@param InVariableName string
---@param InValue boolean
---@return nil
function NiagaraComponent.SetVariableBool(InVariableName, InValue) end

---Set Variable Actor
---@param InVariableName string
---@param Actor Actor
---@return nil
function NiagaraComponent.SetVariableActor(InVariableName, Actor) end

---Set Tick Behavior
---@param NewTickBehavior ENiagaraTickBehavior
---@return nil
function NiagaraComponent.SetTickBehavior(NewTickBehavior) end

---Sets the fixed bounds for the system instance, this overrides all other bounds.
---The box is expected to be in local space not world space.
---A default uninitialized box will clear the fixed bounds and revert back to system fixed / dynamic bounds.
---@param LocalBounds Box
---@return nil
function NiagaraComponent.SetSystemFixedBounds(LocalBounds) end

---Sets the simulation cache to use for the component.
---A null SimCache parameter will clear the active simulation cache.
---When clearing a simulation cache that has been running you may wish to reset or continue, this option is only
---valid when using a full simulation cache.  A renderer only cache will always reset as we can not continue the
---simulation due to missing simulation data.
---@param SimCache NiagaraSimCache
---@param bResetSystem boolean
---@return nil
function NiagaraComponent.SetSimCache(SimCache, bResetSystem) end

---Sets the delta value which is used when seeking from the current age, to the desired age.  This is only relevant
---      when using the DesiredAge age update mode.
---@param InSeekDelta number
---@return nil
function NiagaraComponent.SetSeekDelta(InSeekDelta) end

---Sets whether or not rendering is enabled for this component.
---@param bInRenderingEnabled boolean
---@return nil
function NiagaraComponent.SetRenderingEnabled(bInRenderingEnabled) end

---Set Random Seed Offset
---@param NewRandomSeedOffset integer
---@return nil
function NiagaraComponent.SetRandomSeedOffset(NewRandomSeedOffset) end

---Set Preview LODDistance
---@param bEnablePreviewLODDistance boolean
---@param PreviewLODDistance number
---@param PreviewMaxDistance number
---@return nil
function NiagaraComponent.SetPreviewLODDistance(bEnablePreviewLODDistance, PreviewLODDistance, PreviewMaxDistance) end

---Set Paused
---@param bInPaused boolean
---@return nil
function NiagaraComponent.SetPaused(bInPaused) end

---Set Occlusion Query Mode
---@param Mode ENiagaraOcclusionQueryMode
---@return nil
function NiagaraComponent.SetOcclusionQueryMode(Mode) end

---Set Niagara Variable Vec 4
---@param InVariableName string
---@return nil
function NiagaraComponent.SetNiagaraVariableVec4(InVariableName) end

---Set Niagara Variable Vec 3
---@param InVariableName string
---@param InValue Vector
---@return nil
function NiagaraComponent.SetNiagaraVariableVec3(InVariableName, InValue) end

---Set Niagara Variable Vec 2
---@param InVariableName string
---@param InValue Vector2D
---@return nil
function NiagaraComponent.SetNiagaraVariableVec2(InVariableName, InValue) end

---Set Niagara Variable Quat
---@param InVariableName string
---@return nil
function NiagaraComponent.SetNiagaraVariableQuat(InVariableName) end

---Set Niagara Variable Position
---@param InVariableName string
---@param InValue Vector
---@return nil
function NiagaraComponent.SetNiagaraVariablePosition(InVariableName, InValue) end

---Set Niagara Variable Object
---@param InVariableName string
---@param Object Object
---@return nil
function NiagaraComponent.SetNiagaraVariableObject(InVariableName, Object) end

---Set Niagara Variable Matrix
---@param InVariableName string
---@return nil
function NiagaraComponent.SetNiagaraVariableMatrix(InVariableName) end

---Set Niagara Variable Linear Color
---@param InVariableName string
---@return nil
function NiagaraComponent.SetNiagaraVariableLinearColor(InVariableName) end

---Set Niagara Variable Int
---@param InVariableName string
---@param InValue integer
---@return nil
function NiagaraComponent.SetNiagaraVariableInt(InVariableName, InValue) end

---Set Niagara Variable Float
---@param InVariableName string
---@param InValue number
---@return nil
function NiagaraComponent.SetNiagaraVariableFloat(InVariableName, InValue) end

---Set Niagara Variable Bool
---@param InVariableName string
---@param InValue boolean
---@return nil
function NiagaraComponent.SetNiagaraVariableBool(InVariableName, InValue) end

---Set Niagara Variable Actor
---@param InVariableName string
---@param Actor Actor
---@return nil
function NiagaraComponent.SetNiagaraVariableActor(InVariableName, Actor) end

---Sets the maximum CPU time in seconds we will simulate to the desired age, when we go beyond this limit ticks will be processed in the next frame.
---This is only relevant when using the DesiredAge age update mode.
---Note: The componet will not be visibile if we have ticks to process and SetCanRenderWhileSeeking is set to true
---@param InMaxTime number
---@return nil
function NiagaraComponent.SetMaxSimTime(InMaxTime) end

---Sets whether or not the delta time used to tick the system instance when using desired age is locked to the seek delta.  When true, the system instance
---      will only be ticked when the desired age has changed by more than the seek delta.  When false the system instance will be ticked by the change in desired
---      age when not seeking.
---@param bLock boolean
---@return nil
function NiagaraComponent.SetLockDesiredAgeDeltaTimeToSeekDelta(bLock) end

---Set Gpu Compute Debug
---@param bEnableDebug boolean
---@return nil
function NiagaraComponent.SetGpuComputeDebug(bEnableDebug) end

---Set Force Solo
---@param bInForceSolo boolean
---@return nil
function NiagaraComponent.SetForceSolo(bInForceSolo) end

---Set Force Local Player Effect
---@param bIsPlayerEffect boolean
---@return nil
function NiagaraComponent.SetForceLocalPlayerEffect(bIsPlayerEffect) end

---Sets the fixed bounds for an emitter instance, this overrides all other bounds.
---The box is expected to be in local space not world space.
---A default uninitialized box will clear the fixed bounds and revert back to emitter fixed / dynamic bounds.
---@param EmitterName string
---@param LocalBounds Box
---@return nil
function NiagaraComponent.SetEmitterFixedBounds(EmitterName, LocalBounds) end

---Sets the desired age of the System instance.  This is only relevant when using the DesiredAge age update mode.
---@param InDesiredAge number
---@return nil
function NiagaraComponent.SetDesiredAge(InDesiredAge) end

---Sets the custom time dilation value for the component.
---Note: This is only available on components that are in solo mode currently.
---@param Dilation number
---@return nil
function NiagaraComponent.SetCustomTimeDilation(Dilation) end

---Sets whether or not the system can render while seeking.
---@param bInCanRenderWhileSeeking boolean
---@return nil
function NiagaraComponent.SetCanRenderWhileSeeking(bInCanRenderWhileSeeking) end

---Set Auto Destroy
---@param bInAutoDestroy boolean
---@return nil
function NiagaraComponent.SetAutoDestroy(bInAutoDestroy) end

---Switch which asset the component is using.
---This requires Niagara to wait for concurrent execution and the override parameter store to be synchronized with the new asset.
---By default existing parameters are reset when we call SetAsset, modify bResetExistingOverrideParameters to leave existing parameter data as is.
---@param InAsset NiagaraSystem
---@param bResetExistingOverrideParameters boolean
---@return nil
function NiagaraComponent.SetAsset(InAsset, bResetExistingOverrideParameters) end

---Set whether this component is allowed to perform scalability checks and potentially be culled etc. Occasionally it is useful to disable this for specific components. E.g. Effects on the local player.
---@param bAllow boolean
---@return nil
function NiagaraComponent.SetAllowScalability(bAllow) end

---Sets the age update mode for the System instance.
---@param InAgeUpdateMode ENiagaraAgeUpdateMode
---@return nil
function NiagaraComponent.SetAgeUpdateMode(InAgeUpdateMode) end

---Sets the desired age of the System instance and designates that this change is a seek.  When seeking to a desired age the
---          The component can optionally prevent rendering.
---@param InDesiredAge number
---@return nil
function NiagaraComponent.SeekToDesiredAge(InDesiredAge) end

---Resets the System to it's initial pre-simulated state.
---@return nil
function NiagaraComponent.ResetSystem() end

---Called on when an external object wishes to force this System to reinitialize itself from the System data.
---@return nil
function NiagaraComponent.ReinitializeSystem() end

---Is Paused
---@return boolean
function NiagaraComponent.IsPaused() end

---Initializes this component for capturing a performance baseline.
---This will do things such as disabling distance culling and setting a LODDistance of 0 to ensure the effect is at it's maximum cost.
---@return nil
function NiagaraComponent.InitForPerformanceBaseline() end

---Get Tick Behavior
---@return ENiagaraTickBehavior
function NiagaraComponent.GetTickBehavior() end

---Gets the fixed bounds for the system instance.
---This will return the user set fixed bounds if set, or the systems fixed bounds if set.
---Note: The returned box may be invalid if no fixed bounds exist
---@return Box
function NiagaraComponent.GetSystemFixedBounds() end

---Get the active simulation cache, will return null if we do not have an active one.
---@return NiagaraSimCache
function NiagaraComponent.GetSimCache() end

---Gets the delta value which is used when seeking from the current age, to the desired age.  This is only relevant
---      when using the DesiredAge age update mode.
---@return number
function NiagaraComponent.GetSeekDelta() end

---Get Random Seed Offset
---@return integer
function NiagaraComponent.GetRandomSeedOffset() end

---Get Preview LODDistance Enabled
---@return boolean
function NiagaraComponent.GetPreviewLODDistanceEnabled() end

---Get Preview LODDistance
---@return number
function NiagaraComponent.GetPreviewLODDistance() end

---Get Occlusion Query Mode
---@return ENiagaraOcclusionQueryMode
function NiagaraComponent.GetOcclusionQueryMode() end

---Get the maximum CPU time in seconds we will simulate to the desired age, when we go beyond this limit ticks will be processed in the next frame.
---This is only relevant when using the DesiredAge age update mode.
---Note: The componet will not be visibile if we have ticks to process and SetCanRenderWhileSeeking is set to true
---@return number
function NiagaraComponent.GetMaxSimTime() end

---Gets whether or not the delta time used to tick the system instance when using desired age is locked to the seek delta.  When true, the system instance
---      will only be ticked when the desired age has changed by more than the seek delta.  When false the system instance will be ticked by the change in desired
---      age when not seeking.
---@return boolean
function NiagaraComponent.GetLockDesiredAgeDeltaTimeToSeekDelta() end

---Get Force Solo
---@return boolean
function NiagaraComponent.GetForceSolo() end

---Get Force Local Player Effect
---@return boolean
function NiagaraComponent.GetForceLocalPlayerEffect() end

---Gets the fixed bounds for an emitter instance.
---This will return the user set fixed bounds if set, or the emitters fixed bounds if set.
---Note: The returned box may be invalid if no fixed bounds exist
---@param EmitterName string
---@return Box
function NiagaraComponent.GetEmitterFixedBounds(EmitterName) end

---Gets the desired age of the System instance.  This is only relevant when using the DesiredAge age update mode.
---@return number
function NiagaraComponent.GetDesiredAge() end

---Get Data Interface
---@param Name string
---@return NiagaraDataInterface
function NiagaraComponent.GetDataInterface(Name) end

---Get Custom Time Dilation
---@return number
function NiagaraComponent.GetCustomTimeDilation() end

---Get Asset
---@return NiagaraSystem
function NiagaraComponent.GetAsset() end

---Get Allow Scalability
---@return boolean
function NiagaraComponent.GetAllowScalability() end

---Get Age Update Mode
---@return ENiagaraAgeUpdateMode
function NiagaraComponent.GetAgeUpdateMode() end

---Clear any previously set fixed bounds for the system instance.
---@return nil
function NiagaraComponent.ClearSystemFixedBounds() end

---Clear any active simulation cache.
---When clearing a simulation cache that has been running you may wish to reset or continue, this option is only
---valid when using a full simulation cache.  A renderer only cache will always reset as we can not continue the
---simulation due to missing simulation data.
---@param bResetSystem boolean
---@return nil
function NiagaraComponent.ClearSimCache(bResetSystem) end

---Clear any previously set fixed bounds for the emitter instance.
---@param EmitterName string
---@return nil
function NiagaraComponent.ClearEmitterFixedBounds(EmitterName) end

---Advances this system's simulation by the specified time in seconds and delta time. Advancement is done in whole ticks of TickDeltaSeconds so actual simulated time will be the nearest lower multiple of TickDeltaSeconds.
---@param SimulateTime number
---@param TickDeltaSeconds number
---@return nil
function NiagaraComponent.AdvanceSimulationByTime(SimulateTime, TickDeltaSeconds) end

---Advances this system's simulation by the specified number of ticks and delta time.
---@param TickCount integer
---@param TickDeltaSeconds number
---@return nil
function NiagaraComponent.AdvanceSimulation(TickCount, TickDeltaSeconds) end

return NiagaraComponent
