---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class StaticMeshComponent : MeshComponent
---StaticMeshComponent is used to create an instance of a UStaticMesh.
---A static mesh is a piece of geometry that consists of a static set of polygons.
---@see https://docs.unrealengine.com/latest/INT/Engine/Content/Types/StaticMeshes/
---@see UStaticMesh
---
--- Properties
---If 0, auto-select LOD level. if >0, force to (ForcedLodModel-1).
---@field ForcedLodModel integer
---Specifies the smallest LOD that will be used for this component.
---This is ignored if ForcedLodModel is enabled.
---@field MinLOD integer
---Subdivision step size for static vertex lighting.
---@field SubDivisionStepSize integer
---Wireframe color to use if bOverrideWireframeColor is true
---@field WireframeColorOverride Color
---Distance at which to disable World Position Offset for an entire instance (0 = Never disable WPO).
---@field WorldPositionOffsetDisableDistance integer
---Forces this component to always use Nanite for masked materials, even if FNaniteSettings::bAllowMaskedMaterials=false
---@field bForceNaniteForMasked boolean
---Forces this component to use fallback mesh for rendering if Nanite is enabled on the mesh.
---@field bDisallowNanite boolean
---Forces this component to use fallback mesh for rendering if Nanite is enabled on the mesh (run-time override)
---@field bForceDisableNanite boolean
---Whether to evaluate World Position Offset.
---@field bEvaluateWorldPositionOffset boolean
---Whether world position offset turns on velocity writes.
---If the WPO isn't static then setting false may give incorrect motion vectors.
---But if we know that the WPO is static then setting false may save performance.
---@field bWorldPositionOffsetWritesVelocity boolean
---Whether to evaluate World Position Offset for ray tracing.
---This is only used when running with r.RayTracing.Geometry.StaticMeshes.WPO=1
---@field bEvaluateWorldPositionOffsetInRayTracing boolean
---The section currently selected in the Editor. Used for highlighting
---@field SelectedEditorSection integer
---The material currently selected in the Editor. Used for highlighting
---@field SelectedEditorMaterial integer
---Index of the section to preview. If set to INDEX_NONE, all section will be rendered. Used for isolating in Static Mesh Tool *
---@field SectionIndexPreview integer
---Index of the material to preview. If set to INDEX_NONE, all section will be rendered. Used for isolating in Static Mesh Tool *
---@field MaterialIndexPreview integer
---* The import version of the static mesh when it was assign this is update when:
---* - The user assign a new staticmesh to the component
---* - The component is serialize (IsSaving)
---* - Default value is BeforeImportStaticMeshVersionWasAdded
---*
---* If when the component get load (PostLoad) the version of the attach staticmesh is newer
---* then this value, we will remap the material override because the order of the materials list
---* in the staticmesh can be changed. Hopefully there is a remap table save in the staticmesh.
---@field StaticMeshImportVersion integer
---If true, WireframeColorOverride will be used. If false, color is determined based on mobility and physics simulation settings
---@field bOverrideWireframeColor boolean
---Whether to override the MinLOD setting of the static mesh asset with the MinLOD of this component.
---@field bOverrideMinLOD boolean
---If true, bForceNavigationObstacle flag will take priority over navigation data stored in StaticMesh
---@field bOverrideNavigationExport boolean
---Allows overriding navigation export behavior per component: full collisions or dynamic obstacle
---@field bForceNavigationObstacle boolean
---Deprecated. Use bEnableVertexColorMeshPainting instead.
---@field bDisallowMeshPaintPerInstance boolean
---Ignore this instance of this static mesh when calculating streaming information.
---This can be useful when doing things like applying character textures to static geometry,
---to avoid them using distance-based streaming.
---@field bIgnoreInstanceForTextureStreaming boolean
---Whether to override the lightmap resolution defined in the static mesh.
---@field bOverrideLightMapRes boolean
---Whether to use the mesh distance field representation (when present) for shadowing indirect lighting (from lightmaps or skylight) on Movable components.
---This works like capsule shadows on skeletal meshes, except using the mesh distance field so no physics asset is required.
---The StaticMesh must have 'Generate Mesh Distance Field' enabled, or the project must have 'Generate Mesh Distance Fields' enabled for this feature to work.
---@field bCastDistanceFieldIndirectShadow boolean
---Whether to override the DistanceFieldSelfShadowBias setting of the static mesh asset with the DistanceFieldSelfShadowBias of this component.
---@field bOverrideDistanceFieldSelfShadowBias boolean
---Whether to use subdivisions or just the triangle's vertices.
---@field bUseSubDivisions boolean
---Use the collision profile specified in the StaticMesh asset.
---@field bUseDefaultCollision boolean
---The component has some custom painting on LODs or not.
---@field bCustomOverrideVertexColorPerLOD boolean
---@field bDisplayVertexColors boolean
---@field bDisplayPhysicalMaterialMasks boolean
---For Nanite enabled meshes, we'll only show the proxy mesh if this is true
---@field bDisplayNaniteFallbackMesh boolean
---Transient flag used during registration to handle edge case with mesh compilation completion callback.
---We perform actions to register the mesh properly when it gets called async, but we end up doing those
---twice when it gets called while the registration is not completed.
---@field bRegistering boolean
---Enable dynamic sort mesh's triangles to remove ordering issue when rendered with a translucent material
---@field bSortTriangles boolean
---Controls whether the static mesh component's backface culling should be reversed
---@field bReverseCulling boolean
---If false, vertex color mesh painting is disabled on this component.
---This may be set to false by blueprint functions that override vertex colors in construction script.
---@field bEnableVertexColorMeshPainting boolean
---If false, texture color mesh painting is disabled on this component.
---@field bEnableTextureColorMeshPainting boolean
---Whether to override the MeshPaintTextureCoordinateIndex set on the static mesh.
---@field bOverrideMeshPaintTextureCoordinateIndex boolean
---Whether to override the MeshPaintTextureCoordinateIndex set on the static mesh.
---@field bOverrideMeshPaintTextureResolution boolean
---The overriden coordinate index to use when texture color painting on this component.
---@field OverriddenMeshPaintTextureCoordinateIndex integer
---The overriden resolution of texture color mesh paint textures on this component.
---@field OverriddenMeshPaintTextureResolution integer
---Light map resolution to use on this component, used if bOverrideLightMapRes is true and there is a valid StaticMesh.
---@field OverriddenLightMapRes integer
---Texture containing texture color mesh painting for this mesh component.
---@field MeshPaintTexture Texture
---Cooked pointer to texture containing mesh painting for this mesh component. This will be taken from MeshPaintTexture but can be empty on some platforms if we choose to strip the data.
---@field MeshPaintTextureCooked Texture
---Set this to override the locally stored mesh paint texture.
---@field MeshPaintTextureOverride Texture
---@field MaterialCacheTexture Texture
---Controls how dark the dynamic indirect shadow can be.
---@field DistanceFieldIndirectShadowMinVisibility number
---Useful for reducing self shadowing from distance field methods when using world position offset to animate the mesh's vertices.
---@field DistanceFieldSelfShadowBias number
---Allows adjusting the desired resolution of streaming textures that uses UV 0.  1.0 is the default, whereas a higher value increases the streamed-in resolution.
---@field StreamingDistanceMultiplier number
---Used to forcefully disable pixel programmable rasterization of Nanite when the mesh is further than a given distance from the camera.
---@field NanitePixelProgrammableDistance number
---@field IrrelevantLights Guid[]
---Static mesh LOD data.  Contains static lighting data along with instanced mesh vertex colors.
---@field LODData StaticMeshComponentLODInfo[]
---The list of texture, bounds and scales. As computed in the texture streaming build process.
---@field StreamingTextureData StreamingTextureBuildInfo[]
---Derived data key of the static mesh, used to determine if an update from the source static mesh is required.
---@field StaticMeshDerivedDataKey string
---Material Bounds used for texture streaming.
---@field MaterialStreamingRelativeBoxes integer[]
---The Lightmass settings for this object.
---@field LightmassSettings LightmassPrimitiveSettings
local StaticMeshComponent = {}

--- Methods
---This manually updates the initial value of bEvaluateWorldPositionOffset to be the current value.
---    This is useful if the default value of bEvaluateWorldPositionOffset is changed after constructing
---    the component.
---@return nil
function StaticMeshComponent.UpdateInitialEvaluateWorldPositionOffset() end

---Set World Position Offset Disable Distance
---@param NewValue integer
---@return nil
function StaticMeshComponent.SetWorldPositionOffsetDisableDistance(NewValue) end

---Change the StaticMesh used by this instance.
---@param NewMesh StaticMesh
---@return boolean
function StaticMeshComponent.SetStaticMesh(NewMesh) end

---Set forced reverse culling
---@param ReverseCulling boolean
---@return nil
function StaticMeshComponent.SetReverseCulling(ReverseCulling) end

---Set Forced Lod Model
---@param NewForcedLodModel integer
---@return nil
function StaticMeshComponent.SetForcedLodModel(NewForcedLodModel) end

---Force disabling of Nanite rendering. When true, Will swap to the the fallback mesh instead.
---@param bInForceDisableNanite boolean
---@return nil
function StaticMeshComponent.SetForceDisableNanite(bInForceDisableNanite) end

---Set Evaluate World Position Offset in Ray Tracing
---@param NewValue boolean
---@return nil
function StaticMeshComponent.SetEvaluateWorldPositionOffsetInRayTracing(NewValue) end

---Set Evaluate World Position Offset
---@param NewValue boolean
---@return nil
function StaticMeshComponent.SetEvaluateWorldPositionOffset(NewValue) end

---Sets the component's DistanceFieldSelfShadowBias.  bOverrideDistanceFieldSelfShadowBias must be enabled for this to have an effect.
---@param NewValue number
---@return nil
function StaticMeshComponent.SetDistanceFieldSelfShadowBias(NewValue) end

---Get Local bounds
---@return nil, Vector, Vector
function StaticMeshComponent.GetLocalBounds() end

---Get the initial value of bEvaluateWorldPositionOffset. This is the value when BeginPlay() was last called, or if UpdateInitialEvaluateWorldPositionOffset is called.
---@return boolean
function StaticMeshComponent.GetInitialEvaluateWorldPositionOffset() end

return StaticMeshComponent
