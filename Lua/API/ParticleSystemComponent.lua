---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ParticleSystemComponent : FXSystemComponent
---A particle emitter.
---
--- Properties
---@field Template ParticleSystem
---@field EmitterMaterials MaterialInterface[]
---The skeletal mesh components used with the socket location module.
---This is to prevent them from being garbage collected.
---@field SkelMeshComponents SkeletalMeshComponent[]
---@field bResetOnDetach boolean
---whether to update the particle system on dedicated servers
---@field bUpdateOnDedicatedServer boolean
---If true, this Particle System will be available for recycling after it has completed. Auto-destroyed systems cannot be recycled.
---Some systems (currently particle trail effects) can recycle components to avoid respawning them to play new effects.
---This is only an optimization and does not change particle system behavior, aside from not triggering normal component initialization events more than once.
---@field bAllowRecycling boolean
---True if we should automatically attach to AutoAttachParent when activated, and detach from our parent when completed.
---This overrides any current attachment that may be present at the time of activation (deferring initial attachment until activation, if AutoAttachParent is null).
---When enabled, detachment occurs regardless of whether AutoAttachParent is assigned, and the relative transform from the time of activation is restored.
---This also disables attachment on dedicated servers, where we don't actually activate even if bAutoActivate is true.
---@see AutoAttachParent, AutoAttachSocketName, AutoAttachLocationType
---@field bAutoManageAttachment boolean
---Option for how we handle bWeldSimulatedBodies when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment
---@field bAutoAttachWeldSimulatedBodies boolean
---@field bWarmingUp boolean
---indicates that the component's LODMethod overrides the Template's
---@field bOverrideLODMethod boolean
---Flag indicating that dynamic updating of render data should NOT occur during Tick.
---This is used primarily to allow for warming up and simulated effects to a certain state.
---@field bSkipUpdateDynamicDataDuringTick boolean
---The method of LOD level determination to utilize for this particle system
---@field LODMethod integer
---The significance this component requires of it's emitters for them to be enabled.
---@field RequiredSignificance EParticleSignificanceLevel
---Array holding name instance parameters for this ParticleSystemComponent.
---Parameters can be used in Cascade using DistributionFloat/VectorParticleParameters.
---@field InstanceParameters ParticleSysParam[]
---@field OnParticleSpawn function
---@field OnParticleBurst function
---@field OnParticleDeath function
---@field OnParticleCollide function
---@field bOldPositionValid boolean
---@field OldPosition Vector
---@field PartSysVelocity Vector
---@field WarmupTime number
---@field WarmupTickRate number
---Number of seconds of emitter not being rendered that need to pass before it
---no longer gets ticked/ becomes inactive.
---@field SecondsBeforeInactive number
---Time between forced UpdateTransforms for systems that use dynamically calculated bounds,
---Which is effectively how often the bounds are shrunk.
---@field MaxTimeBeforeForceUpdateTransform number
---INTERNAL. Used by the editor to set the LODLevel
---@field EditorLODLevel integer
---Used for applying Cascade's detail mode setting to in-level particle systems
---@field EditorDetailMode integer
---Array of replay clips for this particle system component.  These are serialized to disk.  You really should never add anything to this in the editor.  It's exposed so that you can delete clips if you need to, but be careful when doing so!
---@field ReplayClips ParticleSystemReplay[]
---Scales DeltaTime in UParticleSystemComponent::Tick(...)
---@field CustomTimeDilation number
---Component we automatically attach to when activated, if bAutoManageAttachment is true.
---If null during registration, we assign the existing AttachParent and defer attachment until we activate.
---@see bAutoManageAttachment
---@field AutoAttachParent any
---Socket we automatically attach to on the AutoAttachParent, if bAutoManageAttachment is true.
---If no auto attach socket name is set during registration, the current attach socket will be
---assigned to AutoAttachSocketName and used when activated.
---@see bAutoManageAttachment
---@field AutoAttachSocketName string
---DEPRECATED: Options for how we handle our location when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---See: bAutoManageAttachment, EAttachLocation::Type
---@field AutoAttachLocationType integer
---Options for how we handle our location when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment, EAttachmentRule
---@field AutoAttachLocationRule EAttachmentRule
---Options for how we handle our rotation when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment, EAttachmentRule
---@field AutoAttachRotationRule EAttachmentRule
---Options for how we handle our scale when we attach to the AutoAttachParent, if bAutoManageAttachment is true.
---@see bAutoManageAttachment, EAttachmentRule
---@field AutoAttachScaleRule EAttachmentRule
---Called when the particle system is done
---@field OnSystemFinished function
local ParticleSystemComponent = {}

--- Methods
---Sets the defining data for all trails in this component.
---@param InFirstSocketName string
---@param InSecondSocketName string
---@param InWidthMode integer
---@param InWidth number
---@return nil
function ParticleSystemComponent.SetTrailSourceData(InFirstSocketName, InSecondSocketName, InWidthMode, InWidth) end

---Change the ParticleSystem used by this ParticleSystemComponent
---@param NewTemplate ParticleSystem
---@return nil
function ParticleSystemComponent.SetTemplate(NewTemplate) end

---Set a named material instance parameter on this ParticleSystemComponent.
---Updates the parameter if it already exists, or creates a new entry if not.
---@param ParameterName string
---@param Param MaterialInterface
---@return nil
function ParticleSystemComponent.SetMaterialParameter(ParameterName, Param) end

---Set the beam target tangent
---@param EmitterIndex integer
---@param NewTangentPoint Vector
---@param TargetIndex integer
---@return nil
function ParticleSystemComponent.SetBeamTargetTangent(EmitterIndex, NewTangentPoint, TargetIndex) end

---Set the beam target strength
---@param EmitterIndex integer
---@param NewTargetStrength number
---@param TargetIndex integer
---@return nil
function ParticleSystemComponent.SetBeamTargetStrength(EmitterIndex, NewTargetStrength, TargetIndex) end

---Set the beam target point
---@param EmitterIndex integer
---@param NewTargetPoint Vector
---@param TargetIndex integer
---@return nil
function ParticleSystemComponent.SetBeamTargetPoint(EmitterIndex, NewTargetPoint, TargetIndex) end

---Set the beam source tangent
---@param EmitterIndex integer
---@param NewTangentPoint Vector
---@param SourceIndex integer
---@return nil
function ParticleSystemComponent.SetBeamSourceTangent(EmitterIndex, NewTangentPoint, SourceIndex) end

---Set the beam source strength
---@param EmitterIndex integer
---@param NewSourceStrength number
---@param SourceIndex integer
---@return nil
function ParticleSystemComponent.SetBeamSourceStrength(EmitterIndex, NewSourceStrength, SourceIndex) end

---Set the beam source point
---@param EmitterIndex integer
---@param NewSourcePoint Vector
---@param SourceIndex integer
---@return nil
function ParticleSystemComponent.SetBeamSourcePoint(EmitterIndex, NewSourcePoint, SourceIndex) end

---Set the beam end point
---@param EmitterIndex integer
---@param NewEndPoint Vector
---@return nil
function ParticleSystemComponent.SetBeamEndPoint(EmitterIndex, NewEndPoint) end

---DEPRECATED: Set AutoAttachParent, AutoAttachSocketName, AutoAttachLocationType to the specified parameters. Does not change bAutoManageAttachment; that must be set separately.
---@see bAutoManageAttachment, AutoAttachParent, AutoAttachSocketName, AutoAttachLocationType
---@param Parent SceneComponent
---@param SocketName string
---@param LocationType integer
---@return nil
function ParticleSystemComponent.SetAutoAttachParams(Parent, SocketName, LocationType) end

---Get the current number of active particles in this system
---@return integer
function ParticleSystemComponent.GetNumActiveParticles() end

---Returns a named material. If this named material is not found, returns NULL.
---@param InName string
---@return MaterialInterface
function ParticleSystemComponent.GetNamedMaterial(InName) end

---Get the beam target tangent
---                false           EmitterIndex or TargetIndex is invalid - OutTangentPoint is invalid
---@param EmitterIndex integer
---@param TargetIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamTargetTangent(EmitterIndex, TargetIndex) end

---Get the beam target strength
---                false           EmitterIndex or TargetIndex is invalid - OutTargetStrength is invalid
---@param EmitterIndex integer
---@param TargetIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamTargetStrength(EmitterIndex, TargetIndex) end

---Get the beam target point
---                false           EmitterIndex or TargetIndex is invalid - OutTargetPoint is invalid
---@param EmitterIndex integer
---@param TargetIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamTargetPoint(EmitterIndex, TargetIndex) end

---Get the beam source tangent
---                false           EmitterIndex or SourceIndex is invalid - OutTangentPoint is invalid
---@param EmitterIndex integer
---@param SourceIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamSourceTangent(EmitterIndex, SourceIndex) end

---Get the beam source strength
---                false           EmitterIndex or SourceIndex is invalid - OutSourceStrength is invalid
---@param EmitterIndex integer
---@param SourceIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamSourceStrength(EmitterIndex, SourceIndex) end

---Get the beam source point
---                false           EmitterIndex or SourceIndex is invalid - OutSourcePoint is invalid
---@param EmitterIndex integer
---@param SourceIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamSourcePoint(EmitterIndex, SourceIndex) end

---Get the beam end point
---                false           EmitterIndex invalid or End point is not set - OutEndPoint is invalid
---@param EmitterIndex integer
---@return boolean
function ParticleSystemComponent.GetBeamEndPoint(EmitterIndex) end

---Record a kismet event.
---@param InEventName string
---@param InEmitterTime number
---@param InLocation Vector
---@param InDirection Vector
---@param InVelocity Vector
---@return nil
function ParticleSystemComponent.GenerateParticleEvent(InEventName, InEmitterTime, InLocation, InDirection, InVelocity) end

---Ends all trail emitters in this component.
---@return nil
function ParticleSystemComponent.EndTrails() end

---Creates a Dynamic Material Instance for the specified named material override, optionally from the supplied material.
---@param InName string
---@param SourceMaterial MaterialInterface
---@return MaterialInstanceDynamic
function ParticleSystemComponent.CreateNamedDynamicMaterialInstance(InName, SourceMaterial) end

---Begins all trail emitters in this component.
---@param InFirstSocketName string
---@param InSecondSocketName string
---@param InWidthMode integer
---@param InWidth number
---@return nil
function ParticleSystemComponent.BeginTrails(InFirstSocketName, InSecondSocketName, InWidthMode, InWidth) end

return ParticleSystemComponent
