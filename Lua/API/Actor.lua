---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Actor
---Actor is the base class for an Object that can be placed or spawned in a level.
---Actors may contain a collection of ActorComponents, which can be used to control how actors move, how they are rendered, etc.
---The other main function of an Actor is the replication of properties and function calls across the network during play.
---Actor initialization has multiple steps, here's the order of important virtual functions that get called:
---- UObject::PostLoad: For actors statically placed in a level, the normal UObject PostLoad gets called both in the editor and during gameplay.
---                     This is not called for newly spawned actors.
---- UActorComponent::OnComponentCreated: When an actor is spawned in the editor or during gameplay, this gets called for any native components.
---                                       For blueprint-created components, this gets called during construction for that component.
---                                       This is not called for components loaded from a level.
---- AActor::PreRegisterAllComponents: For statically placed actors and spawned actors that have native root components, this gets called now.
---                                    For blueprint actors without a native root component, these registration functions get called later during construction.
---- UActorComponent::RegisterComponent: All components are registered in editor and at runtime, this creates their physical/visual representation.
---                                      These calls may be distributed over multiple frames, but are always after PreRegisterAllComponents.
---                                      This may also get called later on after an UnregisterComponent call removes it from the world.
---- AActor::PostRegisterAllComponents: Called for all actors both in the editor and in gameplay, this is the last function that is called in all cases.
---- AActor::PostActorCreated: When an actor is created in the editor or during gameplay, this gets called right before construction.
---                            This is not called for components loaded from a level.
---- AActor::UserConstructionScript: Called for blueprints that implement a construction script.
---- AActor::OnConstruction: Called at the end of ExecuteConstruction, which calls the blueprint construction script.
---                          This is called after all blueprint-created components are fully created and registered.
---                          This is only called during gameplay for spawned actors, and may get rerun in the editor when changing blueprints.
---- AActor::PreInitializeComponents: Called before InitializeComponent is called on the actor's components.
---                                   This is only called during gameplay and in certain editor preview windows.
---- UActorComponent::Activate: This will be called only if the component has bAutoActivate set.
---                             It will also got called later on if a component is manually activated.
---- UActorComponent::InitializeComponent: This will be called only if the component has bWantsInitializeComponentSet.
---                                        This only happens once per gameplay session.
---- AActor::PostInitializeComponents: Called after the actor's components have been initialized, only during gameplay and some editor previews.
---- AActor::BeginPlay: Called when the level starts ticking, only during actual gameplay.
---                     This normally happens right after PostInitializeComponents but can be delayed for networked or child actors.
---@see https://docs.unrealengine.com/Programming/UnrealArchitecture/Actors
---@see https://docs.unrealengine.com/Programming/UnrealArchitecture/Actors/ActorLifecycle
---@see UActorComponent
---
--- Properties
---
---Primary Actor tick function, which calls TickActor().
---Tick functions can be configured to control whether ticking is enabled, at what time during a frame the update occurs, and to set up tick dependencies.
---\@see https://docs.unrealengine.com/API/Runtime/Engine/Engine/FTickFunction
---\@see AddTickPrerequisiteActor(), AddTickPrerequisiteComponent()
---@field PrimaryActorTick ActorTickFunction
---If true, when the actor is spawned it will be sent to the client but receive no further replication updates from the server afterwards.
---@field bNetTemporary boolean
---If true, this actor is only relevant to its owner. If this flag is changed during play, all non-owner channels would need to be explicitly closed.
---@field bOnlyRelevantToOwner boolean
---Always relevant for network (overrides bOnlyRelevantToOwner).
---@field bAlwaysRelevant boolean
---If checked, this Actor will only get loaded in a main world (persistent level), it will not be loaded through Level Instances.
---@field bIsMainWorldOnly boolean
---Experimental: this will force this actor to be ignored in PIE, will not work if the actor has references to other actors without the flag set, use with care.
---@field bIgnoreInPIE boolean
---Whether we have already exchanged Role/RemoteRole on the client, as when removing then re-adding a streaming level.
---Causes all initialization to be performed again even though the actor may not have actually been reloaded.
---@field bExchangedRoles boolean
---This actor will be loaded on network clients during map load
---@field bNetLoadOnClient boolean
---If actor has valid Owner, call Owner's IsNetRelevantFor and GetNetPriority
---@field bNetUseOwnerRelevancy boolean
---If true, this actor will be replicated to network replays (default is true)
---@field bRelevantForNetworkReplays boolean
---If true, this actor's component's bounds will be included in the level's
---bounding box unless the Actor's class has overridden IsLevelBoundsRelevant
---@field bRelevantForLevelBounds boolean
---If true, this actor will only be destroyed during scrubbing if the replay is set to a time before the actor existed.
---Otherwise, RewindForReplay will be called if we detect the actor needs to be reset.
---Note, this Actor must not be destroyed by gamecode, and RollbackViaDeletion may not be used.
---@field bReplayRewindable boolean
---Whether we allow this Actor to tick before it receives the BeginPlay event.
---Normally we don't tick actors until after BeginPlay; this setting allows this behavior to be overridden.
---This Actor must be able to tick for this setting to be relevant.
---@field bAllowTickBeforeBeginPlay boolean
---If true, all input on the stack below this actor will not be considered
---@field bBlockInput boolean
---This actor collides with the world when placing in the editor, even if RootComponent collision is disabled. Does not affect spawning, \@see SpawnCollisionHandlingMethod
---@field bCollideWhenPlacing boolean
---If true, this actor should search for an owned camera component to view through when used as a view target.
---@field bFindCameraComponentWhenViewTarget boolean
---If true, this actor will generate overlap Begin/End events when spawned as part of level streaming, which includes initial level load.
---You might enable this is in the case where a streaming level loads around an actor and you want Begin/End overlap events to trigger.
---\@see UpdateOverlapsMethodDuringLevelStreaming
---@field bGenerateOverlapEventsDuringLevelStreaming boolean
---Whether this actor should not be affected by world origin shifting.
---@field bIgnoresOriginShifting boolean
---Whether this actor should be considered or not during HLOD generation.
---@field bEnableAutoLODGeneration boolean
---Whether this actor is editor-only. Use with care, as if this actor is referenced by anything else that reference will be NULL in cooked builds
---@field bIsEditorOnlyActor boolean
---If true, this actor will replicate to remote machines
---\@see SetReplicates()
---@field bReplicates boolean
---If true, this actor can be put inside of a GC Cluster to improve Garbage Collection performance
---@field bCanBeInCluster boolean
---If false, the Blueprint ReceiveTick() event will be disabled on dedicated servers.
---\@see AllowReceiveTickEventOnDedicatedServer()
---@field bAllowReceiveTickEventOnDedicatedServer boolean
---When true the replication system will only replicate the registered subobjects and the replicated actor components list
---When false the replication system will instead call the virtual ReplicateSubobjects() function where the subobjects and actor components need to be manually replicated.
---@field bReplicateUsingRegisteredSubObjectList boolean
---Whether to use use the async physics tick with this actor.
---@field bAsyncPhysicsTickEnabled boolean
---Condition for calling UpdateOverlaps() to initialize overlap state when loaded in during level streaming.
---If set to 'UseConfigDefault', the default specified in ini (displayed in 'DefaultUpdateOverlapsMethodDuringLevelStreaming') will be used.
---If overlaps are not initialized, this actor and attached components will not have an initial state of what objects are touching it,
---and overlap events may only come in once one of those objects update overlaps themselves (for example when moving).
---However if an object touching it *does* initialize state, both objects will know about their touching state with each other.
---This can be a potentially large performance savings during level loading and streaming, and is safe if the object and others initially
---overlapping it do not need the overlap state because they will not trigger overlap notifications.
---Note that if 'bGenerateOverlapEventsDuringLevelStreaming' is true, overlaps are always updated in this case, but that flag
---determines whether the Begin/End overlap events are triggered.
---\@see bGenerateOverlapEventsDuringLevelStreaming, DefaultUpdateOverlapsMethodDuringLevelStreaming, GetUpdateOverlapsMethodDuringLevelStreaming()
---@field UpdateOverlapsMethodDuringLevelStreaming EActorUpdateOverlapsMethod
---How long this Actor lives before dying, 0=forever. Note this is the INITIAL value and should not be modified once play has begun.
---@field InitialLifeSpan number
---Allow each actor to run at a different time speed. The DeltaTime for a frame is multiplied by the global TimeDilation (in WorldSettings) and this CustomTimeDilation for this actor's tick.
---@field CustomTimeDilation number
---@field GridPlacement EActorGridPlacement
---Determine in which partition grid this actor will be placed in the partition (if the world is partitioned).
---If None, the decision will be left to the partition.
---@field RuntimeGrid string
---Used for replicating attachment of this actor's RootComponent to another actor.
---This is filled in via GatherCurrentMovement() when the RootComponent has an AttachParent.
---@field AttachmentReplication RepAttachment
---Owner of this Actor, used primarily for replication (bNetUseOwnerRelevancy & bOnlyRelevantToOwner) and visibility (PrimitiveComponent bOwnerNoSee and bOnlyOwnerSee)
---\@see SetOwner(), GetOwner()
---@field Owner Actor
---Used to specify the net driver to replicate on (NAME_None || NAME_GameNetDriver is the default net driver)
---@field NetDriverName string
---Dormancy setting for actor to take itself off of the replication list without being destroyed on clients.
---@field NetDormancy integer
---Controls how to handle spawning this actor in a situation where it's colliding with something else. "Default" means AlwaysSpawn here.
---@field SpawnCollisionHandlingMethod ESpawnActorCollisionHandlingMethod
---Automatically registers this actor to receive input from a player.
---@field AutoReceiveInput integer
---The priority of this input component when pushed in to the stack.
---@field InputPriority integer
---Component that handles input for this actor, if input is enabled.
---@field InputComponent InputComponent
---Internal - used by UNetDriver
---@field NetTag integer
---@field NetCullDistanceSquared number
---@field NetUpdateFrequency number
---@field MinNetUpdateFrequency number
---Priority for this actor when checking for replication in a low bandwidth or saturated situation, higher priority means it is more likely to replicate
---@field NetPriority number
---Array of all Actors whose Owner is this actor, these are not necessarily spawned by UChildActorComponent
---@field Children Actor[]
---The component that defines the transform (location, rotation, scale) of this Actor in the world, all other components must be attached to this one somehow
---@field RootComponent SceneComponent
---Local space pivot offset for the actor, only used in the editor
---@field PivotOffset Vector
---Layers the actor belongs to.  This is outside of the editoronly data to allow hiding of LD-specified layers at runtime for profiling.
---@field Layers string[]
---The GUID for this actor; this guid will be the same for actors from instanced streaming levels.
---\@see         ActorInstanceGuid, FActorInstanceGuidMapper
---@note        Don't use VisibleAnywhere here to avoid getting the CPF_Edit flag and get this property reset when resetting to defaults.
---                     See FActorDetails::AddActorCategory and EditorUtilities::CopySingleProperty for details.
---@field ActorGuid Guid
---The instance GUID for this actor; this guid will be unique for actors from instanced streaming levels.
---\@see         ActorGuid
---@note        This is not guaranteed to be valid during PostLoad, but safe to access from RegisterAllComponents.
---@field ActorInstanceGuid Guid
---The GUID for this actor's content bundle.
---@field ContentBundleGuid Guid
---DataLayers the actor belongs to.
---@field DataLayers ActorDataLayer[]
---DataLayers assets the actor belongs to.
---@field DataLayerAssets any[]
---@field ExternalDataLayerAsset ExternalDataLayerAsset
---The editor-only group this actor is a part of.
---@field GroupActor Actor
---The scale to apply to any billboard components in editor builds (happens in any WITH_EDITOR build, including non-cooked games).
---@field SpriteScale number
---Bitflag to represent which views this actor is hidden in, via per-view layer visibility.
---@field HiddenEditorViews integer
---Whether this actor is hidden within the editor viewport.
---@field bHiddenEd boolean
---True if this actor is the preview actor dragged out of the content browser
---@field bIsEditorPreviewActor boolean
---Whether this actor is hidden by the layer browser.
---@field bHiddenEdLayer boolean
---Whether this actor is hidden by the level browser.
---@field bHiddenEdLevel boolean
---If true, prevents the actor from being moved in the editor viewport.
---@field bLockLocation boolean
---Is the actor label editable by the user?
---@field bActorLabelEditable boolean
---Whether the actor can be manipulated by editor operations.
---@field bEditable boolean
---Whether this actor should be listed in the scene outliner.
---@field bListedInSceneOutliner boolean
---Whether to cook additional data to speed up spawn events at runtime for any Blueprint classes based on this Actor. This option may slightly increase memory usage in a cooked build.
---@field bOptimizeBPComponentData boolean
---Whether the actor can be used as a PlayFromHere origin (OnPlayFromHere() will be called on that actor)
---@field bCanPlayFromHere boolean
---Determine if this actor is spatially loaded when placed in a partitioned world.
---     If true, this actor will be loaded when in the range of any streaming sources and if (1) in no data layers, or (2) one or more of its data layers are enabled.
---     If false, this actor will be loaded if (1) in no data layers, or (2) one or more of its data layers are enabled.
---@field bIsSpatiallyLoaded boolean
---Array of tags that can be used for grouping and categorizing.
---@field Tags string[]
---Called when the actor is damaged in any way.
---@field OnTakeAnyDamage function
---Called when the actor is damaged by point damage.
---@field OnTakePointDamage function
---Called when the actor is damaged by radial damage.
---@field OnTakeRadialDamage function
---Called when another actor begins to overlap this actor, for example a player walking into a trigger.
---For events when objects have a blocking collision, for example a player hitting a wall, see 'Hit' events.
---@note Components on both this and the other Actor must have bGenerateOverlapEvents set to true to generate overlap events.
---@field OnActorBeginOverlap function
---Called when another actor stops overlapping this actor.
---@note Components on both this and the other Actor must have bGenerateOverlapEvents set to true to generate overlap events.
---@field OnActorEndOverlap function
---Called when the mouse cursor is moved over this actor if mouse over events are enabled in the player controller.
---@field OnBeginCursorOver function
---Called when the mouse cursor is moved off this actor if mouse over events are enabled in the player controller.
---@field OnEndCursorOver function
---Called when the left mouse button is clicked while the mouse is over this actor and click events are enabled in the player controller.
---@field OnClicked function
---Called when the left mouse button is released while the mouse is over this actor and click events are enabled in the player controller.
---@field OnReleased function
---Called when a touch input is received over this actor when touch events are enabled in the player controller.
---@field OnInputTouchBegin function
---Called when a touch input is received over this component when touch events are enabled in the player controller.
---@field OnInputTouchEnd function
---Called when a finger is moved over this actor when touch over events are enabled in the player controller.
---@field OnInputTouchEnter function
---Called when a finger is moved off this actor when touch over events are enabled in the player controller.
---@field OnInputTouchLeave function
---Called when this Actor hits (or is hit by) something solid. This could happen due to things like Character movement, using Set Location with 'sweep' enabled, or physics simulation.
---For events when objects overlap (e.g. walking into a trigger) see the 'Overlap' event.
---@note For collisions during physics simulation to generate hit events, 'Simulation Generates Hit Events' must be enabled.
---@field OnActorHit function
---Event triggered when the actor has been explicitly destroyed.
---@field OnDestroyed function
---Event triggered when the actor is being deleted or removed from a level.
---@field OnEndPlay function
---Array of ActorComponents that are created by blueprints and serialized per-instance.
---@field BlueprintCreatedComponents ActorComponent[]
local Actor = {}

--- Methods
---Returns true if this actor has been rendered "recently", with a tolerance in seconds to define what "recent" means.
---e.g.: If a tolerance of 0.1 is used, this function will return true only if the actor was rendered in the last 0.1 seconds of game time.
---@param Tolerance number
---@return boolean
function Actor.WasRecentlyRendered(Tolerance) end

---Unregister this actors root components physics object from being a focal particle in Physics Repliocation LOD
---@return nil
function Actor.UnregisterAsFocalPointInPhysicsReplicationLOD() end

---Networking - Server - TearOff this actor to stop replication to clients. Will set bTearOff to true.
---@return nil
function Actor.TearOff() end

---Sets the ticking group for this actor.
---@param NewTickGroup integer
---@return nil
function Actor.SetTickGroup(NewTickGroup) end

---Sets whether this actor can tick when paused.
---@param bTickableWhenPaused boolean
---@return nil
function Actor.SetTickableWhenPaused(bTickableWhenPaused) end

---Set whether this actor replicates to network clients. When this actor is spawned on the server it will be sent to clients as well.
---Properties flagged for replication will update on clients if they change on the server.
---Internally changes the RemoteRole property and handles the cases where the actor needs to be added to the network actor list.
---\@see https://docs.unrealengine.com/InteractiveExperiences/Networking/Actors
---@param bInReplicates boolean
---@return nil
function Actor.SetReplicates(bInReplicates) end

---Set whether this actor's movement replicates to network clients.
---@param bInReplicateMovement boolean
---@return nil
function Actor.SetReplicateMovement(bInReplicateMovement) end

---Specify a RayTracingGroupId for this actors. Components with invalid RayTracingGroupId will inherit the actors.
---@param InRaytracingGroupId integer
---@return nil
function Actor.SetRayTracingGroupId(InRaytracingGroupId) end

---Set the physics replication mode of this body, via EPhysicsReplicationMode
---@param ReplicationMode EPhysicsReplicationMode
---@return nil
function Actor.SetPhysicsReplicationMode(ReplicationMode) end

---Set the owner of this Actor, used primarily for network replication.
---@param NewOwner Actor
---@return nil
function Actor.SetOwner(NewOwner) end

---Set the frequency at which this object will be considered for replication.
---@param Frequency number
---@return nil
function Actor.SetNetUpdateFrequency(Frequency) end

---Puts actor in dormant networking state
---@param NewDormancy integer
---@return nil
function Actor.SetNetDormancy(NewDormancy) end

---Set the square of the max distance from the client's viewpoint that this actor is relevant and will be replicated.
---@param DistanceSq number
---@return nil
function Actor.SetNetCullDistanceSquared(DistanceSq) end

---Set the frequency to throttle down to when replicated properties are changing infrequently.
---@param MinFrequency number
---@return nil
function Actor.SetMinNetUpdateFrequency(MinFrequency) end

---Set the lifespan of this actor. When it expires the object will be destroyed. If requested lifespan is 0, the timer is cleared and the actor will not be destroyed.
---@param InLifespan number
---@return nil
function Actor.SetLifeSpan(InLifespan) end

---Explicitly sets whether or not this actor is hidden in the editor for the duration of the current editor session
---@param bIsHidden boolean
---@return nil
function Actor.SetIsTemporarilyHiddenInEditor(bIsHidden) end

---Assigns a new folder to this actor. Actor folder paths are only available in development builds.
---@return nil
function Actor.SetFolderPath() end

---Set Auto Destroy when Finished
---@param bVal boolean
---@return nil
function Actor.SetAutoDestroyWhenFinished(bVal) end

---Sets the tick interval of this actor's primary tick function. Will not enable a disabled tick function. Takes effect on next tick.
---@param TickInterval number
---@return nil
function Actor.SetActorTickInterval(TickInterval) end

---Set this actor's tick functions to be enabled or disabled. Only has an effect if the function is registered
---This only modifies the tick function on actor itself
---@param bEnabled boolean
---@return nil
function Actor.SetActorTickEnabled(bEnabled) end

---Set the Actor's world-space scale.
---@param NewScale3D Vector
---@return nil
function Actor.SetActorScale3D(NewScale3D) end

---Set the actor's RootComponent to the specified relative scale 3d
---@param NewRelativeScale Vector
---@return nil
function Actor.SetActorRelativeScale3D(NewRelativeScale) end

---Assigns a new label to this actor.  Actor labels are only available in development builds.
---@param NewActorLabel string
---@param bMarkDirty boolean
---@return nil
function Actor.SetActorLabel(NewActorLabel, bMarkDirty) end

---Sets the actor to be hidden in the game
---@param bNewHidden boolean
---@return nil
function Actor.SetActorHiddenInGame(bNewHidden) end

---Allows enabling/disabling collision for the whole actor
---@param bNewActorEnableCollision boolean
---@return nil
function Actor.SetActorEnableCollision(bNewActorEnableCollision) end

---Remove tick dependency on PrerequisiteComponent.
---@param PrerequisiteComponent ActorComponent
---@return nil
function Actor.RemoveTickPrerequisiteComponent(PrerequisiteComponent) end

---Remove tick dependency on PrerequisiteActor.
---@param PrerequisiteActor Actor
---@return nil
function Actor.RemoveTickPrerequisiteActor(PrerequisiteActor) end

---Register this actors root components physics object as a focal particle in Physics Repliocation LOD
---@return nil
function Actor.RegisterAsFocalPointInPhysicsReplicationLOD() end

---Calls PrestreamTextures() for all the actor's meshcomponents.
---@param Seconds number
---@param bEnableStreaming boolean
---@param CinematicTextureGroups integer
---@return nil
function Actor.PrestreamTextures(Seconds, bEnableStreaming, CinematicTextureGroups) end

---Trigger a noise caused by a given Pawn, at a given location.
---Note that the NoiseInstigator Pawn MUST have a PawnNoiseEmitterComponent for the noise to be detected by a PawnSensingComponent.
---Senders of MakeNoise should have an Instigator if they are not pawns, or pass a NoiseInstigator.
---@param Loudness number
---@param NoiseInstigator Pawn
---@param NoiseLocation Vector
---@param MaxRange number
---@param Tag string
---@return nil
function Actor.MakeNoise(Loudness, NoiseInstigator, NoiseLocation, MaxRange, Tag) end

---Teleport this actor to a new location. If the actor doesn't fit exactly at the location specified, tries to slightly move it out of walls and such.
---@param DestLocation Vector
---@param DestRotation Rotator
---@return boolean
function Actor.K2_TeleportTo(DestLocation, DestRotation) end

---Set the Actors transform to the specified one.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the transform without teleporting will not update the transform of simulated child/attached components.
---@param bSweep boolean
---@param bTeleport boolean
---@return boolean
function Actor.K2_SetActorTransform(bSweep, bTeleport) end

---Set the Actor's rotation instantly to the specified rotation.
---                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---         Setting the rotation without teleporting will not update the rotation of simulated child/attached components.
---@param NewRotation Rotator
---@param bTeleportPhysics boolean
---@return boolean
function Actor.K2_SetActorRotation(NewRotation, bTeleportPhysics) end

---Set the actor's RootComponent to the specified relative transform
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the transform without teleporting will not update the transform of simulated child/attached components.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_SetActorRelativeTransform(bSweep, bTeleport) end

---Set the actor's RootComponent to the specified relative rotation
---                                                             Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                             If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                             If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                             If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                             Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                             Setting the rotation without teleporting will not update the rotation of simulated child/attached components.
---@param NewRelativeRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_SetActorRelativeRotation(NewRelativeRotation, bSweep, bTeleport) end

---Set the actor's RootComponent to the specified relative location.
---                                                             Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                             If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                             If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                             If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                             Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                             Setting the location without teleporting will not update the location of simulated child/attached components.
---@param NewRelativeLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_SetActorRelativeLocation(NewRelativeLocation, bSweep, bTeleport) end

---Move the actor instantly to the specified location and rotation.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the location without teleporting will not update the location of simulated child/attached components.
---@param NewLocation Vector
---@param NewRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return boolean
function Actor.K2_SetActorLocationAndRotation(NewLocation, NewRotation, bSweep, bTeleport) end

---Move the Actor to the specified location.
---                                             Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                             If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                             If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                             If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                     Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                     Setting the location without teleporting will not update the location of simulated child/attached components.
---@param NewLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return boolean
function Actor.K2_SetActorLocation(NewLocation, bSweep, bTeleport) end

---Returns the RootComponent of this Actor
---@return SceneComponent
function Actor.K2_GetRootComponent() end

---Gets all the components that inherit from the given class.
---Currently returns an array of UActorComponent which must be cast to the correct type.
---This intended to only be used by blueprints. Use GetComponents() in C++.
---@param ComponentClass Class
---@return ActorComponent[]
function Actor.K2_GetComponentsByClass(ComponentClass) end

---Returns rotation of the RootComponent of this Actor.
---@return Rotator
function Actor.K2_GetActorRotation() end

---Returns the location of the RootComponent of this Actor
---@return Vector
function Actor.K2_GetActorLocation() end

---Detaches the RootComponent of this Actor from any SceneComponent it is currently attached to.
---@param LocationRule EDetachmentRule
---@param RotationRule EDetachmentRule
---@param ScaleRule EDetachmentRule
---@return nil
function Actor.K2_DetachFromActor(LocationRule, RotationRule, ScaleRule) end

---Destroy the actor
---@return nil
function Actor.K2_DestroyActor() end

---Attaches the RootComponent of this Actor to the supplied component, optionally at a named socket. It is not valid to call this on components that are not Registered.
---@param Parent SceneComponent
---@param SocketName string
---@param LocationRule EAttachmentRule
---@param RotationRule EAttachmentRule
---@param ScaleRule EAttachmentRule
---@param bWeldSimulatedBodies boolean
---@return boolean
function Actor.K2_AttachToComponent(Parent, SocketName, LocationRule, RotationRule, ScaleRule, bWeldSimulatedBodies) end

---Attaches the RootComponent of this Actor to the supplied actor, optionally at a named socket.
---@param ParentActor Actor
---@param SocketName string
---@param LocationRule EAttachmentRule
---@param RotationRule EAttachmentRule
---@param ScaleRule EAttachmentRule
---@param bWeldSimulatedBodies boolean
---@return boolean
function Actor.K2_AttachToActor(ParentActor, SocketName, LocationRule, RotationRule, ScaleRule, bWeldSimulatedBodies) end

---K2 Attach Root Component to Actor
---@param InParentActor Actor
---@param InSocketName string
---@param AttachLocationType integer
---@param bWeldSimulatedBodies boolean
---@return nil
function Actor.K2_AttachRootComponentToActor(InParentActor, InSocketName, AttachLocationType, bWeldSimulatedBodies) end

---K2 Attach Root Component To
---@param InParent SceneComponent
---@param InSocketName string
---@param AttachLocationType integer
---@param bWeldSimulatedBodies boolean
---@return nil
function Actor.K2_AttachRootComponentTo(InParent, InSocketName, AttachLocationType, bWeldSimulatedBodies) end

---Adds a delta to the transform of this actor in world space. Scale is unchanged.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorWorldTransformKeepScale(bSweep, bTeleport) end

---Adds a delta to the transform of this actor in world space. Ignores scale and sets it to (1,1,1).
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorWorldTransform(bSweep, bTeleport) end

---Adds a delta to the rotation of this actor in world space.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the rotation without teleporting will not update the rotation of simulated child/attached components.
---@param DeltaRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorWorldRotation(DeltaRotation, bSweep, bTeleport) end

---Adds a delta to the location of this actor in world space.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the location without teleporting will not update the location of simulated child/attached components.
---@param DeltaLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorWorldOffset(DeltaLocation, bSweep, bTeleport) end

---Adds a delta to the transform of this component in its local reference frame
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the transform without teleporting will not update the transform of simulated child/attached components.
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorLocalTransform(bSweep, bTeleport) end

---Adds a delta to the rotation of this component in its local reference frame
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the rotation without teleporting will not update the rotation of simulated child/attached components.
---@param DeltaRotation Rotator
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorLocalRotation(DeltaRotation, bSweep, bTeleport) end

---Adds a delta to the location of this component in its local reference frame.
---                                                     Only the root component is swept and checked for blocking collision, child components move without sweeping. If collision is off, this has no effect.
---                                                     If true, physics velocity for this object is unchanged (so ragdoll parts are not affected by change in location).
---                                                     If false, physics velocity is updated based on the change in position (affecting ragdoll parts).
---                                                     If CCD is on and not teleporting, this will affect objects along the entire swept volume.
---                         Note that when teleporting, any child/attached components will be teleported too, maintaining their current offset even if they are being simulated.
---                         Setting the location without teleporting will not update the location of simulated child/attached components.
---@param DeltaLocation Vector
---@param bSweep boolean
---@param bTeleport boolean
---@return nil, HitResult
function Actor.K2_AddActorLocalOffset(DeltaLocation, bSweep, bTeleport) end

---Returns whether or not this actor was explicitly hidden in the editor for the duration of the current editor session
---@param bIncludeParent boolean
---@return boolean
function Actor.IsTemporarilyHiddenInEditor(bIncludeParent) end

---Returns true if this actor can EVER be selected in a level in the editor.  Can be overridden by specific actors to make them unselectable.
---@return boolean
function Actor.IsSelectable() end

---Check whether any component of this Actor is overlapping any component of another Actor.
---@param Other Actor
---@return boolean
function Actor.IsOverlappingActor(Other) end

---Returns true if the actor is hidden upon editor startup/by default, false if it is not
---@return boolean
function Actor.IsHiddenEdAtStartup() end

---Returns true if this actor is hidden in the editor viewports, also checking temporary flags.
---@return boolean
function Actor.IsHiddenEd() end

---Returns true if this actor is allowed to be displayed, selected and manipulated by the editor.
---@return boolean
function Actor.IsEditable() end

---Returns whether this Actor was spawned by a child actor component
---@return boolean
function Actor.IsChildActor() end

---Returns whether this actor has tick enabled or not
---@return boolean
function Actor.IsActorTickEnabled() end

---Returns true if this actor is currently being destroyed, some gameplay events may be unsafe
---@return boolean
function Actor.IsActorBeingDestroyed() end

---Returns whether this actor has network authority
---@return boolean
function Actor.HasAuthority() end

---Returns the distance from this Actor to OtherActor, ignoring XY.
---@param OtherActor Actor
---@return number
function Actor.GetVerticalDistanceTo(OtherActor) end

---Returns velocity (in cm/s (Unreal Units/second) of the rootcomponent if it is either using physics or has an associated MovementComponent
---@return Vector
function Actor.GetVelocity() end

---Get the actor-to-world transform.
---@return Transform
function Actor.GetTransform() end

---Gets whether this actor can tick when paused.
---@return boolean
function Actor.GetTickableWhenPaused() end

---Returns the squared distance from this Actor to OtherActor, ignoring Z.
---@param OtherActor Actor
---@return number
function Actor.GetSquaredHorizontalDistanceTo(OtherActor) end

---Returns the squared distance from this Actor to OtherActor.
---@param OtherActor Actor
---@return number
function Actor.GetSquaredDistanceTo(OtherActor) end

---Get the error threshold in centimeters before this object should enforce a resimulation to trigger.
---@return number
function Actor.GetResimulationThreshold() end

---Returns how much control the remote machine has over this actor.
---@return integer
function Actor.GetRemoteRole() end

---Return the RayTracingGroupId for this actor.
---@return integer
function Actor.GetRayTracingGroupId() end

---Get the physics replication mode of this body, via EPhysicsReplicationMode
---@return EPhysicsReplicationMode
function Actor.GetPhysicsReplicationMode() end

---If this Actor was created by a Child Actor Component returns that Child Actor Component
---@return ChildActorComponent
function Actor.GetParentComponent() end

---If this Actor was created by a Child Actor Component returns the Actor that owns that Child Actor Component
---@return Actor
function Actor.GetParentActor() end

---Get the owner of this Actor, used primarily for network replication.
---@return Actor
function Actor.GetOwner() end

---Returns list of components this actor is overlapping.
---@return nil, PrimitiveComponent[]
function Actor.GetOverlappingComponents() end

---Returns list of actors this actor is overlapping (any component overlapping any component). Does not return itself.
---@param ClassFilter Class
---@return nil, Actor[]
function Actor.GetOverlappingActors(ClassFilter) end

---Get the current frequency at which this object will be considered for replication.
---@return number
function Actor.GetNetUpdateFrequency() end

---Get the square of the max distance from the client's viewpoint that this actor is relevant and will be replicated.
---@return number
function Actor.GetNetCullDistanceSquared() end

---Get the frequency to throttle down to when replicated properties are changing infrequently.
---@return number
function Actor.GetMinNetUpdateFrequency() end

---Returns how much control the local machine has over this actor.
---@return integer
function Actor.GetLocalRole() end

---Get the remaining lifespan of this actor. If zero is returned the actor lives forever.
---@return number
function Actor.GetLifeSpan() end

---Return the FTransform of the level this actor is a part of.
---@return Transform
function Actor.GetLevelTransform() end

---Return the ULevel that this Actor is part of.
---@return Level
function Actor.GetLevel() end

---Returns the instigator's controller for this actor, or nullptr if there is none.
---@return Controller
function Actor.GetInstigatorController() end

---Returns the instigator for this actor, or nullptr if there is none.
---@return Pawn
function Actor.GetInstigator() end

---Gets the value of the input axis key if input is enabled for this actor.
---@param InputAxisKey Key
---@return Vector
function Actor.GetInputVectorAxisValue(InputAxisKey) end

---Gets the value of the input axis if input is enabled for this actor.
---@param InputAxisName string
---@return number
function Actor.GetInputAxisValue(InputAxisName) end

---Gets the value of the input axis key if input is enabled for this actor.
---@param InputAxisKey Key
---@return number
function Actor.GetInputAxisKeyValue(InputAxisKey) end

---Returns the dot product from this Actor to OtherActor, ignoring Z. Returns -2.0 on failure. Returns 0.0 for coincidental actors.
---@param OtherActor Actor
---@return number
function Actor.GetHorizontalDotProductTo(OtherActor) end

---Returns the distance from this Actor to OtherActor, ignoring Z.
---@param OtherActor Actor
---@return number
function Actor.GetHorizontalDistanceTo(OtherActor) end

---The number of seconds (in game time) since this Actor was created, relative to Get Game Time In Seconds.
---@return number
function Actor.GetGameTimeSinceCreation() end

---Returns this actor's folder path. Actor folder paths are only available in development builds.
---@return string
function Actor.GetFolderPath() end

---Returns the dot product from this Actor to OtherActor. Returns -2.0 on failure. Returns 0.0 for coincidental actors.
---@param OtherActor Actor
---@return number
function Actor.GetDotProductTo(OtherActor) end

---Returns the distance from this Actor to OtherActor.
---@param OtherActor Actor
---@return number
function Actor.GetDistanceTo(OtherActor) end

---Returns this actor's default label (does not include any numeric suffix).  Actor labels are only available in development builds.
---@return string
function Actor.GetDefaultActorLabel() end

---Gets all the components that inherit from the given class with a given tag.
---@param ComponentClass Class
---@param Tag string
---@return ActorComponent[]
function Actor.GetComponentsByTag(ComponentClass, Tag) end

---Gets all the components that implements the given interface.
---@param Interface Class
---@return ActorComponent[]
function Actor.GetComponentsByInterface(Interface) end

---Searches components array and returns first encountered component of the specified class
---@param ComponentClass Class
---@return ActorComponent
function Actor.GetComponentByClass(ComponentClass) end

---Walk up the attachment chain from RootComponent until we encounter a different actor, and return the socket name in the component. If we are not attached to a component in a different actor, returns NAME_None
---@return string
function Actor.GetAttachParentSocketName() end

---Walk up the attachment chain from RootComponent until we encounter a different actor, and return it. If we are not attached to a component in a different actor, returns nullptr
---@return Actor
function Actor.GetAttachParentActor() end

---Find all Actors which are attached directly to a component in this actor
---@param bResetArray boolean
---@param bRecursivelyIncludeAttachedActors boolean
---@return nil, Actor[]
function Actor.GetAttachedActors(bResetArray, bRecursivelyIncludeAttachedActors) end

---Returns a list of all actors spawned by our Child Actor Components, including children of children.
---This does not return the contents of the Children array
---@param bIncludeDescendants boolean
---@return nil, Actor[]
function Actor.GetAllChildActors(bIncludeDescendants) end

---Get the up (Z) vector (length 1.0) from this Actor, in world space.
---@return Vector
function Actor.GetActorUpVector() end

---Get ActorTimeDilation - this can be used for input control or speed control for slomo.
---We don't want to scale input globally because input can be used for UI, which do not care for TimeDilation.
---@return number
function Actor.GetActorTimeDilation() end

---Returns the tick interval of this actor's primary tick function
---@return number
function Actor.GetActorTickInterval() end

---Returns the Actor's world-space scale.
---@return Vector
function Actor.GetActorScale3D() end

---Get the right (Y) vector (length 1.0) from this Actor, in world space.
---@return Vector
function Actor.GetActorRightVector() end

---Return the actor's relative scale 3d
---@return Vector
function Actor.GetActorRelativeScale3D() end

---Returns this actor's current label.  Actor labels are only available in development builds.
---@param bCreateIfNone boolean
---@return string
function Actor.GetActorLabel(bCreateIfNone) end

---Get the forward (X) vector (length 1.0) from this Actor, in world space.
---@return Vector
function Actor.GetActorForwardVector() end

---Returns the point of view of the actor.
---Note that this doesn't mean the camera, but the 'eyes' of the actor.
---For example, for a Pawn, this would define the eye height location,
---and view rotation (which is different from the pawn rotation which has a zeroed pitch component).
---A camera first person view will typically use this view point. Most traces (weapon, AI) will be done from this view point.
---@return nil, Vector, Rotator
function Actor.GetActorEyesViewPoint() end

---Get current state of collision for the whole actor
---@return boolean
function Actor.GetActorEnableCollision() end

---Returns the bounding box of all components that make up this Actor (excluding ChildActorComponents).
---@param bOnlyCollidingComponents boolean
---@param bIncludeFromChildActors boolean
---@return nil, Vector, Vector
function Actor.GetActorBounds(bOnlyCollidingComponents, bIncludeFromChildActors) end

---Force actor to be updated to clients/demo net drivers
---@return nil
function Actor.ForceNetUpdate() end

---Forces dormant actor to replicate but doesn't change NetDormancy state (i.e., they will go dormant again if left dormant)
---@return nil
function Actor.FlushNetDormancy() end

---Completes the creation of a new actor component. Called either from blueprint after
---expose on spawn properties are set, or directly from AddComponent
---\@see UK2Node_AddComponent    DO NOT CALL MANUALLY - BLUEPRINT INTERNAL USE ONLY (for Add Component nodes)
---@param Component ActorComponent
---@param bManualAttachment boolean
---@return nil
function Actor.FinishAddComponent(Component, bManualAttachment) end

---Searches components array and returns first encountered component with a given tag.
---@param ComponentClass Class
---@param Tag string
---@return ActorComponent
function Actor.FindComponentByTag(ComponentClass, Tag) end

---Pushes this actor on to the stack of input being handled by a PlayerController.
---@param PlayerController PlayerController
---@return nil
function Actor.EnableInput(PlayerController) end

---Removes this actor from the stack of input being handled by a PlayerController.
---@param PlayerController PlayerController
---@return nil
function Actor.DisableInput(PlayerController) end

---Detach Root Component from Parent
---@param bMaintainWorldPosition boolean
---@return nil
function Actor.DetachRootComponentFromParent(bMaintainWorldPosition) end

---Creates an input component from the input component passed in
---@param InputComponentToCreate Class
---@return nil
function Actor.CreateInputComponent(InputComponentToCreate) end

---Can this body trigger a resimulation when Physics Prediction is enabled
---@return boolean
function Actor.CanTriggerResimulation() end

---Make this actor tick after PrerequisiteComponent. This only applies to this actor's tick function; dependencies for owned components must be set up separately if desired.
---@param PrerequisiteComponent ActorComponent
---@return nil
function Actor.AddTickPrerequisiteComponent(PrerequisiteComponent) end

---Make this actor tick after PrerequisiteActor. This only applies to this actor's tick function; dependencies for owned components must be set up separately if desired.
---@param PrerequisiteActor Actor
---@return nil
function Actor.AddTickPrerequisiteActor(PrerequisiteActor) end

---Creates a new component and assigns ownership to the Actor this is
---called for. Automatic attachment causes the first component created to
---become the root, and all subsequent components to be attached under that
---root. When bManualAttachment is set, automatic attachment is
---skipped and it is up to the user to attach the resulting component (or
---set it up as the root) themselves.
---\@see UK2Node_AddComponentByClass             DO NOT CALL MANUALLY - BLUEPRINT INTERNAL USE ONLY (for Add Component nodes)
---@param Class Class
---@param bManualAttachment boolean
---@param bDeferredFinish boolean
---@return ActorComponent
function Actor.AddComponentByClass(Class, bManualAttachment, bDeferredFinish) end

---Creates a new component and assigns ownership to the Actor this is
---called for. Automatic attachment causes the first component created to
---become the root, and all subsequent components to be attached under that
---root. When bManualAttachment is set, automatic attachment is
---skipped and it is up to the user to attach the resulting component (or
---set it up as the root) themselves.
---\@see UK2Node_AddComponent    DO NOT CALL MANUALLY - BLUEPRINT INTERNAL USE ONLY (for Add Component nodes)
---@param TemplateName string
---@param bManualAttachment boolean
---@param ComponentTemplateContext Object
---@param bDeferredFinish boolean
---@return ActorComponent
function Actor.AddComponent(TemplateName, bManualAttachment, ComponentTemplateContext, bDeferredFinish) end

---See if this actor's Tags array contains the supplied name tag
---@param Tag string
---@return boolean
function Actor.ActorHasTag(Tag) end

return Actor
