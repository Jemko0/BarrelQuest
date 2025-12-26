---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class PrimitiveComponent : SceneComponent
---PrimitiveComponents are SceneComponents that contain or generate some sort of geometry, generally to be rendered or used as collision data.
---There are several subclasses for the various types of geometry, but the most common by far are the ShapeComponents (Capsule, Sphere, Box), StaticMeshComponent, and SkeletalMeshComponent.
---ShapeComponents generate geometry that is used for collision detection but are not rendered, while StaticMeshComponents and SkeletalMeshComponents contain pre-built geometry that is rendered, but can also be used for collision detection.
---
--- Properties
---
---The minimum distance at which the primitive should be rendered,
---measured in world space units from the center of the primitive's bounding sphere to the camera position.
---@field MinDrawDistance number
---Max draw distance exposed to LDs. The real max draw distance is the min (disregarding 0) of this and volumes affecting this object.
---@field LDMaxDrawDistance number
---The distance to cull this primitive at.
---A CachedMaxDrawDistance of 0 indicates that the primitive should not be culled by distance.
---@field CachedMaxDrawDistance number
---The scene depth priority group to draw the primitive in.
---@field DepthPriorityGroup integer
---The scene depth priority group to draw the primitive in, if it's being viewed by its owner.
---@field ViewOwnerDepthPriorityGroup integer
---Quality of indirect lighting for Movable primitives.  This has a large effect on Indirect Lighting Cache update time.
---@field IndirectLightingCacheQuality integer
---@field LightmapType ELightmapType
---Determines how the geometry of a component will be incorporated in proxy (simplified) HLODs.
---@field HLODBatchingPolicy EHLODBatchingPolicy
---Control shadow invalidation behavior, in particular with respect to Virtual Shadow Maps and material effects like World Position Offset.
---@field ShadowCacheInvalidationBehavior EShadowCacheInvalidationBehavior
---Whether to include this component in HLODs or not.
---@field bEnableAutoLODGeneration boolean
---Indicates that the texture streaming built data is local to the Actor (see UActorTextureStreamingBuildDataComponent).
---@field bIsActorTextureStreamingBuiltData boolean
---Indicates to the texture streaming wether it can use the pre-built texture streaming data (even if empty).
---@field bIsValidTextureStreamingBuiltData boolean
---When enabled this object will not be culled by distance. This is ignored if a child of a HLOD.
---@field bNeverDistanceCull boolean
---Indicates if we'd like to create physics state all the time (for collision and simulation).
---If you set this to false, it still will create physics state if collision or simulation activated.
---This can help performance if you'd like to avoid overhead of creating physics state when triggers
---@field bAlwaysCreatePhysicsState boolean
---If true, this component will generate individual overlaps for each overlapping physics body if it is a multi-body component. When false, this component will
---generate only one overlap, regardless of how many physics bodies it has and how many of them are overlapping another component/body. This flag has no
---influence on single body components.
---@field bMultiBodyOverlap boolean
---If true, component sweeps with this component should trace against complex collision during movement (for example, each triangle of a mesh).
---If false, collision will be resolved against simple collision bounds instead.
---\@see MoveComponent()
---@field bTraceComplexOnMove boolean
---If true, component sweeps will return the material in their hit result.
---\@see MoveComponent(), FHitResult
---@field bReturnMaterialOnMove boolean
---True if the primitive should be rendered using ViewOwnerDepthPriorityGroup if viewed by its owner.
---@field bUseViewOwnerDepthPriorityGroup boolean
---Whether to accept cull distance volumes to modify cached cull distance.
---@field bAllowCullDistanceVolume boolean
---If true, this component will be visible in reflection captures.
---@field bVisibleInReflectionCaptures boolean
---If true, this component will be visible in real-time sky light reflection captures.
---@field bVisibleInRealTimeSkyCaptures boolean
---If true, this component will be visible in ray tracing effects. Turning this off will remove it from ray traced reflections, shadows, etc.
---@field bVisibleInRayTracing boolean
---If true, this component will be rendered in the main pass (z prepass, basepass, transparency)
---@field bRenderInMainPass boolean
---If true, this component will be rendered in the depth pass even if it's not rendered in the main pass
---@field bRenderInDepthPass boolean
---Whether the primitive receives decals.
---@field bReceivesDecals boolean
---If this is True, this primitive will render black with an alpha of 0, but all secondary effects (shadows, reflections, indirect lighting) remain. This feature requires activating the project setting(s) "Alpha Output", and "Support Primitive Alpha Holdout" if using the deferred renderer.
---@field bHoldout boolean
---If this is True, this component won't be visible when the view actor is the component's owner, directly or indirectly. Will be internally set to true when FirstPersonPrimitiveType is set to WorldSpaceRepresentation.
---@field bOwnerNoSee boolean
---If this is True, this component will only be visible when the view actor is the component's owner, directly or indirectly.
---@field bOnlyOwnerSee boolean
---Treat this primitive as part of the background for occlusion purposes. This can be used as an optimization to reduce the cost of rendering skyboxes, large ground planes that are part of the vista, etc.
---@field bTreatAsBackgroundForOcclusion boolean
---Whether to render the primitive in the depth only pass.
---This should generally be true for all objects, and let the renderer make decisions about whether to render objects in the depth only pass.
---@todo - if any rendering features rely on a complete depth only pass, this variable needs to go away.
---@field bUseAsOccluder boolean
---If this is True, this component can be selected in the editor.
---@field bSelectable boolean
---When true, this component requests editor effects like outlines and overlays.
---@field bWantsEditorEffects boolean
---If true, this component will be considered for placement when dragging and placing items in the editor even if it is not visible, such as in the case of hidden collision meshes
---@field bConsiderForActorPlacementWhenHidden boolean
---If true, forces mips for textures used by this component to be resident when this component's level is loaded.
---@field bForceMipStreaming boolean
---If true a hit-proxy will be generated for each instance of instanced static meshes.
---This allows for other systems, like selection in viewports, to function at the individual instance.
---@field bHasPerInstanceHitProxies boolean
---Controls whether the primitive component should cast a shadow or not.
---@field CastShadow boolean
---Whether the primitive will be used as an emissive light source.
---@field bEmissiveLightSource boolean
---Controls whether the primitive should influence indirect lighting.
---@field bAffectDynamicIndirectLighting boolean
---Controls whether the primitive should affect indirect lighting when hidden. This flag is only used if bAffectDynamicIndirectLighting is true.
---@field bAffectIndirectLightingWhileHidden boolean
---Controls whether the primitive should affect dynamic distance field lighting methods.  This flag is only used if CastShadow is true.
---@field bAffectDistanceFieldLighting boolean
---Controls whether the primitive should cast shadows in the case of non precomputed shadowing. This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to FirstPerson.
---@field bCastDynamicShadow boolean
---Whether the object should cast a static shadow from shadow casting lights. This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to FirstPerson.
---@field bCastStaticShadow boolean
---Whether the object should cast a volumetric translucent shadow.
---Volumetric translucent shadows are useful for primitives with smoothly changing opacity like particles representing a volume,
---but have artifacts when used on highly opaque surfaces. This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to FirstPerson.
---@field bCastVolumetricTranslucentShadow boolean
---Whether the object should cast contact shadows.
---This flag is only used if CastShadow is true.
---@field bCastContactShadow boolean
---When enabled, the component will only cast a shadow on itself and not other components in the world.
---This is especially useful for first person weapons, and forces bCastInsetShadow to be enabled.
---@field bSelfShadowOnly boolean
---When enabled, the component will be rendering into the far shadow cascades (only for directional lights). This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to FirstPerson.
---@field bCastFarShadow boolean
---Whether this component should create a per-object shadow that gives higher effective shadow resolution.
---Useful for cinematic character shadowing. Assumed to be enabled if bSelfShadowOnly is enabled.
---@field bCastInsetShadow boolean
---Whether this component should cast shadows from lights that have bCastShadowsFromCinematicObjectsOnly enabled.
---This is useful for characters in a cinematic with special cinematic lights, where the cost of shadowmap rendering of the environment is undesired.
---@field bCastCinematicShadow boolean
---If true, the primitive will cast shadows even if bHidden is true.
---Controls whether the primitive should cast shadows when hidden.
---This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to WorldSpaceRepresentation.
---@field bCastHiddenShadow boolean
---Whether this primitive should cast dynamic shadows as if it were a two sided material.
---@field bCastShadowAsTwoSided boolean
---
---@deprecated Replaced by LightmapType
---@field bLightAsIfStatic boolean
---Whether to light this component and any attachments as a group.  This only has effect on the root component of an attachment tree.
---When enabled, attached component shadowing settings like bCastInsetShadow, bCastVolumetricTranslucentShadow, etc, will be ignored.
---This is useful for improving performance when multiple movable components are attached together.
---@field bLightAttachmentsAsGroup boolean
---If set, then it overrides any bLightAttachmentsAsGroup set in a parent.
---@field bExcludeFromLightAttachmentGroup boolean
---Mobile only:
---If disabled this component will not receive CSM shadows. (Components that do not receive CSM may have reduced shading cost)
---@field bReceiveMobileCSMShadows boolean
---Whether the whole component should be shadowed as one from stationary lights, which makes shadow receiving much cheaper.
---When enabled shadowing data comes from the volume lighting samples precomputed by Lightmass, which are very sparse.
---This is currently only used on stationary directional lights.
---@field bSingleSampleShadowFromStationaryLights boolean
---Will ignore radial impulses applied to this component.
---@field bIgnoreRadialImpulse boolean
---Will ignore radial forces applied to this component.
---@field bIgnoreRadialForce boolean
---True for damage to this component to apply physics impulse, false to opt out of these impulses.
---@field bApplyImpulseOnDamage boolean
---True if physics should be replicated to autonomous proxies. This should be true for
---              server-authoritative simulations, and false for client authoritative simulations.
---@field bReplicatePhysicsToAutonomousProxy boolean
---If set, navmesh will not be generated under the surface of the geometry
---@field bFillCollisionUnderneathForNavmesh boolean
---If set, the geometry gathered for navigation data generation will be converted into a filled vertical convex volume.
---It means that all collision geometries of the asset are merged vertically resulting in a grid of vertical columns that encompass the asset.
---This can be useful to represent the interior of the surface and prevent navmesh inside.
---@field bRasterizeAsFilledConvexVolume boolean
---If this is True, this component must always be loaded on clients, even if Hidden and CollisionEnabled is NoCollision.
---@field AlwaysLoadOnClient boolean
---If this is True, this component must always be loaded on servers, even if Hidden and CollisionEnabled is NoCollision
---@field AlwaysLoadOnServer boolean
---Composite the drawing of this component onto the scene after post processing (only applies to editor drawing)
---@field bUseEditorCompositing boolean
---Set to true while the editor is moving the component, which notifies the Renderer to track velocities even if the component is Static.
---@field bIsBeingMovedByEditor boolean
---If true, this component will be rendered in the CustomDepth pass (usually used for outlines)
---@field bRenderCustomDepth boolean
---When true, will only be visible in Scene Capture
---@field bVisibleInSceneCaptureOnly boolean
---When true, will not be captured by Scene Capture
---@field bHiddenInSceneCapture boolean
---If true, this component will be available to ray trace as a far field primitive even if hidden.
---@field bRayTracingFarField boolean
---If this is set to FirstPerson, the camera FirstPersonFieldOfView and FirstPersonScale parameters will be used on this component. These parameters can be used to render the component with a different field of view and a smaller depth range such that clipping with the scene can be avoided. This is useful for rendering first person view geometry.
---@field FirstPersonPrimitiveType EFirstPersonPrimitiveType
---@field bHasNoStreamableTextures boolean
---When false, the underlying physics body will contain all sim data (mass, inertia tensor, etc) even if mobility is not set to Moveable
---@field bStaticWhenNotMoveable boolean
---If true then DoCustomNavigableGeometryExport will be called to collect navigable geometry of this component.
---@field bHasCustomNavigableGeometry integer
---@field HitProxyPriority integer
---@field ExcludeForSpecificHLODLevels integer[]
---Determine whether a Character can step up onto this component.
---This controls whether they can try to step up on it when they bump in to it, not whether they can walk on it after landing on it.
---\@see FWalkableSlopeOverride
---@field CanCharacterStepUpOn integer
---Channels that this component should be in.  Lights with matching channels will affect the component.
---These channels only apply to opaque materials, direct lighting, and dynamic lighting and shadowing.
---Lighting channels are only supported on translucent materials using forward shading (i.e. when not using the translucency lighting volume).
---@field LightingChannels LightingChannels
---Defines how quickly it should be culled. For example buildings should have a low priority, but small dressing should have a high priority.
---@field RayTracingGroupCullingPriority ERayTracingGroupCullingPriority
---Mask used for stencil buffer writes.
---@field CustomDepthStencilWriteMask ERendererStencilMask
---Defines run-time groups of components. For example allows to assemble multiple parts of a building at runtime.
----1 means that component doesn't belong to any group.
---@field RayTracingGroupId integer
---Used for precomputed visibility
---@field VisibilityId integer
---Optionally write this 0-255 value to the stencil buffer in CustomDepth pass (Requires project setting or r.CustomDepth == 3)
---@field CustomDepthStencilValue integer
---Translucent objects with a lower sort priority draw behind objects with a higher priority.
---Translucent objects with the same priority are rendered from back-to-front based on their bounds origin.
---This setting is also used to sort objects being drawn into a runtime virtual texture.
---Ignored if the object is not translucent.  The default priority is zero.
---Warning: This should never be set to a non-default value unless you know what you are doing, as it will prevent the renderer from sorting correctly.
---It is especially problematic on dynamic gameplay effects.
---@field TranslucencySortPriority integer
---Modified sort distance offset for translucent objects in world units.
---A positive number will move the sort distance further and a negative number will move the distance closer.
---Ignored if the object is not translucent.
---Warning: Adjusting this value will prevent the renderer from correctly sorting based on distance.  Only modify this value if you are certain it will not cause visual artifacts.
---@field TranslucencySortDistanceOffset number
---Array of runtime virtual textures into which we draw the mesh for this actor.
---The material also needs to be set up to output to a virtual texture.
---@field RuntimeVirtualTextures RuntimeVirtualTexture[]
---Bias to the LOD selected for rendering to runtime virtual textures.
---@field VirtualTextureLodBias any
---Number of lower mips in the runtime virtual texture to skip for rendering this primitive.
---Larger values reduce the effective draw distance in the runtime virtual texture.
---This culling method doesn't take into account primitive size or virtual texture size.
---@field VirtualTextureCullMips any
---Set the minimum pixel coverage before culling from the runtime virtual texture.
---Larger values reduce the effective draw distance in the runtime virtual texture.
---@field VirtualTextureMinCoverage any
---Controls if this component draws in the main pass as well as in the virtual texture.
---@field VirtualTextureRenderPassType ERuntimeVirtualTextureMainPassType
---Scales the bounds of the object.
---This is useful when using World Position Offset to animate the vertices of the object outside of its bounds.
---Warning: Increasing the bounds of an object will reduce performance and shadow quality!
---Currently only used by StaticMeshComponent and SkeletalMeshComponent.
---@field BoundsScale number
---Set of actors to ignore during component sweeps in MoveComponent().
---All components owned by these actors will be ignored when this component moves or updates overlaps.
---Components on the other Actor may also need to be told to do the same when they move.
---Does not affect movement of this component when simulating physics.
---\@see IgnoreActorWhenMoving()
---@field MoveIgnoreActors Actor[]
---Set of components to ignore during component sweeps in MoveComponent().
---These components will be ignored when this component moves or updates overlaps.
---The other components may also need to be told to do the same when they move.
---Does not affect movement of this component when simulating physics.
---\@see IgnoreComponentWhenMoving()
---@field MoveIgnoreComponents PrimitiveComponent[]
---Physics scene information for this component, holds a single rigid body with multiple shapes.
---@field BodyInstance BodyInstance
---Event called when a component hits (or is hit by) something solid. This could happen due to things like Character movement, using Set Location with 'sweep' enabled, or physics simulation.
---For events when objects overlap (e.g. walking into a trigger) see the 'Overlap' event.
---@note For collisions during physics simulation to generate hit events, 'Simulation Generates Hit Events' must be enabled for this component.
---@note When receiving a hit from another object's movement, the directions of 'Hit.Normal' and 'Hit.ImpactNormal'
---will be adjusted to indicate force from the other object against this object.
---@note NormalImpulse will be filled in for physics-simulating bodies, but will be zero for swept-component blocking collisions.
---@field OnComponentHit OnComponentHitDelegate
---Event called when something starts to overlaps this component, for example a player walking into a trigger.
---For events when objects have a blocking collision, for example a player hitting a wall, see 'Hit' events.
---@note Both this component and the other one must have GetGenerateOverlapEvents() set to true to generate overlap events.
---@note When receiving an overlap from another object's movement, the directions of 'Hit.Normal' and 'Hit.ImpactNormal'
---will be adjusted to indicate force from the other object against this object.
---@field OnComponentBeginOverlap OnComponentBeginOverlapDelegate
---Event called when something stops overlapping this component
---@note Both this component and the other one must have GetGenerateOverlapEvents() set to true to generate overlap events.
---@field OnComponentEndOverlap OnComponentEndOverlapDelegate
---Event called when the underlying physics objects is woken up
---@field OnComponentWake OnComponentWakeDelegate
---Event called when the underlying physics objects is put to sleep
---@field OnComponentSleep OnComponentSleepDelegate
---Event called when physics state is created or destroyed for this component
---@field OnComponentPhysicsStateChanged OnComponentPhysicsStateChangedDelegate
---Event called when the mouse cursor is moved over this component and mouse over events are enabled in the player controller
---@field OnBeginCursorOver OnBeginCursorOverDelegate
---Event called when the mouse cursor is moved off this component and mouse over events are enabled in the player controller
---@field OnEndCursorOver OnEndCursorOverDelegate
---Event called when the left mouse button is clicked while the mouse is over this component and click events are enabled in the player controller
---@field OnClicked OnClickedDelegate
---Event called when the left mouse button is released while the mouse is over this component click events are enabled in the player controller
---@field OnReleased OnReleasedDelegate
---Event called when a touch input is received over this component when touch events are enabled in the player controller
---@field OnInputTouchBegin OnInputTouchBeginDelegate
---Event called when a touch input is released over this component when touch events are enabled in the player controller
---@field OnInputTouchEnd OnInputTouchEndDelegate
---Event called when a finger is moved over this component when touch over events are enabled in the player controller
---@field OnInputTouchEnter OnInputTouchEnterDelegate
---Event called when a finger is moved off this component when touch over events are enabled in the player controller
---@field OnInputTouchLeave OnInputTouchLeaveDelegate
local PrimitiveComponent = {}

--- Methods
---Returns true if this component has been rendered "recently", with a tolerance in seconds to define what "recent" means.
---e.g.: If a tolerance of 0.1 is used, this function will return true only if the actor was rendered in the last 0.1 seconds of game time.
---@param Tolerance number
---@return boolean
function PrimitiveComponent.WasRecentlyRendered(Tolerance) end

---'Wake' physics simulation for a single body.
---@param BoneName string
---@return nil
function PrimitiveComponent.WakeRigidBody(BoneName) end

---Ensure simulation is running for all bodies in this component.
---@return nil
function PrimitiveComponent.WakeAllRigidBodies() end

---Unregister this components physics object from being a focal particle in Physics Replication LOD
---@return nil
function PrimitiveComponent.UnregisterAsFocalPointInPhysicsReplicationLOD() end

---Sets a new slope override for this component instance.
---@return nil
function PrimitiveComponent.SetWalkableSlopeOverride() end

---Sets bVisibleInSceneCaptureOnly property and marks the render state dirty.
---@param bValue boolean
---@return nil
function PrimitiveComponent.SetVisibleInSceneCaptureOnly(bValue) end

---Changes the value of bIsVisibleInRayTracing.
---@param bNewVisibleInRayTracing boolean
---@return nil
function PrimitiveComponent.SetVisibleInRayTracing(bNewVisibleInRayTracing) end

---Set a vector parameter for default custom primitive data. This will be serialized and is useful in construction scripts.
---@param ParameterName string
---@param Value Vector4
---@return nil
function PrimitiveComponent.SetVectorParameterForDefaultCustomPrimitiveData(ParameterName, Value) end

---Set a vector parameter for custom primitive data. This sets the run-time data only, so it doesn't serialize.
---@param ParameterName string
---@param Value Vector4
---@return nil
function PrimitiveComponent.SetVectorParameterForCustomPrimitiveData(ParameterName, Value) end

---[EXPERIMENTAL] Set whether this component should use Motion-Aware Collision Detection
---@param InUseMACD boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetUseMACD(InUseMACD, BoneName) end

---Set whether this component should use Continuous Collision Detection
---@param InUseCCD boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetUseCCD(InUseCCD, BoneName) end

---Enables/disables whether this component should be updated by simulation when it is kinematic. This is needed if (for example) its velocity needs to be accessed.
---@param bUpdateKinematicFromSimulation boolean
---@return nil
function PrimitiveComponent.SetUpdateKinematicFromSimulation(bUpdateKinematicFromSimulation) end

---Changes the value of TranslucentSortPriority.
---@param NewTranslucentSortPriority integer
---@return nil
function PrimitiveComponent.SetTranslucentSortPriority(NewTranslucentSortPriority) end

---Changes the value of TranslucencySortDistanceOffset.
---@param NewTranslucencySortDistanceOffset number
---@return nil
function PrimitiveComponent.SetTranslucencySortDistanceOffset(NewTranslucencySortDistanceOffset) end

---Set Static when Not Moveable
---@param bInStaticWhenNotMoveable boolean
---@return nil
function PrimitiveComponent.SetStaticWhenNotMoveable(bInStaticWhenNotMoveable) end

---Changes the value of bSingleSampleShadowFromStationaryLights.
---@param bNewSingleSampleShadowFromStationaryLights boolean
---@return nil
function PrimitiveComponent.SetSingleSampleShadowFromStationaryLights(bNewSingleSampleShadowFromStationaryLights) end

---When this component is a simple/single body, this will enable or disable simulation on that body. In addition,
---if this component is currently attached to something, beginning simulation will detach it. Note that stopping
---simulation will not reattach the component - that would need to be done explicitly.
---For more complex components (e.g. skeletal meshes), simulation will apply to the bodies contained by the
---component (e.g. using a physics asset). Since these bodies will be free to move independently of the component,
---the component will not be automatically detached. If detachment is required, then that can be done by
---calling DetachFromComponent.
---@param bSimulate boolean
---@return nil
function PrimitiveComponent.SetSimulatePhysics(bSimulate) end

---Set a scalar parameter for default custom primitive data. This will be serialized and is useful in construction scripts.
---@param ParameterName string
---@param Value number
---@return nil
function PrimitiveComponent.SetScalarParameterForDefaultCustomPrimitiveData(ParameterName, Value) end

---Set a scalar parameter for custom primitive data. This sets the run-time data only, so it doesn't serialize.
---@param ParameterName string
---@param Value number
---@return nil
function PrimitiveComponent.SetScalarParameterForCustomPrimitiveData(ParameterName, Value) end

---Sets bRenderInMainPass property and marks the render state dirty.
---@param bValue boolean
---@return nil
function PrimitiveComponent.SetRenderInMainPass(bValue) end

---Sets bRenderInDepthPass property and marks the render state dirty.
---@param bValue boolean
---@return nil
function PrimitiveComponent.SetRenderInDepthPass(bValue) end

---Sets the bRenderCustomDepth property and marks the render state dirty.
---@param bValue boolean
---@return nil
function PrimitiveComponent.SetRenderCustomDepth(bValue) end

---Changes the value of bReceivesDecals.
---@param bNewReceivesDecals boolean
---@return nil
function PrimitiveComponent.SetReceivesDecals(bNewReceivesDecals) end

---Changes the current PhysMaterialOverride for this component.
---Note that if physics is already running on this component, this will _not_ alter its mass/inertia etc,
---it will only change its surface properties like friction.
---@param NewPhysMaterial PhysicalMaterial
---@return nil
function PrimitiveComponent.SetPhysMaterialOverride(NewPhysMaterial) end

---Set the maximum angular velocity of a single body.
---@param NewMaxAngVel number
---@param bAddToCurrent boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetPhysicsMaxAngularVelocityInRadians(NewMaxAngVel, bAddToCurrent, BoneName) end

---Set the maximum angular velocity of a single body.
---@param NewMaxAngVel number
---@param bAddToCurrent boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetPhysicsMaxAngularVelocityInDegrees(NewMaxAngVel, bAddToCurrent, BoneName) end

---Set the linear velocity of a single body.
---This should be used cautiously - it may be better to use AddForce or AddImpulse.
---@param NewVel Vector
---@param bAddToCurrent boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetPhysicsLinearVelocity(NewVel, bAddToCurrent, BoneName) end

---Set the angular velocity of a single body.
---This should be used cautiously - it may be better to use AddTorque or AddImpulse.
---@param NewAngVel Vector
---@param bAddToCurrent boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetPhysicsAngularVelocityInRadians(NewAngVel, bAddToCurrent, BoneName) end

---Set the angular velocity of a single body.
---This should be used cautiously - it may be better to use AddTorque or AddImpulse.
---@param NewAngVel Vector
---@param bAddToCurrent boolean
---@param BoneName string
---@return nil
function PrimitiveComponent.SetPhysicsAngularVelocityInDegrees(NewAngVel, bAddToCurrent, BoneName) end

---Changes the value of bOwnerNoSee.
---@param bNewOwnerNoSee boolean
---@return nil
function PrimitiveComponent.SetOwnerNoSee(bNewOwnerNoSee) end

---Changes the value of bOnlyOwnerSee.
---@param bNewOnlyOwnerSee boolean
---@return nil
function PrimitiveComponent.SetOnlyOwnerSee(bNewOnlyOwnerSee) end

---Changes the value of bNotifyRigidBodyCollision
---@param bNewNotifyRigidBodyCollision boolean
---@return nil
function PrimitiveComponent.SetNotifyRigidBodyCollision(bNewNotifyRigidBodyCollision) end

---The maximum velocity used to depenetrate this object from others when spawned or teleported with initial overlaps (does not affect overlaps as a result of normal movement).
---A value of zero will allow objects that are spawned overlapping to go to sleep without moving rather than pop out of each other. E.g., use zero if you spawn dynamic rocks
---partially embedded in the ground and want them to be interactive but not pop out of the ground when touched.
---A negative value means that the config setting CollisionInitialOverlapDepenetrationVelocity will be used.
---@param BoneName string
---@param InMaxDepenetrationVelocity number
---@return nil
function PrimitiveComponent.SetMaxDepenetrationVelocity(BoneName, InMaxDepenetrationVelocity) end

---Changes the material applied to an element of the mesh.
---@param MaterialSlotName string
---@param Material MaterialInterface
---@return nil
function PrimitiveComponent.SetMaterialByName(MaterialSlotName, Material) end

---Changes the material applied to an element of the mesh.
---@param ElementIndex integer
---@param Material MaterialInterface
---@return nil
function PrimitiveComponent.SetMaterial(ElementIndex, Material) end

---Change the mass scale used to calculate the mass of a single physics body
---@param BoneName string
---@param InMassScale number
---@return nil
function PrimitiveComponent.SetMassScale(BoneName, InMassScale) end

---Override the mass (in Kg) of a single physics body.
---Note that in the case where multiple bodies are attached together, the override mass will be set for the entire group.
---Set the Override Mass to false if you want to reset the body's mass to the auto-calculated physx mass.
---@param BoneName string
---@param MassInKg number
---@param bOverrideMass boolean
---@return nil
function PrimitiveComponent.SetMassOverrideInKg(BoneName, MassInKg, bOverrideMass) end

---Sets the linear damping of this component.
---@param InDamping number
---@return nil
function PrimitiveComponent.SetLinearDamping(InDamping) end

---Set Lighting Channels
---@param bChannel0 boolean
---@param bChannel1 boolean
---@param bChannel2 boolean
---@return nil
function PrimitiveComponent.SetLightingChannels(bChannel0, bChannel1, bChannel2) end

---Changes the value of LightAttachmentsAsGroup.
---@param bInLightAttachmentsAsGroup boolean
---@return nil
function PrimitiveComponent.SetLightAttachmentsAsGroup(bInLightAttachmentsAsGroup) end

---Set if we should ignore bounds when focusing the editor camera.
---@param bIgnore boolean
---@return nil
function PrimitiveComponent.SetIgnoreBoundsForEditorFocus(bIgnore) end

---Changes the value of bHoldout
---@param bNewHoldout boolean
---@return nil
function PrimitiveComponent.SetHoldout(bNewHoldout) end

---Sets bHideInSceneCapture property and marks the render state dirty.
---@param bValue boolean
---@return nil
function PrimitiveComponent.SetHiddenInSceneCapture(bValue) end

---Enabled/disables whether this body is affected by gyroscopic torque, mainly useful for long/thin objects that spin
---@param bInGyroscopicTorqueEnabled boolean
---@return nil
function PrimitiveComponent.SetGyroscopicTorqueEnabled(bInGyroscopicTorqueEnabled) end

---Modifies value returned by GetGenerateOverlapEvents()
---@param bInGenerateOverlapEvents boolean
---@return nil
function PrimitiveComponent.SetGenerateOverlapEvents(bInGenerateOverlapEvents) end

---Sets FirstPersonPrimitiveType property and marks the render state dirty.
---@param Value EFirstPersonPrimitiveType
---@return nil
function PrimitiveComponent.SetFirstPersonPrimitiveType(Value) end

---Changes the value of ExcludeFromLightAttachmentGroup.
---@param bInExcludeFromLightAttachmentGroup boolean
---@return nil
function PrimitiveComponent.SetExcludeFromLightAttachmentGroup(bInExcludeFromLightAttachmentGroup) end

---Set Exclude for Specific HLODLevels
---@return nil
function PrimitiveComponent.SetExcludeForSpecificHLODLevels() end

---Exclude this primitive from the specified HLOD level
---@param HLODLevel EHLODLevelExclusion
---@param bExcluded boolean
---@return nil
function PrimitiveComponent.SetExcludedFromHLODLevel(HLODLevel, bExcluded) end

---Enables/disables whether this component is affected by gravity. This applies only to components with bSimulatePhysics set to true.
---@param bGravityEnabled boolean
---@return nil
function PrimitiveComponent.SetEnableGravity(bGravityEnabled) end

---Changes the value of EmissiveLightSource.
---@param NewEmissiveLightSource boolean
---@return nil
function PrimitiveComponent.SetEmissiveLightSource(NewEmissiveLightSource) end

---Set default custom primitive data, four floats at once, from index DataIndex to index DataIndex + 3, and marks the render state dirty
---@param DataIndex integer
---@param Value Vector4
---@return nil
function PrimitiveComponent.SetDefaultCustomPrimitiveDataVector4(DataIndex, Value) end

---Set default custom primitive data, three floats at once, from index DataIndex to index DataIndex + 2, and marks the render state dirty
---@param DataIndex integer
---@param Value Vector
---@return nil
function PrimitiveComponent.SetDefaultCustomPrimitiveDataVector3(DataIndex, Value) end

---Set default custom primitive data, two floats at once, from index DataIndex to index DataIndex + 1, and marks the render state dirty
---@param DataIndex integer
---@param Value Vector2D
---@return nil
function PrimitiveComponent.SetDefaultCustomPrimitiveDataVector2(DataIndex, Value) end

---Set default custom primitive data, an array floats at once, from index DataIndex to index DataIndex + Values.Num(), and marks the render state dirty
---@param DataIndex integer
---@return nil
function PrimitiveComponent.SetDefaultCustomPrimitiveDataFloatArray(DataIndex) end

---Set default custom primitive data at index DataIndex, and marks the render state dirty
---@param DataIndex integer
---@param Value number
---@return nil
function PrimitiveComponent.SetDefaultCustomPrimitiveDataFloat(DataIndex, Value) end

---Set custom primitive data, four floats at once, from index DataIndex to index DataIndex + 3. This sets the run-time data only, so it doesn't serialize.
---@param DataIndex integer
---@param Value Vector4
---@return nil
function PrimitiveComponent.SetCustomPrimitiveDataVector4(DataIndex, Value) end

---Set custom primitive data, three floats at once, from index DataIndex to index DataIndex + 2. This sets the run-time data only, so it doesn't serialize.
---@param DataIndex integer
---@param Value Vector
---@return nil
function PrimitiveComponent.SetCustomPrimitiveDataVector3(DataIndex, Value) end

---Set custom primitive data, two floats at once, from index DataIndex to index DataIndex + 1. This sets the run-time data only, so it doesn't serialize.
---@param DataIndex integer
---@param Value Vector2D
---@return nil
function PrimitiveComponent.SetCustomPrimitiveDataVector2(DataIndex, Value) end

---Set custom primitive data, an array of floats at once, from index DataIndex to index DataIndex + Values.Num(). This sets the run-time data only, so it doesn't serialize.
---@param DataIndex integer
---@return nil
function PrimitiveComponent.SetCustomPrimitiveDataFloatArray(DataIndex) end

---Set custom primitive data at index DataIndex. This sets the run-time data only, so it doesn't serialize.
---@param DataIndex integer
---@param Value number
---@return nil
function PrimitiveComponent.SetCustomPrimitiveDataFloat(DataIndex, Value) end

---Sets the CustomDepth stencil write mask and marks the render state dirty.
---@param WriteMaskBit ERendererStencilMask
---@return nil
function PrimitiveComponent.SetCustomDepthStencilWriteMask(WriteMaskBit) end

---Sets the CustomDepth stencil value (0 - 255) and marks the render state dirty.
---@param Value integer
---@return nil
function PrimitiveComponent.SetCustomDepthStencilValue(Value) end

---Changes the value of CullDistance.
---@param NewCullDistance number
---@return nil
function PrimitiveComponent.SetCullDistance(NewCullDistance) end

---Sets the constraint mode of the component.
---@param ConstraintMode integer
---@return nil
function PrimitiveComponent.SetConstraintMode(ConstraintMode) end

---Changes a member of the ResponseToChannels container for this PrimitiveComponent.
---@param Channel integer
---@param NewResponse integer
---@return nil
function PrimitiveComponent.SetCollisionResponseToChannel(Channel, NewResponse) end

---Changes all ResponseToChannels container for this PrimitiveComponent. to be NewResponse
---@param NewResponse integer
---@return nil
function PrimitiveComponent.SetCollisionResponseToAllChannels(NewResponse) end

---Set Collision Profile Name
---This function is called by constructors when they set ProfileName
---This will change current CollisionProfileName to be this, and overwrite Collision Setting
---@param InCollisionProfileName string
---@param bUpdateOverlaps boolean
---@return nil
function PrimitiveComponent.SetCollisionProfileName(InCollisionProfileName, bUpdateOverlaps) end

---Changes the collision channel that this object uses when it moves
---@param Channel integer
---@return nil
function PrimitiveComponent.SetCollisionObjectType(Channel) end

---Controls what kind of collision is enabled for this body
---@param NewType integer
---@return nil
function PrimitiveComponent.SetCollisionEnabled(NewType) end

---Set the center of mass of a single body. This will offset the physx-calculated center of mass.
---Note that in the case where multiple bodies are attached together, the center of mass will be set for the entire group.
---@param CenterOfMassOffset Vector
---@param BoneName string
---@return nil
function PrimitiveComponent.SetCenterOfMass(CenterOfMassOffset, BoneName) end

---Changes the value of CastShadow.
---@param NewCastShadow boolean
---@return nil
function PrimitiveComponent.SetCastShadow(NewCastShadow) end

---Changes the value of CastInsetShadow.
---@param bInCastInsetShadow boolean
---@return nil
function PrimitiveComponent.SetCastInsetShadow(bInCastInsetShadow) end

---Changes the value of CastHiddenShadow.
---@param NewCastHiddenShadow boolean
---@return nil
function PrimitiveComponent.SetCastHiddenShadow(NewCastHiddenShadow) end

---Changes the value of bCastContactShadow.
---@param bInCastContactShadow boolean
---@return nil
function PrimitiveComponent.SetCastContactShadow(bInCastContactShadow) end

---Scale the bounds of this object, used for frustum culling. Useful for features like WorldPositionOffset.
---@param NewBoundsScale number
---@return nil
function PrimitiveComponent.SetBoundsScale(NewBoundsScale) end

---Sets the angular damping of this component.
---@param InDamping number
---@return nil
function PrimitiveComponent.SetAngularDamping(InDamping) end

---[EXPERIMENTAL] Set whether all bodies in this component should use Motion-Aware Collision Detection
---@param InUseMACD boolean
---@return nil
function PrimitiveComponent.SetAllUseMACD(InUseMACD) end

---Set whether all bodies in this component should use Continuous Collision Detection
---@param InUseCCD boolean
---@return nil
function PrimitiveComponent.SetAllUseCCD(InUseCCD) end

---Set the linear velocity of all bodies in this component.
---@param NewVel Vector
---@param bAddToCurrent boolean
---@return nil
function PrimitiveComponent.SetAllPhysicsLinearVelocity(NewVel, bAddToCurrent) end

---Set the angular velocity of all bodies in this component.
---@param bAddToCurrent boolean
---@return nil
function PrimitiveComponent.SetAllPhysicsAngularVelocityInRadians(bAddToCurrent) end

---Set the angular velocity of all bodies in this component.
---@param bAddToCurrent boolean
---@return nil
function PrimitiveComponent.SetAllPhysicsAngularVelocityInDegrees(bAddToCurrent) end

---Change the mass scale used fo all bodies in this component
---@param InMassScale number
---@return nil
function PrimitiveComponent.SetAllMassScale(InMassScale) end

---Changes the value of bAffectIndirectLightingWhileHidden
---@param bNewAffectIndirectLightingWhileHidden boolean
---@return nil
function PrimitiveComponent.SetAffectIndirectLightingWhileHidden(bNewAffectIndirectLightingWhileHidden) end

---Changes the value of bAffectDynamicIndirectLighting
---@param bNewAffectDynamicIndirectLighting boolean
---@return nil
function PrimitiveComponent.SetAffectDynamicIndirectLighting(bNewAffectDynamicIndirectLighting) end

---Changes the value of Affect Distance Field Lighting
---@param NewAffectDistanceFieldLighting boolean
---@return nil
function PrimitiveComponent.SetAffectDistanceFieldLighting(NewAffectDistanceFieldLighting) end

---Scales the given vector by the world space moment of inertia. Useful for computing the torque needed to rotate an object.
---@param InputVector Vector
---@param BoneName string
---@return Vector
function PrimitiveComponent.ScaleByMomentOfInertia(InputVector, BoneName) end

---Register this components physics object as a focal particle in Physics Replication LOD
---@return nil
function PrimitiveComponent.RegisterAsFocalPointInPhysicsReplicationLOD() end

---Force a single body back to sleep.
---@param BoneName string
---@return nil
function PrimitiveComponent.PutRigidBodyToSleep(BoneName) end

---Perform a sphere trace against a single component
---@param TraceStart Vector
---@param TraceEnd Vector
---@param SphereRadius number
---@param bTraceComplex boolean
---@param bShowTrace boolean
---@param bPersistentShowTrace boolean
---@return boolean
function PrimitiveComponent.K2_SphereTraceComponent(TraceStart, TraceEnd, SphereRadius, bTraceComplex, bShowTrace, bPersistentShowTrace) end

---Perform a sphere overlap against a single component
---@param InSphereCentre Vector
---@param InSphereRadius number
---@param bTraceComplex boolean
---@param bShowTrace boolean
---@param bPersistentShowTrace boolean
---@return boolean
function PrimitiveComponent.K2_SphereOverlapComponent(InSphereCentre, InSphereRadius, bTraceComplex, bShowTrace, bPersistentShowTrace) end

---Perform a line trace against a single component
---@param TraceStart Vector
---@param TraceEnd Vector
---@param bTraceComplex boolean
---@param bShowTrace boolean
---@param bPersistentShowTrace boolean
---@return boolean
function PrimitiveComponent.K2_LineTraceComponent(TraceStart, TraceEnd, bTraceComplex, bShowTrace, bPersistentShowTrace) end

---Utility to see if there is any query collision enabled on this component.
---@return boolean
function PrimitiveComponent.K2_IsQueryCollisionEnabled() end

---Utility to see if there is any physics collision enabled on this component.
---@return boolean
function PrimitiveComponent.K2_IsPhysicsCollisionEnabled() end

---Utility to see if there is any form of collision (query or physics) enabled on this component.
---@return boolean
function PrimitiveComponent.K2_IsCollisionEnabled() end

---Perform a box overlap against a single component as an AABB (No rotation)
---@param InBoxCentre Vector
---@param InBox Box
---@param bTraceComplex boolean
---@param bShowTrace boolean
---@param bPersistentShowTrace boolean
---@return boolean
function PrimitiveComponent.K2_BoxOverlapComponent(InBoxCentre, InBox, bTraceComplex, bShowTrace, bPersistentShowTrace) end

---Check whether this component is overlapping another component.
---@param OtherComp PrimitiveComponent
---@return boolean
function PrimitiveComponent.IsOverlappingComponent(OtherComp) end

---Check whether this component is overlapping any component of the given Actor.
---@param Other Actor
---@return boolean
function PrimitiveComponent.IsOverlappingActor(Other) end

---Is Material Slot Name Valid
---@param MaterialSlotName string
---@return boolean
function PrimitiveComponent.IsMaterialSlotNameValid(MaterialSlotName) end

---Returns whether this component is affected by gravity. Returns always false if the component is not simulated.
---@return boolean
function PrimitiveComponent.IsGravityEnabled() end

---Whether this primitive is excluded from the specified HLOD level
---@param HLODLevel EHLODLevelExclusion
---@return boolean
function PrimitiveComponent.IsExcludedFromHLODLevel(HLODLevel) end

---Returns if any body in this component is currently awake and simulating.
---@return boolean
function PrimitiveComponent.IsAnyRigidBodyAwake() end

---Invalidates Lumen surface cache and forces it to be refreshed. Useful to make material updates more responsive.
---@return nil
function PrimitiveComponent.InvalidateLumenSurfaceCache() end

---Tells this component whether to ignore collision with another component when this component is moved.
---The other components may also need to be told to do the same when they move.
---Does not affect movement of this component when simulating physics.
---@param Component PrimitiveComponent
---@param bShouldIgnore boolean
---@return nil
function PrimitiveComponent.IgnoreComponentWhenMoving(Component, bShouldIgnore) end

---Tells this component whether to ignore collision with all components of a specific Actor when this component is moved.
---Components on the other Actor may also need to be told to do the same when they move.
---Does not affect movement of this component when simulating physics.
---@param Actor Actor
---@param bShouldIgnore boolean
---@return nil
function PrimitiveComponent.IgnoreActorWhenMoving(Actor, bShouldIgnore) end

---Returns the slope override struct for this component.
---@return WalkableSlopeOverride
function PrimitiveComponent.GetWalkableSlopeOverride() end

---Returns whether this component should be updated by simulation when it is kinematic.
---@return boolean
function PrimitiveComponent.GetUpdateKinematicFromSimulation() end

---Get Static when Not Moveable
---@return boolean
function PrimitiveComponent.GetStaticWhenNotMoveable() end

---Get the linear velocity of a point on a single body.
---@param Point Vector
---@param BoneName string
---@return Vector
function PrimitiveComponent.GetPhysicsLinearVelocityAtPoint(Point, BoneName) end

---Get the linear velocity of a single body.
---@param BoneName string
---@return Vector
function PrimitiveComponent.GetPhysicsLinearVelocity(BoneName) end

---Get the angular velocity of a single body, in radians per second.
---@param BoneName string
---@return Vector
function PrimitiveComponent.GetPhysicsAngularVelocityInRadians(BoneName) end

---Get the angular velocity of a single body, in degrees per second.
---@param BoneName string
---@return Vector
function PrimitiveComponent.GetPhysicsAngularVelocityInDegrees(BoneName) end

---Returns unique list of components this component is overlapping.
---@return nil, PrimitiveComponent[]
function PrimitiveComponent.GetOverlappingComponents() end

---Returns a list of actors that this component is overlapping.
---@param ClassFilter Class
---@return nil, Actor[]
function PrimitiveComponent.GetOverlappingActors(ClassFilter) end

---Return number of material elements in this primitive
---@return integer
function PrimitiveComponent.GetNumMaterials() end

---The maximum velocity used to depenetrate this object from others when spawned or teleported with initial overlaps (does not affect overlaps as a result of normal movement).
---A value of zero will allow objects that are spawned overlapping to go to sleep without moving rather than pop out of each other. E.g., use zero if you spawn dynamic rocks
---partially embedded in the ground and want them to be interactive but not pop out of the ground when touched.
---A negative value means that the config setting CollisionInitialOverlapDepenetrationVelocity will be used.
---@param BoneName string
---@return number
function PrimitiveComponent.GetMaxDepenetrationVelocity(BoneName) end

---Get Material Slot Names
---@return string[]
function PrimitiveComponent.GetMaterialSlotNames() end

---Get Material Index
---@param MaterialSlotName string
---@return integer
function PrimitiveComponent.GetMaterialIndex(MaterialSlotName) end

---Try and retrieve the material applied to a particular collision face of mesh. Used with face index returned from collision trace.
---@param FaceIndex integer
---@return MaterialInterface
function PrimitiveComponent.GetMaterialFromCollisionFaceIndex(FaceIndex) end

---Returns the material used by the element in the slot with the specified name.
---@param MaterialSlotName string
---@return MaterialInterface
function PrimitiveComponent.GetMaterialByName(MaterialSlotName) end

---Returns the material used by the element at the specified index
---@param ElementIndex integer
---@return MaterialInterface
function PrimitiveComponent.GetMaterial(ElementIndex) end

---Returns the mass scale used to calculate the mass of a single physics body
---@param BoneName string
---@return number
function PrimitiveComponent.GetMassScale(BoneName) end

---Returns the mass of this component in kg.
---@return number
function PrimitiveComponent.GetMass() end

---Returns the linear damping of this component.
---@return number
function PrimitiveComponent.GetLinearDamping() end

---Returns the inertia tensor of this component in kg cm^2. The inertia tensor is in local component space.
---@param BoneName string
---@return Vector
function PrimitiveComponent.GetInertiaTensor(BoneName) end

---Whether or not the bounds of this component should be considered when focusing the editor camera to an actor with this component in it.
---Useful for debug components which need a bounds for rendering but don't contribute to the visible part of the mesh in a meaningful way
---@return boolean
function PrimitiveComponent.GetIgnoreBoundsForEditorFocus() end

---Returns whether this component is affected by gyroscopic torque.
---@return boolean
function PrimitiveComponent.GetGyroscopicTorqueEnabled() end

---If true, this component will generate overlap events when it is overlapping other components (eg Begin Overlap).
---Both components (this and the other) must have this enabled for overlap events to occur.
---\@see [Overlap Events](https://docs.unrealengine.com/InteractiveExperiences/Physics/Collision/Overview#overlapandgenerateoverlapevents)
---\@see UpdateOverlaps(), BeginComponentOverlap(), EndComponentOverlap()
---@return boolean
function PrimitiveComponent.GetGenerateOverlapEvents() end

---Get Exclude for Specific HLODLevels
---@return integer[]
function PrimitiveComponent.GetExcludeForSpecificHLODLevels() end

---Returns the material to show in the editor details panel as being used. Skips Nanite Override materials.
---@param ElementIndex integer
---@return MaterialInterface
function PrimitiveComponent.GetEditorMaterial(ElementIndex) end

---Gets the index of the vector parameter for the custom primitive data array
---@param ParameterName string
---@return integer
function PrimitiveComponent.GetCustomPrimitiveDataIndexForVectorParameter(ParameterName) end

---Gets the index of the scalar parameter for the custom primitive data array
---@param ParameterName string
---@return integer
function PrimitiveComponent.GetCustomPrimitiveDataIndexForScalarParameter(ParameterName) end

---Gets the response type given a specific channel
---@param Channel integer
---@return integer
function PrimitiveComponent.GetCollisionResponseToChannel(Channel) end

---Get the collision profile name
---@return string
function PrimitiveComponent.GetCollisionProfileName() end

---Gets the collision object type
---@return integer
function PrimitiveComponent.GetCollisionObjectType() end

---Returns the form of collision for this component
---@return integer
function PrimitiveComponent.GetCollisionEnabled() end

---Returns the distance and closest point to the collision surface.
---Component must have simple collision to be queried for closest point.
---                              If returns < 0.f, this primitive does not have collsion
---@param BoneName string
---@return number
function PrimitiveComponent.GetClosestPointOnCollision(BoneName) end

---Get the center of mass of a single body. In the case of a welded body this will return the center of mass of the entire welded body (including its parent and children)
---Objects that are not simulated return (0,0,0) as they do not have COM
---@param BoneName string
---@return Vector
function PrimitiveComponent.GetCenterOfMass(BoneName) end

---Returns BodyInstanceAsyncPhysicsTickHandle of the component. For use in the Async Physics Tick event
---@param BoneName string
---@param bGetWelded boolean
---@param Index integer
---@return BodyInstanceAsyncPhysicsTickHandle
function PrimitiveComponent.GetBodyInstanceAsyncPhysicsTickHandle(BoneName, bGetWelded, Index) end

---Returns the angular damping of this component.
---@return number
function PrimitiveComponent.GetAngularDamping() end

---Creates a Dynamic Material Instance for the specified element index, optionally from the supplied material.
---@param ElementIndex integer
---@param SourceMaterial MaterialInterface
---@param OptionalName string
---@return MaterialInstanceDynamic
function PrimitiveComponent.CreateDynamicMaterialInstance(ElementIndex, SourceMaterial, OptionalName) end

---Creates a Dynamic Material Instance for the specified element index.  The parent of the instance is set to the material being replaced.
---@param ElementIndex integer
---@param Parent MaterialInterface
---@return MaterialInstanceDynamic
function PrimitiveComponent.CreateAndSetMaterialInstanceDynamicFromMaterial(ElementIndex, Parent) end

---Creates a Dynamic Material Instance for the specified element index.  The parent of the instance is set to the material being replaced.
---@param ElementIndex integer
---@return MaterialInstanceDynamic
function PrimitiveComponent.CreateAndSetMaterialInstanceDynamic(ElementIndex) end

---Returns the list of actors we currently ignore when moving.
---@return PrimitiveComponent[]
function PrimitiveComponent.CopyArrayOfMoveIgnoreComponents() end

---Returns the list of actors we currently ignore when moving.
---@return Actor[]
function PrimitiveComponent.CopyArrayOfMoveIgnoreActors() end

---Clear the list of components we ignore when moving.
---@return nil
function PrimitiveComponent.ClearMoveIgnoreComponents() end

---Clear the list of actors we ignore when moving.
---@return nil
function PrimitiveComponent.ClearMoveIgnoreActors() end

---Return true if the given Pawn can step up onto this component.
---This controls whether they can try to step up on it when they bump in to it, not whether they can walk on it after landing on it.
---\@see CanCharacterStepUpOn
---@param Pawn Pawn
---@return boolean
function PrimitiveComponent.CanCharacterStepUp(Pawn) end

---Add an impulse to a single rigid body at a specific location. The Strength is taken as a change in angular velocity instead of an impulse (ie. mass will have no effect).
---@param Impulse Vector
---@param Location Vector
---@param BoneName string
---@return nil
function PrimitiveComponent.AddVelocityChangeImpulseAtLocation(Impulse, Location, BoneName) end

---Add a torque to a single rigid body.
---@param Torque Vector
---@param BoneName string
---@param bAccelChange boolean
---@return nil
function PrimitiveComponent.AddTorqueInRadians(Torque, BoneName, bAccelChange) end

---Add a torque to a single rigid body.
---@param Torque Vector
---@param BoneName string
---@param bAccelChange boolean
---@return nil
function PrimitiveComponent.AddTorqueInDegrees(Torque, BoneName, bAccelChange) end

---Add an impulse to all rigid bodies in this component, radiating out from the specified position.
---@param Origin Vector
---@param Radius number
---@param Strength number
---@param Falloff integer
---@param bVelChange boolean
---@return nil
function PrimitiveComponent.AddRadialImpulse(Origin, Radius, Strength, Falloff, bVelChange) end

---Add a force to all bodies in this component, originating from the supplied world-space location.
---@param Origin Vector
---@param Radius number
---@param Strength number
---@param Falloff integer
---@param bAccelChange boolean
---@return nil
function PrimitiveComponent.AddRadialForce(Origin, Radius, Strength, Falloff, bAccelChange) end

---Add an impulse to a single rigid body at a specific location.
---@param Impulse Vector
---@param Location Vector
---@param BoneName string
---@return nil
function PrimitiveComponent.AddImpulseAtLocation(Impulse, Location, BoneName) end

---Add an impulse to a single rigid body. Good for one time instant burst.
---@param Impulse Vector
---@param BoneName string
---@param bVelChange boolean
---@return nil
function PrimitiveComponent.AddImpulse(Impulse, BoneName, bVelChange) end

---Add a force to a single rigid body at a particular location. Both Force and Location should be in body space.
---This is like a 'thruster'. Good for adding a burst over some (non zero) time. Should be called every frame for the duration of the force.
---@param Force Vector
---@param Location Vector
---@param BoneName string
---@return nil
function PrimitiveComponent.AddForceAtLocationLocal(Force, Location, BoneName) end

---Add a force to a single rigid body at a particular location in world space.
---This is like a 'thruster'. Good for adding a burst over some (non zero) time. Should be called every frame for the duration of the force.
---@param Force Vector
---@param Location Vector
---@param BoneName string
---@return nil
function PrimitiveComponent.AddForceAtLocation(Force, Location, BoneName) end

---Add a force to a single rigid body.
---This is like a 'thruster'. Good for adding a burst over some (non zero) time. Should be called every frame for the duration of the force.
---@param Force Vector
---@param BoneName string
---@param bAccelChange boolean
---@return nil
function PrimitiveComponent.AddForce(Force, BoneName, bAccelChange) end

---Add an angular impulse to a single rigid body. Good for one time instant burst.
---@param Impulse Vector
---@param BoneName string
---@param bVelChange boolean
---@return nil
function PrimitiveComponent.AddAngularImpulseInRadians(Impulse, BoneName, bVelChange) end

---Add an angular impulse to a single rigid body. Good for one time instant burst.
---@param Impulse Vector
---@param BoneName string
---@param bVelChange boolean
---@return nil
function PrimitiveComponent.AddAngularImpulseInDegrees(Impulse, BoneName, bVelChange) end

return PrimitiveComponent
