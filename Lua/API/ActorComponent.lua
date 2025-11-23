---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ActorComponent
---ActorComponent is the base class for components that define reusable behavior that can be added to different types of Actors.
---ActorComponents that have a transform are known as SceneComponents and those that can be rendered are PrimitiveComponents.
---@see [ActorComponent](https://docs.unrealengine.com/latest/INT/Programming/UnrealArchitecture/Actors/Components/index.html#actorcomponents)
---@see USceneComponent
---@see UPrimitiveComponent
---
--- Properties
---Main tick function for the Component
---@field PrimaryComponentTick ActorComponentTickFunction
---Array of tags that can be used for grouping and categorizing. Can also be accessed from scripting.
---@field ComponentTags string[]
---Array of user data stored with the component
---@field AssetUserData AssetUserData[]
---Array of user data stored with the component
---@field AssetUserDataEditorOnly AssetUserData[]
---Is this component safe to ID over the network by name?
---@field bNetAddressable boolean
---When true the replication system will only replicate the registered subobjects list
---When false the replication system will instead call the virtual ReplicateSubObjects() function where the subobjects need to be manually replicated.
---@field bReplicateUsingRegisteredSubObjectList boolean
---
---@deprecated Replaced by CreationMethod
---@field bCreatedByConstructionScript boolean
---
---@deprecated Replaced by CreationMethod
---@field bInstanceComponent boolean
---Whether the component is activated at creation or must be explicitly activated.
---@field bAutoActivate boolean
---True if this component can be modified when it was inherited from a parent actor class
---@field bEditableWhenInherited boolean
---Whether this component can potentially influence navigation
---@field bCanEverAffectNavigation boolean
---If true, the component will be excluded from non-editor builds
---@field bIsEditorOnly boolean
---Describes how a component instance will be created
---@field CreationMethod EComponentCreationMethod
---Called when the component has been activated, with parameter indicating if it was from a reset
---@field OnComponentActivated function
---Called when the component has been deactivated
---@field OnComponentDeactivated function
local ActorComponent = {}

--- Methods
---Toggles the active state of the component
---@return nil
function ActorComponent.ToggleActive() end

---Changes the ticking group for this component
---@param NewTickGroup integer
---@return nil
function ActorComponent.SetTickGroup(NewTickGroup) end

---Sets whether this component can tick when paused.
---@param bTickableWhenPaused boolean
---@return nil
function ActorComponent.SetTickableWhenPaused(bTickableWhenPaused) end

---Enable or disable replication. This is the equivalent of RemoteRole for actors (only a bool is required for components)
---@param ShouldReplicate boolean
---@return nil
function ActorComponent.SetIsReplicated(ShouldReplicate) end

---Sets the tick interval for this component's primary tick function. Does not enable the tick interval. Takes effect imediately.
---@param TickInterval number
---@return nil
function ActorComponent.SetComponentTickIntervalAndCooldown(TickInterval) end

---Sets the tick interval for this component's primary tick function. Does not enable the tick interval. Takes effect on next tick.
---@param TickInterval number
---@return nil
function ActorComponent.SetComponentTickInterval(TickInterval) end

---Set this component's tick functions to be enabled or disabled. Only has an effect if the function is registered
---@param bEnabled boolean
---@return nil
function ActorComponent.SetComponentTickEnabled(bEnabled) end

---Sets whether the component should be auto activate or not. Only safe during construction scripts.
---@param bNewAutoActivate boolean
---@return nil
function ActorComponent.SetAutoActivate(bNewAutoActivate) end

---Sets whether the component is active or not
---@param bNewActive boolean
---@param bReset boolean
---@return nil
function ActorComponent.SetActive(bNewActive, bReset) end

---Remove tick dependency on PrerequisiteComponent.
---@param PrerequisiteComponent ActorComponent
---@return nil
function ActorComponent.RemoveTickPrerequisiteComponent(PrerequisiteComponent) end

---Remove tick dependency on PrerequisiteActor.
---@param PrerequisiteActor Actor
---@return nil
function ActorComponent.RemoveTickPrerequisiteActor(PrerequisiteActor) end

---Returns whether this component has tick enabled or not
---@return boolean
function ActorComponent.IsComponentTickEnabled() end

---Returns whether the component is in the process of being destroyed.
---@return boolean
function ActorComponent.IsBeingDestroyed() end

---Returns whether the component is active or not
---@return boolean
function ActorComponent.IsActive() end

---Follow the Outer chain to get the  AActor  that 'Owns' this component
---@return Actor
function ActorComponent.GetOwner() end

---Returns the tick interval for this component's primary tick function, which is the frequency in seconds at which it will be executed
---@return number
function ActorComponent.GetComponentTickInterval() end

---Deactivates the SceneComponent.
---@return nil
function ActorComponent.Deactivate() end

---See if this component contains the supplied tag
---@param Tag string
---@return boolean
function ActorComponent.ComponentHasTag(Tag) end

---Make this component tick after PrerequisiteComponent.
---@param PrerequisiteComponent ActorComponent
---@return nil
function ActorComponent.AddTickPrerequisiteComponent(PrerequisiteComponent) end

---Make this component tick after PrerequisiteActor
---@param PrerequisiteActor Actor
---@return nil
function ActorComponent.AddTickPrerequisiteActor(PrerequisiteActor) end

---Activates the SceneComponent, should be overridden by native child classes.
---@param bReset boolean
---@return nil
function ActorComponent.Activate(bReset) end

return ActorComponent
