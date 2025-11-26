---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SceneComponent : ActorComponent
---A SceneComponent has a transform and supports attachment, but has no rendering or collision capabilities.
---Useful as a 'dummy' component in the hierarchy to offset others.
---@see [Scene Components](https://docs.unrealengine.com/latest/INT/Programming/UnrealArchitecture/Actors/Components/index.html#scenecomponents)
---
--- Properties
---
---Velocity of the component.
---\@see GetComponentVelocity()
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

---Set the transform of the component in world space.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetWorldTransform(bSweep, bTeleport) end

---* Put this component at the specified rotation in world space. Updates relative rotation to achieve the final world rotation.
---* @param NewRotation           New rotation in world space for the component.
---* @param SweepHitResult        Hit result from any impact if sweep is true.
---* @param bSweep                        Whether we sweep to the destination (currently not supported for rotation).
---* @param bTeleport                     Whether we teleport the physics state (if physics collision is enabled for this object).
---*                                                      If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---*                                                      If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---*                                                      If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param NewRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetWorldRotation(NewRotation, bSweep, bTeleport) end

---Set the relative location and rotation of the component to put it at the supplied pose in world space.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param NewLocation Vector
---@param NewRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetWorldLocationAndRotation(NewLocation, NewRotation, bSweep, bTeleport) end

---Put this component at the specified location in world space. Updates relative location to achieve the final world location.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param NewLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetWorldLocation(NewLocation, bSweep, bTeleport) end

---Set the transform of the component relative to its parent
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetRelativeTransform(bSweep, bTeleport) end

---Set the rotation of the component relative to its parent
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---@param NewRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetRelativeRotation(NewRotation, bSweep, bTeleport) end

---Set the location and rotation of the component relative to its parent
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param NewLocation Vector
---@param NewRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetRelativeLocationAndRotation(NewLocation, NewRotation, bSweep, bTeleport) end

---Set the location of the component relative to its parent
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param NewLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_SetRelativeLocation(NewLocation, bSweep, bTeleport) end

---Get the current component-to-world transform for this component
---@return Transform
function SceneComponent.K2_GetComponentToWorld() end

---Returns scale of the component, in world space.
---@return Vector
function SceneComponent.K2_GetComponentScale() end

---Returns rotation of the component, in world space.
---@return Rotator
function SceneComponent.K2_GetComponentRotation() end

---Return location of the component, in world space
---@return Vector
function SceneComponent.K2_GetComponentLocation() end

---Detach this component from whatever it is attached to. Automatically unwelds components that are welded together (see AttachToComponent), though note that some effects of welding may not be undone.
---@param LocationRule EDetachmentRule
---@param RotationRule EDetachmentRule
---@param ScaleRule EDetachmentRule
---@param bCallModify boolean
---@return nil
function SceneComponent.K2_DetachFromComponent(LocationRule, RotationRule, ScaleRule, bCallModify) end

---Attach this component to another scene component, optionally at a named socket. It is valid to call this on components whether or not they have been Registered.
---@param Parent SceneComponent
---@param SocketName string
---@param LocationRule EAttachmentRule
---@param RotationRule EAttachmentRule
---@param ScaleRule EAttachmentRule
---@param bWeldSimulatedBodies boolean
---@return boolean
function SceneComponent.K2_AttachToComponent(Parent, SocketName, LocationRule, RotationRule, ScaleRule, bWeldSimulatedBodies) end

---K2 Attach To
---@param InParent SceneComponent
---@param InSocketName string
---@param AttachType integer
---@param bWeldSimulatedBodies boolean
---@return boolean
function SceneComponent.K2_AttachTo(InParent, InSocketName, AttachType, bWeldSimulatedBodies) end

---Adds a delta to the transform of the component in world space. Scale is unchanged.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddWorldTransformKeepScale(bSweep, bTeleport) end

---Adds a delta to the transform of the component in world space. Ignores scale and sets it to (1,1,1).
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddWorldTransform(bSweep, bTeleport) end

---Adds a delta to the rotation of the component in world space.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param DeltaRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddWorldRotation(DeltaRotation, bSweep, bTeleport) end

---Adds a delta to the location of the component in world space.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param DeltaLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddWorldOffset(DeltaLocation, bSweep, bTeleport) end

---Adds a delta the rotation of the component relative to its parent
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---@param DeltaRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddRelativeRotation(DeltaRotation, bSweep, bTeleport) end

---Adds a delta to the translation of the component relative to its parent
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param DeltaLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddRelativeLocation(DeltaLocation, bSweep, bTeleport) end

---Adds a delta to the transform of the component in its local reference frame. Scale is unchanged.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddLocalTransform(bSweep, bTeleport) end

---Adds a delta to the rotation of the component in its local reference frame
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---@param DeltaRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddLocalRotation(DeltaRotation, bSweep, bTeleport) end

---Adds a delta to the location of the component in its local reference frame
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire sweep volume.
---@param DeltaLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function SceneComponent.K2_AddLocalOffset(DeltaLocation, bSweep, bTeleport) end

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
