---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SceneComponent : ActorComponent
---A SceneComponent has a transform and supports attachment, but has no rendering or collision capabilities.
---Useful as a 'dummy' component in the hierarchy to offset others.
---@see [Scene Components](https://docs.unrealengine.com/latest/INT/Programming/UnrealArchitecture/Actors/Components/index.html#scenecomponents)
---
--- Properties
---Velocity of the component.
---@see GetComponentVelocity()
---@field ComponentVelocity Vector
---Whether to hide the primitive in game, if the primitive is Visible.
---@field bHiddenInGame boolean
---If true, a change in the bounds of the component will call trigger a streaming data rebuild
---@field bBoundsChangeTriggersStreamingDataRebuild boolean
---If true, this component uses its parents bounds when attached.
---This can be a significant optimization with many components attached together.
---@field bUseAttachParentBound boolean
---If true, this component will use its current bounds transformed back into local space instead of calling CalcBounds with an identity transform.
---@field bComputeFastLocalBounds boolean
---If true, this component will cache its bounds during cooking or in PIE and never recompute it again. This is for components that are known to be static.
---@field bComputeBoundsOnceForGame boolean
---If true, this component has already cached its bounds during cooking or in PIE and will never recompute it again.
---@field bComputedBoundsOnceForGame boolean
---If true, this component stops the walk up the attachment chain in GetActorPositionForRenderer(). Instead this component's child will be used as the attachment root.
---@field bIsNotRenderAttachmentRoot boolean
---This component should create a sprite component for visualization in the editor
---@field bVisualizeComponent boolean
---How often this component is allowed to move, used to make various optimizations. Only safe to set in constructor.
---@field Mobility integer
---If detail mode is >= system detail mode, primitive won't be rendered.
---@field DetailMode integer
---Delegate that will be called when PhysicsVolume has been changed *
---@field PhysicsVolumeChangedDelegate function
local SceneComponent = {}

--- Methods
---Toggle visibility of the component
---@param bPropagateToChildren boolean
---@return nil
function SceneComponent.ToggleVisibility(bPropagateToChildren) end

---Set the relative scale of the component to put it at the supplied scale in world space.
---@param NewScale Vector
---@return nil
function SceneComponent.SetWorldScale3D(NewScale) end

---Set visibility of the component, if during game use this to turn on/off
---@param bNewVisibility boolean
---@param bPropagateToChildren boolean
---@return nil
function SceneComponent.SetVisibility(bNewVisibility, bPropagateToChildren) end

---Sets whether or not the cached PhysicsVolume this component overlaps should be updated when the component is moved.
---@param bInShouldUpdatePhysicsVolume boolean
---@return nil
function SceneComponent.SetShouldUpdatePhysicsVolume(bInShouldUpdatePhysicsVolume) end

---Set the non-uniform scale of the component relative to its parent
---@param NewScale3D Vector
---@return nil
function SceneComponent.SetRelativeScale3D(NewScale3D) end

---Set how often this component is allowed to move during runtime. Causes a component re-register if the component is already registered
---@param NewMobility integer
---@return nil
function SceneComponent.SetMobility(NewMobility) end

---Changes the value of bHiddenInGame, if false this will disable Visibility during gameplay
---@param NewHidden boolean
---@param bPropagateToChildren boolean
---@return nil
function SceneComponent.SetHiddenInGame(NewHidden, bPropagateToChildren) end

---Set which parts of the relative transform should be relative to parent, and which should be relative to world
---@param bNewAbsoluteLocation boolean
---@param bNewAbsoluteRotation boolean
---@param bNewAbsoluteScale boolean
---@return nil
function SceneComponent.SetAbsolute(bNewAbsoluteLocation, bNewAbsoluteRotation, bNewAbsoluteScale) end

---Reset the transform of the component relative to its parent. Sets relative location to zero, relative rotation to no rotation, and Scale to 1.
---@return nil
function SceneComponent.ResetRelativeTransform() end

---Returns true if this component is visible in the current context
---@return boolean
function SceneComponent.IsVisible() end

---Returns whether the specified body is currently using physics simulation
---@param BoneName string
---@return boolean
function SceneComponent.IsSimulatingPhysics(BoneName) end

---Returns whether the specified body is currently using physics simulation
---@return boolean
function SceneComponent.IsAnySimulatingPhysics() end

---Get the up (Z) unit direction vector from this component, in world space.
---@return Vector
function SceneComponent.GetUpVector() end

---Get world-space socket transform.
---@param InSocketName string
---@param TransformSpace integer
---@return Transform
function SceneComponent.GetSocketTransform(InSocketName, TransformSpace) end

---Get world-space socket or bone  FRotator rotation.
---@param InSocketName string
---@return Rotator
function SceneComponent.GetSocketRotation(InSocketName) end

---Get world-space socket or bone FQuat rotation.
---@param InSocketName string
---@return Quat
function SceneComponent.GetSocketQuaternion(InSocketName) end

---Get world-space socket or bone location.
---@param InSocketName string
---@return Vector
function SceneComponent.GetSocketLocation(InSocketName) end

---Gets whether or not the cached PhysicsVolume this component overlaps should be updated when the component is moved.
---@return boolean
function SceneComponent.GetShouldUpdatePhysicsVolume() end

---Get the right (Y) unit direction vector from this component, in world space.
---@return Vector
function SceneComponent.GetRightVector() end

---Returns the transform of the component relative to its parent
---@return Transform
function SceneComponent.GetRelativeTransform() end

---Get the PhysicsVolume overlapping this component.
---@return PhysicsVolume
function SceneComponent.GetPhysicsVolume() end

---Gets all attachment parent components up to and including the root component
---@return nil, SceneComponent[]
function SceneComponent.GetParentComponents() end

---Gets the number of attached children components
---@return integer
function SceneComponent.GetNumChildrenComponents() end

---Get the forward (X) unit direction vector from this component, in world space.
---@return Vector
function SceneComponent.GetForwardVector() end

---Get velocity of the component: either ComponentVelocity, or the velocity of the physics body if simulating physics.
---@return Vector
function SceneComponent.GetComponentVelocity() end

---Gets all components that are attached to this component, possibly recursively
---@param bIncludeAllDescendants boolean
---@return nil, SceneComponent[]
function SceneComponent.GetChildrenComponents(bIncludeAllDescendants) end

---Gets the attached child component at the specified location
---@param ChildIndex integer
---@return SceneComponent
function SceneComponent.GetChildComponent(ChildIndex) end

---Get the socket we are attached to.
---@return string
function SceneComponent.GetAttachSocketName() end

---Get the SceneComponent we are attached to.
---@return SceneComponent
function SceneComponent.GetAttachParent() end

---Gets the names of all the sockets on the component.
---@return string[]
function SceneComponent.GetAllSocketNames() end

---Return true if socket with the given name exists
---@param InSocketName string
---@return boolean
function SceneComponent.DoesSocketExist(InSocketName) end

---Detach from Parent
---@param bMaintainWorldPosition boolean
---@param bCallModify boolean
---@return nil
function SceneComponent.DetachFromParent(bMaintainWorldPosition, bCallModify) end

return SceneComponent
