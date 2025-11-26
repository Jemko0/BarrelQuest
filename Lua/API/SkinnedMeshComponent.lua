---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SkinnedMeshComponent : MeshComponent
---Skinned mesh component that supports bone skinned mesh rendering.
---This class does not support animation.
---@see USkeletalMeshComponent
---
--- Properties
---
---@field SkeletalMesh SkeletalMesh
---If set, this SkeletalMeshComponent will not use its SpaceBase for bone transform, but will
---use the component space transforms from the LeaderPoseComponent. This is used when constructing a character using multiple skeletal meshes sharing the same
---skeleton within the same Actor.
---@field LeaderPoseComponent any
---How this Component's LOD uses the skin cache feature. Auto will defer to the asset's (SkeletalMesh) option. If Ray Tracing is enabled, will imply Enabled
---@field SkinCacheUsage ESkinCacheUsage[]
---If true, MeshDeformer will be used. If false, use the default mesh deformer on the SkeletalMesh.
---@field bSetMeshDeformer boolean
---The mesh deformer to use. Set to None to disable the deformer on the SkeletalMesh. If no deformer is set from here or the SkeletalMesh, we fall back to the fixed function deformation, unless AlwaysUseMeshDeformer is on.
---@field MeshDeformer MeshDeformer
---If true, and if no mesh deformer is set from here or the SkeletalMesh, fall back to the default deformer specified in the project settings, unless DefaultMode is set to "Never" in project settings
---@field bAlwaysUseMeshDeformer boolean
---Object containing instance settings for the bound MeshDeformer.
---@field MeshDeformerInstanceSettings MeshDeformerInstanceSettings
---@field MeshDeformerInstance MeshDeformerInstance
---Object containing state for the bound MeshDeformer.
---@field MeshDeformerInstances MeshDeformerInstanceSet
---Wireframe color
---@field WireframeColor Color
---PhysicsAsset is set in SkeletalMesh by default, but you can override with this value
---@field PhysicsAssetOverride PhysicsAsset
---@field ForcedLodModel integer
---This is the min LOD that this component will use.  (e.g. if set to 2 then only 2+ LOD Models will be used.) This is useful to set on
---meshes which are known to be a certain distance away and still want to have better LODs when zoomed in on them.
---@field MinLodModel integer
---Allows adjusting the desired streaming distance of streaming textures that uses UV 0.
---1.0 is the default, whereas a higher value makes the textures stream in sooner from far away.
---A lower value (0.0-1.0) makes the textures stream in later (you have to be closer).
---Value can be < 0 (from legcay content, or code changes)
---@field StreamingDistanceMultiplier number
---LOD array info. Each index will correspond to the LOD index *
---@field LODInfo SkelMeshComponentLODInfo[]
---* This is tick animation frequency option based on this component rendered or not or using montage
---*  You can change this default value in the INI file
---* Mostly related with performance
---@field VisibilityBasedAnimTickOption EVisibilityBasedAnimTickOption
---Whether we should use the min lod specified in MinLodModel for this component instead of the min lod in the mesh
---@field bOverrideMinLod boolean
---When true, we will just using the bounds from our LeaderPoseComponent.  This is useful for when we have a Mesh Parented
---to the main SkelMesh (e.g. outline mesh or a full body overdraw effect that is toggled) that is always going to be the same
---bounds as parent.  We want to do no calculations in that case.
---@field bUseBoundsFromLeaderPoseComponent boolean
---If true, the Location of this Component will be included into its bounds calculation
---(this can be useful when using SMU_OnlyTickPoseWhenRendered on a character that moves away from the root and no bones are left near the origin of the component)
---@field bIncludeComponentLocationIntoBounds boolean
---Forces the mesh to draw in wireframe mode.
---@field bForceWireframe boolean
---Draw the skeleton hierarchy for this skel mesh.
---@field bDisplayBones boolean
---Disable Morphtarget for this component.
---@field bDisableMorphTarget boolean
---Don't bother rendering the skin.
---@field bHideSkin boolean
---If true, use per-bone motion blur on this skeletal mesh (requires additional rendering, can be disabled to save performance).
---@field bPerBoneMotionBlur boolean
---When true, skip using the physics asset etc. and always use the fixed bounds defined in the SkeletalMesh.
---@field bComponentUseFixedSkelBounds boolean
---If true, when updating bounds from a PhysicsAsset, consider _all_ BodySetups, not just those flagged with bConsiderForBounds.
---@field bConsiderAllBodiesForBounds boolean
---If true, this component uses its parents LOD when attached if available
---ForcedLOD can override this change. By default, it will use parent LOD.
---@field bSyncAttachParentLOD boolean
---Whether or not we can highlight selected sections - this should really only be done in the editor
---@field bCanHighlightSelectedSections boolean
---true if mesh has been recently rendered, false otherwise
---@field bRecentlyRendered boolean
---Whether to use the capsule representation (when present) from a skeletal mesh's ShadowPhysicsAsset for direct shadowing from lights.
---This type of shadowing is approximate but handles extremely wide area shadowing well.  The softness of the shadow depends on the light's LightSourceAngle / SourceRadius.
---This flag will force bCastInsetShadow to be enabled. This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to FirstPerson.
---@field bCastCapsuleDirectShadow boolean
---Whether to use the capsule representation (when present) from a skeletal mesh's ShadowPhysicsAsset for shadowing indirect lighting (from lightmaps or skylight).
---This flag is only used if CastShadow is true and if FirstPersonPrimitiveType is not set to FirstPerson.
---@field bCastCapsuleIndirectShadow boolean
---@field bCPUSkinning boolean
---If set, use the screen render flag instead of the default render flag when processing offscreen-rendering optimizations
---(such as VisibilityBasedAnimTickOption) that look to reduce animation work when the mesh is not rendered.
---Using this option can result in meshes that are occlusion culled ceasing to perform animation work.
---Note that this can however result in shadows not being animated when meshes are not directly visible.
---@field bUseScreenRenderStateForUpdate boolean
---if TRUE, Owner will determine how often animation will be updated and evaluated. See AnimUpdateRateTick()
---This allows to skip frames for performance. (For example based on visibility and size on screen).
---@field bEnableUpdateRateOptimizations boolean
---Enable on screen debugging of update rate optimization.
---Red = Skipping 0 frames, Green = skipping 1 frame, Blue = skipping 2 frames, black = skipping more than 2 frames.
---@todo: turn this into a console command.
---@field bDisplayDebugUpdateRateOptimizations boolean
---If true, render as static in reference pose.
---@field bRenderStatic boolean
---Flag that when set will ensure UpdateLODStatus will not take the LeaderPoseComponent's current LOD in consideration when determining the correct LOD level (this requires LeaderPoseComponent's LOD to always be >= determined LOD otherwise bone transforms could be missing
---@field bIgnoreLeaderPoseComponentLOD boolean
---Enable dynamic sort mesh's triangles to remove ordering issue when rendered with a translucent material
---@field bSortTriangles boolean
---true when CachedLocalBounds is up to date.
---@field bCachedLocalBoundsUpToDate boolean
---@field bCachedWorldSpaceBoundsUpToDate boolean
---If false, Follower components ShouldTickPose function will return false (default)
---@field bFollowerShouldTickPose boolean
---Controls how dark the capsule indirect shadow can be.
---@field CapsuleIndirectShadowMinVisibility number
---Bounds cached, so they're computed just once, either in local or worldspace depending on cvar 'a.CacheLocalSpaceBounds'.
---@field CachedWorldOrLocalSpaceBounds BoxSphereBounds
---@field CachedWorldToLocalTransform Matrix
local SkinnedMeshComponent = {}

--- Methods
---Unset any MeshDeformer applied to this Component.
---@return nil
function SkinnedMeshComponent.UnsetMeshDeformer() end

---Unload a Skin Weight Profile's skin weight buffer (if created)
---@param InProfileName string
---@return nil
function SkinnedMeshComponent.UnloadSkinWeightProfile(InProfileName) end

---UnHide the specified bone with name.  Currently this just enforces a scale of 0 for the hidden bones.
---Compared to HideBone By Index - This keeps track of list of bones and update when LOD changes
---@param BoneName string
---@return nil
function SkinnedMeshComponent.UnHideBoneByName(BoneName) end

---Transform a location/rotation from world space to bone relative space.
---This is handy if you know the location in world space for a bone attachment, as AttachComponent takes location/rotation in bone-relative space.
---@param BoneName string
---@param InPosition Vector
---@param InRotation Rotator
---@return nil, Vector, Rotator
function SkinnedMeshComponent.TransformToBoneSpace(BoneName, InPosition, InRotation) end

---Transform a location/rotation in bone relative space to world space.
---@param BoneName string
---@param InPosition Vector
---@param InRotation Rotator
---@return nil, Vector, Rotator
function SkinnedMeshComponent.TransformFromBoneSpace(BoneName, InPosition, InRotation) end

---Allows hiding of a particular material (by ID) on this instance of a SkeletalMesh.
---@param MaterialID integer
---@param SectionIndex integer
---@param bShow boolean
---@param LODIndex integer
---@return nil
function SkinnedMeshComponent.ShowMaterialSection(MaterialID, SectionIndex, bShow, LODIndex) end

---Clear any material visibility modifications made by ShowMaterialSection
---@param LODIndex integer
---@return nil
function SkinnedMeshComponent.ShowAllMaterialSections(LODIndex) end

---Allow override of vertex colors on a per-component basis, taking array of Blueprint-friendly LinearColors.
---@param LODIndex integer
---@return nil
function SkinnedMeshComponent.SetVertexColorOverride_LinearColor(LODIndex) end

---Set up an override skin weight profile for this component on the given layer.
---The values from the secondary layer (if set to have a profile) are applied first, followed by the values from the primary layer.
---Since skin weight profiles are stored as sparse data, where only weight values different from the base are kept in storage, it's
---possible to set up layers such that they don't interfere with one another.
---@param InProfileName string
---@param InLayer ESkinWeightProfileLayer
---@return boolean
function SkinnedMeshComponent.SetSkinWeightProfile(InProfileName, InLayer) end

---Allow override of skin weights on a per-component basis.
---@param LODIndex integer
---@return nil
function SkinnedMeshComponent.SetSkinWeightOverride(LODIndex) end

---Change the SkinnedAsset that is rendered for this Component. Will re-initialize the animation tree etc.
---@param NewMesh SkinnedAsset
---@param bReinitPose boolean
---@return nil
function SkinnedMeshComponent.SetSkinnedAssetAndUpdate(NewMesh, bReinitPose) end

---Set whether this skinned mesh should be rendered as static mesh in a reference pose
---@param bNewValue boolean
---@return nil
function SkinnedMeshComponent.SetRenderStatic(bNewValue) end

---Override the Physics Asset of the mesh. It uses SkeletalMesh.PhysicsAsset, but if you'd like to override use this function
---@param NewPhysicsAsset PhysicsAsset
---@param bForceReInit boolean
---@return nil
function SkinnedMeshComponent.SetPhysicsAsset(NewPhysicsAsset, bForceReInit) end

---Set Min LOD
---@param InNewMinLOD integer
---@return nil
function SkinnedMeshComponent.SetMinLOD(InNewMinLOD) end

---Change the MeshDeformer that is used for this Component.
---@param InMeshDeformer MeshDeformer
---@return nil
function SkinnedMeshComponent.SetMeshDeformer(InMeshDeformer) end

---Set LeaderPoseComponent for this component
---@param NewLeaderBoneComponent SkinnedMeshComponent
---@param bForceUpdate boolean
---@param bInFollowerShouldTickPose boolean
---@return nil
function SkinnedMeshComponent.SetLeaderPoseComponent(NewLeaderBoneComponent, bForceUpdate, bInFollowerShouldTickPose) end

---Set ForcedLodModel of the mesh component
---@param InNewForcedLOD integer
---@return nil
function SkinnedMeshComponent.SetForcedLOD(InNewForcedLOD) end

---Set Cast Capsule Indirect Shadow
---@param bNewValue boolean
---@return nil
function SkinnedMeshComponent.SetCastCapsuleIndirectShadow(bNewValue) end

---Set Cast Capsule Direct Shadow
---@param bNewValue boolean
---@return nil
function SkinnedMeshComponent.SetCastCapsuleDirectShadow(bNewValue) end

---Set Capsule Indirect Shadow Min Visibility
---@param NewValue number
---@return nil
function SkinnedMeshComponent.SetCapsuleIndirectShadowMinVisibility(NewValue) end

---Always use a MeshDeformer as long as one can be found in the project settings
---@param bShouldAlwaysUseMeshDeformer boolean
---@return nil
function SkinnedMeshComponent.SetAlwaysUseMeshDeformer(bShouldAlwaysUseMeshDeformer) end

---Override the Min LOD of the mesh component
---@param InNewMinLOD integer
---@return nil
function SkinnedMeshComponent.OverrideMinLOD(InNewMinLOD) end

---Check whether a skin weight profile is currently set on any layer.
---@return boolean
function SkinnedMeshComponent.IsUsingSkinWeightProfile() end

---Returns whether a specific material section is currently hidden on this component (by using ShowMaterialSection)
---@param MaterialID integer
---@param LODIndex integer
---@return boolean
function SkinnedMeshComponent.IsMaterialSectionShown(MaterialID, LODIndex) end

---Determines if the specified bone is hidden.
---@param BoneName string
---@return boolean
function SkinnedMeshComponent.IsBoneHiddenByName(BoneName) end

---Hides the specified bone with name.  Currently this just enforces a scale of 0 for the hidden bones.
---Compared to HideBone By Index - This keeps track of list of bones and update when LOD changes
---@param BoneName string
---@param PhysBodyOption integer
---@return nil
function SkinnedMeshComponent.HideBoneByName(BoneName, PhysBodyOption) end

---Get Twist and Swing Angle in Degree of Delta Rotation from Reference Pose in Local space
---First this function gets rotation of current, and rotation of ref pose in local space, and
---And gets twist/swing angle value from refpose aligned.
---@param BoneName string
---@return boolean
function SkinnedMeshComponent.GetTwistAndSwingAngleOfDeltaRotationFromRefPose(BoneName) end

---Returns bone name linked to a given named socket on the skeletal mesh component.
---If you're unsure to deal with sockets or bones names, you can use this function to filter through, and always return the bone name.
---@param InSocketName string
---@return string
function SkinnedMeshComponent.GetSocketBoneName(InSocketName) end

---Get the SkinnedAsset rendered for this mesh.
---@return SkinnedAsset
function SkinnedMeshComponent.GetSkinnedAsset() end

---Get Skeletal Mesh DEPRECATED
---@return SkeletalMesh
function SkinnedMeshComponent.GetSkeletalMesh_DEPRECATED() end

---Gets the local-space transform of a bone in the reference pose.
---@param BoneIndex integer
---@return Transform
function SkinnedMeshComponent.GetRefPoseTransform(BoneIndex) end

---Gets the local-space position of a bone in the reference pose.
---@param BoneIndex integer
---@return Vector
function SkinnedMeshComponent.GetRefPosePosition(BoneIndex) end

---Get predicted LOD level. This value is usually calculated in UpdateLODStatus, but can be modified by skeletal mesh streaming.
---@return integer
function SkinnedMeshComponent.GetPredictedLODLevel() end

---Get Parent Bone of the input bone
---@param BoneName string
---@return string
function SkinnedMeshComponent.GetParentBone(BoneName) end

---Get the number of LODs on this component
---@return integer
function SkinnedMeshComponent.GetNumLODs() end

---Returns the number of bones in the skeleton.
---@return integer
function SkinnedMeshComponent.GetNumBones() end

---Get Mesh Deformer Instance
---@return MeshDeformerInstance
function SkinnedMeshComponent.GetMeshDeformerInstance() end

---Get ForcedLodModel of the mesh component. Note that the actual forced LOD level is the return value minus one and zero means no forced LOD
---@return integer
function SkinnedMeshComponent.GetForcedLOD() end

---Get delta transform from reference pose based on BaseNode.
---This uses last frame up-to-date transform, so it will have a frame delay if you use this info in the AnimGraph
---@param BoneName string
---@param BaseName string
---@return Transform
function SkinnedMeshComponent.GetDeltaTransformFromRefPose(BoneName, BaseName) end

---Return the name of the skin weight profile that is currently set on the given layer, otherwise returns 'None'
---@param InLayer ESkinWeightProfileLayer
---@return string
function SkinnedMeshComponent.GetCurrentSkinWeightProfileName(InLayer) end

---Return the names of the skin weight profiles for all the layers
---@return string[]
function SkinnedMeshComponent.GetCurrentSkinWeightProfileLayerNames() end

---Get world-space bone transform.
---@param InBoneName string
---@param TransformSpace integer
---@return Transform
function SkinnedMeshComponent.GetBoneTransform(InBoneName, TransformSpace) end

---Get Bone Name from index
---@param BoneIndex integer
---@return string
function SkinnedMeshComponent.GetBoneName(BoneIndex) end

---Find the index of bone by name. Looks in the current SkeletalMesh being used by this SkeletalMeshComponent.
---\@see USkeletalMesh::GetBoneIndex.
---@param BoneName string
---@return integer
function SkinnedMeshComponent.GetBoneIndex(BoneName) end

---Returns whether the component is set to always use a mesh deformer if one can be found in the project settings
---@return boolean
function SkinnedMeshComponent.GetAlwaysUseMeshDeformer() end

---finds the closest bone to the given location
---@param TestLocation Vector
---@param IgnoreScale number
---@param bRequirePhysicsAsset boolean
---@return string
function SkinnedMeshComponent.FindClosestBone_K2(TestLocation, IgnoreScale, bRequirePhysicsAsset) end

---Clear any applied vertex color override
---@param LODIndex integer
---@return nil
function SkinnedMeshComponent.ClearVertexColorOverride(LODIndex) end

---Clear the skin weight profile from the given layer on this component, in case it is set. If no profile is set for the layer,
---then this call does nothing.
---@param InLayer ESkinWeightProfileLayer
---@return nil
function SkinnedMeshComponent.ClearSkinWeightProfile(InLayer) end

---Clear any applied skin weight override
---@param LODIndex integer
---@return nil
function SkinnedMeshComponent.ClearSkinWeightOverride(LODIndex) end

---Clear the skin Weight Profile from all layers on this component. If no profiles are set for any layer, then this call does nothing.
---@return nil
function SkinnedMeshComponent.ClearAllSkinWeightProfiles() end

---Tests if BoneName is child of (or equal to) ParentBoneName.
---Note - will return false if ChildBoneIndex is the same as ParentBoneIndex ie. must be strictly a child.
---@param BoneName string
---@param ParentBoneName string
---@return boolean
function SkinnedMeshComponent.BoneIsChildOf(BoneName, ParentBoneName) end

return SkinnedMeshComponent
