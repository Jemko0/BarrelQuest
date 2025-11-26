---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class FXSystemComponent : PrimitiveComponent
---FXSystem Component
---
--- Properties
local FXSystemComponent = {}

--- Methods
---Set a named vector instance parameter on this ParticleSystemComponent.
---Updates the parameter if it already exists, or creates a new entry if not.
---@param ParameterName string
---@param Param Vector
---@return nil
function FXSystemComponent.SetVectorParameter(ParameterName, Param) end

---Sets whether we should automatically attach to AutoAttachParent when activated, and detach from our parent when completed.
---This overrides any current attachment that may be present at the time of activation (deferring initial attachment until activation, if AutoAttachParent is null).
---When enabled, detachment occurs regardless of whether AutoAttachParent is assigned, and the relative transform from the time of activation is restored.
---This also disables attachment on dedicated servers, where we don't actually activate even if bAutoActivate is true.
---@see SetAutoAttachmentParameters()
---@param bAutoManage boolean
---@return nil
function FXSystemComponent.SetUseAutoManageAttachment(bAutoManage) end

---Change a named int parameter
---@param ParameterName string
---@param Param integer
---@return nil
function FXSystemComponent.SetIntParameter(ParameterName, Param) end

---Change a named float parameter
---@param ParameterName string
---@param Param number
---@return nil
function FXSystemComponent.SetFloatParameter(ParameterName, Param) end

---Enables / disables an emitter by halting spawning of new particles.
---You will still pay the cost of the emitter update.
---@param EmitterName string
---@param bNewEnableState boolean
---@return nil
function FXSystemComponent.SetEmitterEnable(EmitterName, bNewEnableState) end

---Set a named color instance parameter on this ParticleSystemComponent.
---Updates the parameter if it already exists, or creates a new entry if not.
---@param ParameterName string
---@param Param LinearColor
---@return nil
function FXSystemComponent.SetColorParameter(ParameterName, Param) end

---Change a named boolean parameter, ParticleSystemComponent converts to float.
---@param ParameterName string
---@param Param boolean
---@return nil
function FXSystemComponent.SetBoolParameter(ParameterName, Param) end

---Set AutoAttachParent, AutoAttachSocketName, AutoAttachLocationRule, AutoAttachRotationRule, AutoAttachScaleRule to the specified parameters. Does not change bAutoManageAttachment; that must be set separately.
---@see bAutoManageAttachment, AutoAttachParent, AutoAttachSocketName, AutoAttachLocationRule, AutoAttachRotationRule, AutoAttachScaleRule
---@param Parent SceneComponent
---@param SocketName string
---@param LocationRule EAttachmentRule
---@param RotationRule EAttachmentRule
---@param ScaleRule EAttachmentRule
---@return nil
function FXSystemComponent.SetAutoAttachmentParameters(Parent, SocketName, LocationRule, RotationRule, ScaleRule) end

---Set a named actor instance parameter on this ParticleSystemComponent.
---Updates the parameter if it already exists, or creates a new entry if not.
---@param ParameterName string
---@param Param Actor
---@return nil
function FXSystemComponent.SetActorParameter(ParameterName, Param) end

---Deactivates this system and releases it to the pool on completion.
---Usage of this PSC reference after this call is unsafe.
---You should clear out your references to it.
---@return nil
function FXSystemComponent.ReleaseToPool() end

---Get the referenced FXSystem asset.
---@return FXSystemAsset
function FXSystemComponent.GetFXSystemAsset() end

return FXSystemComponent
