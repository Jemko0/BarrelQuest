---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SkeletalMesh : SkinnedAsset
---SkeletalMesh is geometry bound to a hierarchical skeleton of bones which can be animated for the purpose of deforming the mesh.
---Skeletal Meshes are built up of two parts; a set of polygons composed to make up the surface of the mesh, and a hierarchical skeleton which can be used to animate the polygons.
---The 3D models, rigging, and animations are created in an external modeling and animation application (3DSMax, Maya, Softimage, etc).
---@see https://docs.unrealengine.com/latest/INT/Engine/Content/Types/SkeletalMeshes/
---
--- Properties
---
---@field Skeleton Skeleton
---@field PositiveBoundsExtension Vector
---@field NegativeBoundsExtension Vector
---@field Materials SkeletalMaterial[]
---@field SkelMirrorTable BoneMirrorInfo[]
---Settings related to building Nanite data.
---@field NaniteSettings MeshNaniteSettings
---@field MinQualityLevelLOD PerQualityLevelInt
---@field MinLod PerPlatformInt
---@field DisableBelowMinLodStripping PerPlatformBool
---@field bOverrideLODStreamingSettings boolean
---@field bSupportLODStreaming PerPlatformBool
---@field MaxNumStreamedLODs PerPlatformInt
---@field MaxNumOptionalLODs PerPlatformInt
---@field LODSettings SkeletalMeshLODSettings
---@field DefaultAnimatingRig any
---@field SkelMirrorAxis integer
---@field SkelMirrorFlipAxis integer
---If true, use 32 bit UVs. If false, use 16 bit UVs to save memory
---@field bUseFullPrecisionUVs boolean
---If true, tangents will be stored at 16 bit vs 8 bit precision
---@field bUseHighPrecisionTangentBasis boolean
---@field bHasVertexColors boolean
---@field bEnablePerPolyCollision boolean
---@field VertexColorGuid Guid
---@field BodySetup BodySetup
---@field PhysicsAsset PhysicsAsset
---@field ShadowPhysicsAsset PhysicsAsset
---@field NodeMappingData NodeMappingContainer[]
---@field AssetImportData AssetImportData
---Path to the resource used to construct this skeletal mesh
---@field SourceFilePath string
---Date/Time-stamp of the file from the last import
---@field SourceFileTimestamp string
---@field ThumbnailInfo ThumbnailInfo
---@field bHasCustomDefaultEditorCamera boolean
---@field DefaultEditorCameraLocation Vector
---@field DefaultEditorCameraRotation Rotator
---@field DefaultEditorCameraLookAt Vector
---@field DefaultEditorCameraOrthoZoom number
---@field PreviewAttachedAssetContainer PreviewAssetAttachContainer
---@field bSupportRayTracing boolean
---@field RayTracingMinLOD integer
---@field ClothLODBiasMode EClothLODBiasMode
---@field MorphTargets MorphTarget[]
---@field FloorOffset number
---Legacy clothing asset data, will be converted to new assets after loading
---@field ClothingAssets ClothingAssetData_Legacy[]
---The visual size of the bones in the viewport (saved between sessions). This is set from the viewport Character>Bones menu
---@field BoneDrawSize number
---@field PostProcessAnimBlueprint Class
---@field MeshClothingAssets ClothingAssetBase[]
---@field SamplingInfo SkeletalMeshSamplingInfo
---Array of user data stored with the asset
---@field AssetUserData AssetUserData[]
---Array of user data stored with the asset
---@field AssetUserDataEditorOnly AssetUserData[]
---@field SkinWeightProfiles SkinWeightProfileInfo[]
---@field DefaultMeshDeformer MeshDeformer
---Skeletal Mesh needs this collection of deformers to make sure it cooks any extra data required by these deformers
---@field TargetMeshDeformers MeshDeformerCollection
---@field OverlayMaterial MaterialInterface
---@field OverlayMaterialMaxDrawDistance number
---Axis that the skeletal mesh is facing. Default is the Y axis.
---The facing axis represents the MeshDescription's orientation and is set on import.
---Therefore, if this property is modified elsewhere, the associated MeshDescription should be appropriately modified to reflect the new orientation.
---@field ForwardAxis integer
local SkeletalMesh = {}

--- Methods
---Set Skeleton
---@param InSkeleton Skeleton
---@return nil
function SkeletalMesh.SetSkeleton(InSkeleton) end

---Change the default overlay material max draw distance used by this mesh
---@param InMaxDrawDistance number
---@return nil
function SkeletalMesh.SetOverlayMaterialMaxDrawDistance(InMaxDrawDistance) end

---Change the default overlay material used by this mesh
---@param NewOverlayMaterial MaterialInterface
---@return nil
function SkeletalMesh.SetOverlayMaterial(NewOverlayMaterial) end

---Set Morph Targets
---@return nil
function SkeletalMesh.SetMorphTargets() end

---Allow to override min lod quality levels on a skeletalMesh and it Default value (-1 value for Default dont override its value).
---@param Default integer
---@return nil
function SkeletalMesh.SetMinLODForQualityLevels(Default) end

---Set Mesh Clothing Assets
---@return nil
function SkeletalMesh.SetMeshClothingAssets() end

---Set Materials
---@return nil
function SkeletalMesh.SetMaterials() end

---Set LODSettings
---@param InLODSettings SkeletalMeshLODSettings
---@return nil
function SkeletalMesh.SetLODSettings(InLODSettings) end

---Set Default Animating Rig
---@param InAnimatingRig any
---@return nil
function SkeletalMesh.SetDefaultAnimatingRig(InAnimatingRig) end

---Returns the number of sockets available. Both on this mesh and it's skeleton.
---@return integer
function SkeletalMesh.NumSockets() end

---Returns the list of all morph targets of this skeletal mesh
---@return string[]
function SkeletalMesh.K2_GetAllMorphTargetNames() end

---Checks whether the provided section is using APEX cloth. if bCheckCorrespondingSections is true
---disabled sections will defer to correspond sections to see if they use cloth (non-cloth sections
---are disabled and another section added when cloth is enabled, using this flag allows for a check
---on the original section to succeed)
---@param InSectionIndex integer
---@param bCheckCorrespondingSections boolean
---@return boolean
function SkeletalMesh.IsSectionUsingCloth(InSectionIndex, bCheckCorrespondingSections) end

---Set the collection of mesh deformers that may be applied to this mesh. Skeletal Mesh use these deformers to determined if any extra data needs to be cooked
---@return MeshDeformerCollection
function SkeletalMesh.GetTargetMeshDeformers() end

---Returns a socket by index. Max index is NumSockets(). The meshes sockets are accessed first, then the skeletons.
---@param Index integer
---@return SkeletalMeshSocket
function SkeletalMesh.GetSocketByIndex(Index) end

---USkinnedAsset interface.
---@return Skeleton
function SkeletalMesh.GetSkeleton() end

---USkinnedAsset interface.
---@return PhysicsAsset
function SkeletalMesh.GetShadowPhysicsAsset() end

---USkinnedAsset interface.
---@return PhysicsAsset
function SkeletalMesh.GetPhysicsAsset() end

---Get the default overlay material max draw distance used by this mesh
---@return number
function SkeletalMesh.GetOverlayMaterialMaxDrawDistance() end

---Get the default overlay material used by this mesh
---@return MaterialInterface
function SkeletalMesh.GetOverlayMaterial() end

---Get Node Mapping Data
---@return NodeMappingContainer[]
function SkeletalMesh.GetNodeMappingData() end

---Get Node Mapping Container
---@param SourceAsset Blueprint
---@return NodeMappingContainer
function SkeletalMesh.GetNodeMappingContainer(SourceAsset) end

---NOTE: BP compiler doesn't support TObjectPtr as an argument type for UFUNCTION so this converting call is
---required. For many morphs, this can be expensive, since it needs to resolve _all_ TObjectPtrs and construct a new
---array for it.
---@return MorphTarget[]
function SkeletalMesh.GetMorphTargetsPtrConv() end

---Get Min LODFor Quality Levels
---@return nil, table<EPerQualityLevels, integer>, integer
function SkeletalMesh.GetMinLODForQualityLevels() end

---Get Mesh Clothing Assets
---@return ClothingAssetBase[]
function SkeletalMesh.GetMeshClothingAssets() end

---USkinnedAsset interface.
---@return SkeletalMaterial[]
function SkeletalMesh.GetMaterials() end

---Get LODSettings
---@return SkeletalMeshLODSettings
function SkeletalMesh.GetLODSettings() end

---Get the original imported bounds of the skel mesh
---@return BoxSphereBounds
function SkeletalMesh.GetImportedBounds() end

---Return whether the mesh has vertex colors. USkinnedAsset interface.
---@return boolean
function SkeletalMesh.GetHasVertexColors() end

---Get the forward axis used by this mesh
---@return integer
function SkeletalMesh.GetForwardAxis() end

---Get the default mesh deformer used by this mesh. A mesh deformer is used to deform the skeletal mesh at runtime
---@return MeshDeformer
function SkeletalMesh.GetDefaultMeshDeformer() end

---Get Default Animating Rig
---@return any
function SkeletalMesh.GetDefaultAnimatingRig() end

---Get the extended bounds of this mesh (imported bounds plus bounds extension). USkinnedAsset interface.
---@return BoxSphereBounds
function SkeletalMesh.GetBounds() end

---Find a socket object in this SkeletalMesh by name.
---Entering NAME_None will return NULL. If there are multiple sockets with the same name, will return the first one.
---Also returns the index for the socket allowing for future fast access via GetSocketByIndex()
---@param InSocketName string
---@return SkeletalMeshSocket
function SkeletalMesh.FindSocketAndIndex(InSocketName) end

---Add a skeletal socket object to this SkeletalMesh, and optionally promotes it to USkeleton socket.
---@param InSocket SkeletalMeshSocket
---@param bAddToSkeleton boolean
---@return nil
function SkeletalMesh.AddSocket(InSocket, bAddToSkeleton) end

return SkeletalMesh
