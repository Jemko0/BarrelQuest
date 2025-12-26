---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class AnimInstance
---Anim Instance
---
--- Properties
---
---This is used to extract animation. If Mesh exists, this will be overwritten by Mesh->Skeleton
---@field CurrentSkeleton Skeleton
---Sets where this blueprint pulls Root Motion from
---@field RootMotionMode integer
---Allows this anim instance to update its native update, blend tree, montages and asset players on
---a worker thread. This flag is propagated from the UAnimBlueprint to this instance by the compiler.
---The compiler will attempt to pick up any issues that may occur with threaded update.
---For updates to run in multiple threads both this flag and the project setting "Allow Multi Threaded
---Animation Update" should be set.
---@field bUseMultiThreadedAnimationUpdate boolean
---If this AnimInstance has nodes using 'CopyPoseFromMesh' this will be true.
---@field bUsingCopyPoseFromMesh boolean
---Whether to process notifies from any linked anim instances
---@field bReceiveNotifiesFromLinkedInstances boolean
---Whether to propagate notifies to any linked anim instances
---@field bPropagateNotifiesToLinkedInstances boolean
---If true, linked instances will use the main instance's montage data. (i.e. playing a montage on a main instance will play it on the linked layer too.)
---@field bUseMainInstanceMontageEvaluationData boolean
---Called when a montage starts blending out, whether interrupted or finished
---@field OnMontageBlendingOut OnMontageBlendingOutDelegate
---Called when a montage finishes blending in
---@field OnMontageBlendedIn OnMontageBlendedInDelegate
---Called when a montage has started
---@field OnMontageStarted OnMontageStartedDelegate
---Called when a montage has ended, whether interrupted or finished
---@field OnMontageEnded OnMontageEndedDelegate
---Called when all Montage instances have ended.
---@field OnAllMontageInstancesEnded OnAllMontageInstancesEndedDelegate
---Called when a montage section changes
---@field OnMontageSectionChanged OnMontageSectionChangedDelegate
---Inertialization requests gathered this frame. Gets reset in UpdateMontageEvaluationData
---@field SlotGroupInertializationRequestDataMap table<string, InertializationRequest>
---Name of Class to do Post Compile Validation.
---See Class UAnimBlueprintPostCompileValidation.
---@field PostCompileValidationClassName SoftClassPath
---Animation Notifies that has been triggered in the latest tick *
---@field NotifyQueue AnimNotifyQueue
---Currently Active AnimNotifyState, stored as a copy of the event as we need to
---              call NotifyEnd on the event after a deletion in the editor. After this the event
---              is removed correctly.
---@field ActiveAnimNotifyState AnimNotifyEvent[]
---@field ActiveAnimNotifyEventReference AnimNotifyEventReference[]
local AnimInstance = {}

--- Methods
---Get whether a particular notify type was active in a specific state machine last tick.
---@param MachineIndex integer
---@param AnimNotifyType Class
---@return boolean
function AnimInstance.WasAnimNotifyTriggeredInStateMachine(MachineIndex, AnimNotifyType) end

---Get whether the most relevant animation was in a particular notify state last tick.
---@param MachineIndex integer
---@param StateIndex integer
---@param AnimNotifyType Class
---@return boolean
function AnimInstance.WasAnimNotifyTriggeredInSourceState(MachineIndex, StateIndex, AnimNotifyType) end

---Get whether an animation notify of a given type was triggered last tick.
---@param AnimNotifyType Class
---@return boolean
function AnimInstance.WasAnimNotifyTriggeredInAnyState(AnimNotifyType) end

---Get whether a particular notify state is active in a specific state machine last tick.
---@param MachineIndex integer
---@param AnimNotifyStateType Class
---@return boolean
function AnimInstance.WasAnimNotifyStateActiveInStateMachine(MachineIndex, AnimNotifyStateType) end

---Get whether a particular notify state is active in a specific state last tick.
---@param MachineIndex integer
---@param StateIndex integer
---@param AnimNotifyStateType Class
---@return boolean
function AnimInstance.WasAnimNotifyStateActiveInSourceState(MachineIndex, StateIndex, AnimNotifyStateType) end

---Get whether a particular notify state was active in any state machine last tick.
---@param AnimNotifyStateType Class
---@return boolean
function AnimInstance.WasAnimNotifyStateActiveInAnyState(AnimNotifyStateType) end

---Get whether the given state machine triggered the animation notify with the specified name last tick.
---@param MachineIndex integer
---@param NotifyName string
---@return boolean
function AnimInstance.WasAnimNotifyNameTriggeredInStateMachine(MachineIndex, NotifyName) end

---Get whether the most relevant animation triggered the animation notify with the specified name last tick..
---@param MachineIndex integer
---@param StateIndex integer
---@param NotifyName string
---@return boolean
function AnimInstance.WasAnimNotifyNameTriggeredInSourceState(MachineIndex, StateIndex, NotifyName) end

---Get whether the animation notify with the specified name triggered last tick.
---@param NotifyName string
---@return boolean
function AnimInstance.WasAnimNotifyNameTriggeredInAnyState(NotifyName) end

---unlocks indicated AI resources of animated pawn. Will unlock only animation-locked resources.
---    DEPRECATED. Use UnlockAIResourcesWithAnimation instead
---@param bUnlockMovement boolean
---@param UnlockAILogic boolean
---@return nil
function AnimInstance.UnlockAIResources(bUnlockMovement, UnlockAILogic) end

---Runs through all layer nodes, attempting to find layer nodes that are currently running the specified class, then resets each to its default value.
---State sharing rules are as with SetLayerOverlay.
---If InClass is null, does nothing.
---@param InClass Class
---@return nil
function AnimInstance.UnlinkAnimClassLayers(InClass) end

---kismet event functions
---@return Pawn
function AnimInstance.TryGetPawnOwner() end

---Stops currently playing slot animation slot or all
---@param InBlendOutTime number
---@param SlotNodeName string
---@return nil
function AnimInstance.StopSlotAnimation(InBlendOutTime, SlotNodeName) end

---Takes a snapshot of the current skeletal mesh component pose and saves it to the specified snapshot.
---The snapshot is taken at the current LOD, so if for example you took the snapshot at LOD1
---and then used it at LOD0 any bones not in LOD1 will use the reference pose
---@return nil, PoseSnapshot
function AnimInstance.SnapshotPose() end

---Set Use Main Instance Montage Evaluation Data
---@param bSet boolean
---@return nil
function AnimInstance.SetUseMainInstanceMontageEvaluationData(bSet) end

---Set RootMotionMode
---@param Value integer
---@return nil
function AnimInstance.SetRootMotionMode(Value) end

---Set whether to process notifies from any linked anim instances
---@param bSet boolean
---@return nil
function AnimInstance.SetReceiveNotifiesFromLinkedInstances(bSet) end

---Set whether to propagate notifies to any linked anim instances
---@param bSet boolean
---@return nil
function AnimInstance.SetPropagateNotifiesToLinkedInstances(bSet) end

---Sets a morph target to a certain weight.
---@param MorphTargetName string
---@param Value number
---@return nil
function AnimInstance.SetMorphTarget(MorphTargetName, Value) end

---Takes a snapshot of the current skeletal mesh component pose & saves it internally.
---This snapshot can then be retrieved by name in the animation blueprint for blending.
---The snapshot is taken at the current LOD, so if for example you took the snapshot at LOD1 and then used it at LOD0 any bones not in LOD1 will use the reference pose
---@param SnapshotName string
---@return nil
function AnimInstance.SavePoseSnapshot(SnapshotName) end

---Reset any dynamics running simulation-style updates (e.g. on teleport, time skip etc.)
---@param InTeleportType ETeleportType
---@return nil
function AnimInstance.ResetDynamics(InTeleportType) end

---Attempts to queue a transition request, returns true if the request was successful
---@param EventName string
---@param RequestTimeout number
---@param QueueMode ETransitionRequestQueueMode
---@param OverwriteMode ETransitionRequestOverwriteMode
---@return boolean
function AnimInstance.RequestTransitionEvent(EventName, RequestTimeout, QueueMode, OverwriteMode) end

---Requests an inertial blend during the next anim graph update. Requires your anim graph to have a slot node belonging to the specified group name
---@param InSlotGroupName string
---@param Duration number
---@param BlendProfile BlendProfile
---@return nil
function AnimInstance.RequestSlotGroupInertialization(InSlotGroupName, Duration, BlendProfile) end

---Remove a previously saved pose snapshot from the internal snapshot cache
---@param SnapshotName string
---@return nil
function AnimInstance.RemovePoseSnapshot(SnapshotName) end

---Returns whether or not the given event transition request has been queued
---@param MachineIndex integer
---@param TransitionIndex integer
---@param EventName string
---@return boolean
function AnimInstance.QueryTransitionEvent(MachineIndex, TransitionIndex, EventName) end

---Behaves like QueryTransitionEvent but additionally marks the event for consumption
---@param MachineIndex integer
---@param TransitionIndex integer
---@param EventName string
---@return boolean
function AnimInstance.QueryAndMarkTransitionEvent(MachineIndex, TransitionIndex, EventName) end

---Play normal animation asset on the slot node by creating a dynamic UAnimMontage with blend in settings. You can only play one asset (whether montage or animsequence) at a time per SlotGroup.
---@param Asset AnimSequenceBase
---@param SlotNodeName string
---@param InPlayRate number
---@param LoopCount integer
---@param BlendOutTriggerTime number
---@param InTimeToStartMontageAt number
---@return AnimMontage
function AnimInstance.PlaySlotAnimationAsDynamicMontage_WithBlendSettings(Asset, SlotNodeName, InPlayRate, LoopCount, BlendOutTriggerTime, InTimeToStartMontageAt) end

---Play normal animation asset on the slot node by creating a dynamic UAnimMontage with blend in arguments. You can only play one asset (whether montage or animsequence) at a time per SlotGroup.
---@param Asset AnimSequenceBase
---@param SlotNodeName string
---@param InPlayRate number
---@param LoopCount integer
---@param BlendOutTriggerTime number
---@param InTimeToStartMontageAt number
---@return AnimMontage
function AnimInstance.PlaySlotAnimationAsDynamicMontage_WithBlendArgs(Asset, SlotNodeName, InPlayRate, LoopCount, BlendOutTriggerTime, InTimeToStartMontageAt) end

---Play normal animation asset on the slot node by creating a dynamic UAnimMontage. You can only play one asset (whether montage or animsequence) at a time per SlotGroup.
---@param Asset AnimSequenceBase
---@param SlotNodeName string
---@param BlendInTime number
---@param BlendOutTime number
---@param InPlayRate number
---@param LoopCount integer
---@param BlendOutTriggerTime number
---@param InTimeToStartMontageAt number
---@return AnimMontage
function AnimInstance.PlaySlotAnimationAsDynamicMontage(Asset, SlotNodeName, BlendInTime, BlendOutTime, InPlayRate, LoopCount, BlendOutTriggerTime, InTimeToStartMontageAt) end

---Stop following the montage's leader in this anim instance
---@param MontageFollower AnimMontage
---@return nil
function AnimInstance.MontageSync_StopFollowing(MontageFollower) end

---Synchronize a montage to another anim instance's montage. Both montages must be playing already
---@param MontageFollower AnimMontage
---@param OtherAnimInstance AnimInstance
---@param MontageLeader AnimMontage
---@return nil
function AnimInstance.MontageSync_Follow(MontageFollower, OtherAnimInstance, MontageLeader) end

---Same as Montage_Stop, but all blend settings are provided instead of using the ones on the montage asset
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_StopWithBlendSettings(Montage) end

---Same as Montage_Stop. Uses values from the AlphaBlendArgs. Other settings come from the montage asset
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_StopWithBlendOut(Montage) end

---Stops all active montages belonging to a group.
---@param InBlendOutTime number
---@param GroupName string
---@return nil
function AnimInstance.Montage_StopGroupByName(InBlendOutTime, GroupName) end

---Stopped montages will blend out using their montage asset's BlendOut, with InBlendOutTime as the BlendTime
---@param InBlendOutTime number
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_Stop(InBlendOutTime, Montage) end

---Set position.
---@param Montage AnimMontage
---@param NewPosition number
---@return nil
function AnimInstance.Montage_SetPosition(Montage, NewPosition) end

---Change AnimMontage play rate. NewPlayRate = 1.0 is the default playback rate.
---@param Montage AnimMontage
---@param NewPlayRate number
---@return nil
function AnimInstance.Montage_SetPlayRate(Montage, NewPlayRate) end

---Relink new next section AFTER SectionNameToChange in run-time
---    You can link section order the way you like in editor, but in run-time if you'd like to change it dynamically,
---    use this function to relink the next section
---    For example, you can have Start->Loop->Loop->Loop.... but when you want it to end, you can relink
---    next section of Loop to be End to finish the montage, in which case, it stops looping by Loop->End.
---@param SectionNameToChange string
---@param NextSection string
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_SetNextSection(SectionNameToChange, NextSection, Montage) end

---Resumes a paused animation montage. If reference is NULL, it will resume ALL active montages.
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_Resume(Montage) end

---Plays an animation montage. Same as Montage_Play, but you can overwrite all of the montage's default blend in settings.
---@param MontageToPlay AnimMontage
---@param InPlayRate number
---@param ReturnValueType EMontagePlayReturnType
---@param InTimeToStartMontageAt number
---@param bStopAllMontages boolean
---@return number
function AnimInstance.Montage_PlayWithBlendSettings(MontageToPlay, InPlayRate, ReturnValueType, InTimeToStartMontageAt, bStopAllMontages) end

---Plays an animation montage. Same as Montage_Play, but you can specify an AlphaBlend for Blend In settings.
---@param MontageToPlay AnimMontage
---@param InPlayRate number
---@param ReturnValueType EMontagePlayReturnType
---@param InTimeToStartMontageAt number
---@param bStopAllMontages boolean
---@return number
function AnimInstance.Montage_PlayWithBlendIn(MontageToPlay, InPlayRate, ReturnValueType, InTimeToStartMontageAt, bStopAllMontages) end

---Plays an animation montage. Returns the length of the animation montage in seconds. Returns 0.f if failed to play.
---@param MontageToPlay AnimMontage
---@param InPlayRate number
---@param ReturnValueType EMontagePlayReturnType
---@param InTimeToStartMontageAt number
---@param bStopAllMontages boolean
---@return number
function AnimInstance.Montage_Play(MontageToPlay, InPlayRate, ReturnValueType, InTimeToStartMontageAt, bStopAllMontages) end

---Pauses the animation montage. If reference is NULL, it will pause ALL active montages.
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_Pause(Montage) end

---Makes a montage jump to the end of a named section. If Montage reference is NULL, it will do that to all active montages.
---@param SectionName string
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_JumpToSectionsEnd(SectionName, Montage) end

---Makes a montage jump to a named section. If Montage reference is NULL, it will do that to all active montages.
---@param SectionName string
---@param Montage AnimMontage
---@return nil
function AnimInstance.Montage_JumpToSection(SectionName, Montage) end

---Returns true if the animation montage is currently active and playing.
---      If reference is NULL, it will return true is ANY montage is currently active and playing.
---@param Montage AnimMontage
---@return boolean
function AnimInstance.Montage_IsPlaying(Montage) end

---Returns true if the animation montage is active. If the Montage reference is NULL, it will return true if any Montage is active.
---@param Montage AnimMontage
---@return boolean
function AnimInstance.Montage_IsActive(Montage) end

---Get Current Montage Position
---@param Montage AnimMontage
---@return number
function AnimInstance.Montage_GetPosition(Montage) end

---Get PlayRate for Montage. This does not account for RateScale, so it may not reflect the actual play rate seen in game (see Montage_GetEffectivePlayRate).
---      If Montage reference is NULL, PlayRate for any Active Montage will be returned.
---      If Montage is not playing, 0 is returned.
---@param Montage AnimMontage
---@return number
function AnimInstance.Montage_GetPlayRate(Montage) end

---return true if Montage is not currently active. (not valid or blending out)
---@param Montage AnimMontage
---@return boolean
function AnimInstance.Montage_GetIsStopped(Montage) end

---Get scaled PlayRate for Montage. This accounts for RateScale, so it will reflect the actual play rate seen in game.
---      If Montage reference is NULL, scaled PlayRate for any Active Montage will be returned.
---      If Montage is not playing, 0 is returned.
---@param Montage AnimMontage
---@return number
function AnimInstance.Montage_GetEffectivePlayRate(Montage) end

---Returns the name of the current animation montage section.
---@param Montage AnimMontage
---@return string
function AnimInstance.Montage_GetCurrentSection(Montage) end

---Get the current blend time of the Montage.
---      If Montage reference is NULL, it will return the current blend time on the first active Montage found.
---@param Montage AnimMontage
---@return number
function AnimInstance.Montage_GetBlendTime(Montage) end

---locks indicated AI resources of animated pawn
---    DEPRECATED. Use LockAIResourcesWithAnimation instead
---@param bLockMovement boolean
---@param LockAILogic boolean
---@return nil
function AnimInstance.LockAIResources(bLockMovement, LockAILogic) end

---Runs through all nodes, attempting to find a linked instance by name/tag, then sets the class of each node if the tag matches
---@param InTag string
---@param InClass Class
---@return nil
function AnimInstance.LinkAnimGraphByTag(InTag, InClass) end

---Runs through all layer nodes, attempting to find layer nodes that are implemented by the specified class, then sets up a linked instance of the class for each.
---Allocates one linked instance to run each of the groups specified in the class, so state is shared. If a layer is not grouped (ie. NAME_None), then state is not shared
---and a separate linked instance is allocated for each layer node.
---If InClass is null, then all layers are reset to their defaults.
---@param InClass Class
---@return nil
function AnimInstance.LinkAnimClassLayers(InClass) end

---Is Using Main Instance Montage Evaluation Data
---@return boolean
function AnimInstance.IsUsingMainInstanceMontageEvaluationData() end

---Is Sync Group Between Markers
---@param InSyncGroupName string
---@param PreviousMarker string
---@param NextMarker string
---@param bRespectMarkerOrder boolean
---@return boolean
function AnimInstance.IsSyncGroupBetweenMarkers(InSyncGroupName, PreviousMarker, NextMarker, bRespectMarkerOrder) end

---Return true if this instance has an active montage in the given slot. A UAnimMontage that is playing in the slot and blending out is not determined to be "active".
---@param SlotNodeName string
---@return boolean
function AnimInstance.IsSlotActive(SlotNodeName) end

---Return true if it's playing the slot animation
---@param Asset AnimSequenceBase
---@param SlotNodeName string
---@return boolean
function AnimInstance.IsPlayingSlotAnimation(Asset, SlotNodeName) end

---Returns true if any montage is playing currently. Doesn't mean it's active though, it could be blending out.
---@return boolean
function AnimInstance.IsAnyMontagePlaying() end

---Has Marker Been Hit This Frame
---@param SyncGroup string
---@param MarkerName string
---@return boolean
function AnimInstance.HasMarkerBeenHitThisFrame(SyncGroup, MarkerName) end

------ AI communication end ---
---@param SyncGroup string
---@param MarkerName string
---@return boolean
function AnimInstance.GetTimeToClosestMarker(SyncGroup, MarkerName) end

---Get Sync Group Position
---@param InSyncGroupName string
---@return MarkerSyncAnimPosition
function AnimInstance.GetSyncGroupPosition(InSyncGroupName) end

---Get the time remaining as a fraction of the duration for the most relevant animation in the source state
---@param MachineIndex integer
---@param StateIndex integer
---@return number
function AnimInstance.GetRelevantAnimTimeRemainingFraction(MachineIndex, StateIndex) end

---Get the time remaining in seconds for the most relevant animation in the source state
---@param MachineIndex integer
---@param StateIndex integer
---@return number
function AnimInstance.GetRelevantAnimTimeRemaining(MachineIndex, StateIndex) end

---Get the current accumulated time as a fraction of the length of the most relevant animation in the source state
---@param MachineIndex integer
---@param StateIndex integer
---@return number
function AnimInstance.GetRelevantAnimTimeFraction(MachineIndex, StateIndex) end

---Get the current accumulated time in seconds for the most relevant animation in the source state
---@param MachineIndex integer
---@param StateIndex integer
---@return number
function AnimInstance.GetRelevantAnimTime(MachineIndex, StateIndex) end

---Get the length in seconds of the most relevant animation in the source state
---@param MachineIndex integer
---@param StateIndex integer
---@return number
function AnimInstance.GetRelevantAnimLength(MachineIndex, StateIndex) end

---Get whether to process notifies from any linked anim instances
---@return boolean
function AnimInstance.GetReceiveNotifiesFromLinkedInstances() end

---Get whether to propagate notifies to any linked anim instances
---@return boolean
function AnimInstance.GetPropagateNotifiesToLinkedInstances() end

---Returns the skeletal mesh component that has created this AnimInstance
---@return SkeletalMeshComponent
function AnimInstance.GetOwningComponent() end

---Returns the owning actor of this AnimInstance
---@return Actor
function AnimInstance.GetOwningActor() end

---Runs through all nodes, attempting to find all distinct layer linked instances in the group
---@param InGroup string
---@return nil, AnimInstance[]
function AnimInstance.GetLinkedAnimLayerInstancesByGroup(InGroup) end

---Gets layer linked instance that matches group and class
---@param InGroup string
---@param InClass Class
---@return AnimInstance
function AnimInstance.GetLinkedAnimLayerInstanceByGroupAndClass(InGroup, InClass) end

---Gets the layer linked instance corresponding to the specified group
---@param InGroup string
---@return AnimInstance
function AnimInstance.GetLinkedAnimLayerInstanceByGroup(InGroup) end

---Gets the first layer linked instance corresponding to the specified class, optionally if bCheckForChildClass is true, it will check IsChildOf on InClass.
---@param InClass Class
---@param bCheckForChildClass boolean
---@return AnimInstance
function AnimInstance.GetLinkedAnimLayerInstanceByClass(InClass, bCheckForChildClass) end

---Get Linked Anim Graph Instances by Tag
---@param InTag string
---@return nil, AnimInstance[]
function AnimInstance.GetLinkedAnimGraphInstancesByTag(InTag) end

---Runs through all nodes, attempting to find the first linked instance by name/tag
---@param InTag string
---@return AnimInstance
function AnimInstance.GetLinkedAnimGraphInstanceByTag(InTag) end

---Get the elapsed time as a fraction of the crossfade duration of a specified transition
---@param MachineIndex integer
---@param TransitionIndex integer
---@return number
function AnimInstance.GetInstanceTransitionTimeElapsedFraction(MachineIndex, TransitionIndex) end

---Get the elapsed time in seconds of a specified transition
---@param MachineIndex integer
---@param TransitionIndex integer
---@return number
function AnimInstance.GetInstanceTransitionTimeElapsed(MachineIndex, TransitionIndex) end

---Get the crossfade duration of a specified transition
---@param MachineIndex integer
---@param TransitionIndex integer
---@return number
function AnimInstance.GetInstanceTransitionCrossfadeDuration(MachineIndex, TransitionIndex) end

---Get the blend weight of a specified state
---@param MachineIndex integer
---@param StateIndex integer
---@return number
function AnimInstance.GetInstanceStateWeight(MachineIndex, StateIndex) end

---Get the blend weight of a specified state machine
---@param MachineIndex integer
---@return number
function AnimInstance.GetInstanceMachineWeight(MachineIndex) end

---Get the current elapsed time of a state within the specified state machine
---@param MachineIndex integer
---@return number
function AnimInstance.GetInstanceCurrentStateElapsedTime(MachineIndex) end

---Get the time as a fraction of the asset length of an animation in an asset player node
---@param AssetPlayerIndex integer
---@return number
function AnimInstance.GetInstanceAssetPlayerTimeFromEndFraction(AssetPlayerIndex) end

---Get the time in seconds from the end of an animation in an asset player node
---@param AssetPlayerIndex integer
---@return number
function AnimInstance.GetInstanceAssetPlayerTimeFromEnd(AssetPlayerIndex) end

---Get the current accumulated time as a fraction for an asset player node
---@param AssetPlayerIndex integer
---@return number
function AnimInstance.GetInstanceAssetPlayerTimeFraction(AssetPlayerIndex) end

---Get the current accumulated time in seconds for an asset player node
---@param AssetPlayerIndex integer
---@return number
function AnimInstance.GetInstanceAssetPlayerTime(AssetPlayerIndex) end

---Gets the length in seconds of the asset referenced in an asset player node
---@param AssetPlayerIndex integer
---@return number
function AnimInstance.GetInstanceAssetPlayerLength(AssetPlayerIndex) end

---Get the current delta time
---@return number
function AnimInstance.GetDeltaSeconds() end

---Returns whether a named curve was found, its value, and a default value when it's not found.
---@param CurveName string
---@param DefaultValue number
---@return boolean
function AnimInstance.GetCurveValueWithDefault(CurveName, DefaultValue) end

---Returns the value of a named curve.
---@param CurveName string
---@return number
function AnimInstance.GetCurveValue(CurveName) end

---Returns the name of a currently active state in a state machine.
---@param MachineIndex integer
---@return string
function AnimInstance.GetCurrentStateName(MachineIndex) end

---Get a current Active Montage in this AnimInstance.
---              Note that there might be multiple Active at the same time. This will only return the first active one it finds. *
---@return AnimMontage
function AnimInstance.GetCurrentActiveMontage() end

---Returns a blend profile by name from our current skeleton. Null if not found.
---@param InBlendProfileName string
---@return BlendProfile
function AnimInstance.GetBlendProfileByName(InBlendProfileName) end

---This returns all curve names. This is the same as calling GetActiveCurveNames with CurveType == AttributeCurve
---@return nil, string[]
function AnimInstance.GetAllCurveNames() end

---This returns last up-to-date list of active curve names
---@param CurveType EAnimCurveType
---@return nil, string[]
function AnimInstance.GetActiveCurveNames(CurveType) end

---Returns true if there is an animation montage is currently active and playing that was created from the provided animation.
---@param Animation AnimSequenceBase
---@return boolean
function AnimInstance.DynamicMontage_IsPlayingFrom(Animation) end

---Removes all queued transition requests with the given event name
---@param EventName string
---@return nil
function AnimInstance.ClearTransitionEvents(EventName) end

---Clears the current morph targets.
---@return nil
function AnimInstance.ClearMorphTargets() end

---Removes all queued transition requests
---@return nil
function AnimInstance.ClearAllTransitionEvents() end

---Calculate Direction
---@return number
function AnimInstance.CalculateDirection() end

---Get local weight of any montages this slot node is playing. If this slot is not currently playing a montage, it will return 0.
---@param SlotNodeName string
---@return number
function AnimInstance.Blueprint_GetSlotMontageLocalWeight(SlotNodeName) end

---Get the 'main' anim instance, i.e. the one that is hosted on the skeletal mesh component
---@return AnimInstance
function AnimInstance.Blueprint_GetMainAnimInstance() end

return AnimInstance
