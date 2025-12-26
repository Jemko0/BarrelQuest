---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class StaticMesh : StreamableRenderAsset
---A StaticMesh is a piece of geometry that consists of a static set of polygons.
---Static Meshes can be translated, rotated, and scaled, but they cannot have their vertices animated in any way. As such, they are more efficient
---to render than other types of geometry such as USkeletalMesh, and they are often the basic building block of levels created in the engine.
---@see https://docs.unrealengine.com/latest/INT/Engine/Content/Types/StaticMeshes/
---@see AStaticMeshActor, UStaticMeshComponent
---
--- Properties
---
---The LOD group to which this mesh belongs.
---@field LODGroup string
---If non-negative, specify the maximum number of streamed LODs. Only has effect if
---mesh LOD streaming is enabled for the target platform.
---@field NumStreamedLODs PerPlatformInt
---The last import version
---@field ImportVersion integer
---@field MaterialRemapIndexPerImportVersion MaterialRemapIndex[]
---If true, the screen sizes at which LODs swap are computed automatically.
---@field bAutoComputeLODScreenSize boolean
---Materials used by this static mesh. Individual sections index in to this array.
---@field Materials MaterialInterface[]
---Settings related to building Nanite data.
---@field NaniteSettings MeshNaniteSettings
---Allow more flexibility to set various values driven by the Scalability or Device Profile.
---@field MinQualityLevelLOD PerQualityLevelInt
---@field MinLOD PerPlatformInt
---Index of an element to ignore while gathering streaming texture factors.
---This is useful to disregard automatically generated vertex data which breaks texture factor heuristics.
---@field ElementToIgnoreForTexFactor integer
---The light map resolution
---@field LightMapResolution integer
---The light map coordinate index
---@field LightMapCoordinateIndex integer
---Whether to support per instance texture color mesh painting on components using this mesh.
---@field StaticMeshPaintSupport EStaticMeshPaintSupport
---The default coordinate index to use when texture color painting on this mesh.
---@field MeshPaintTextureCoordinateIndex integer
---The resolution of texture color mesh paint textures on this mesh.
---The final size will be rounded up to a power of 2 and a multiple of the "Mesh Paint Tile Size" project setting.
---A default value of 0 will auto calculate the size using the "Mesh paint texels per vertex" project setting.
---@field MeshPaintTextureResolution integer
---Useful for reducing self shadowing from distance field methods when using world position offset to animate the mesh's vertices.
---@field DistanceFieldSelfShadowBias number
---Specifies which mesh LOD to use for complex (per-poly) collision.
---Sometimes it can be desirable to use a lower poly representation for collision to reduce memory usage, improve performance and behaviour.
---Collision representation does not change based on distance to camera.
---@field LODForCollision integer
---Whether to generate a distance field for this mesh, which can be used by DistanceField Indirect Shadows.
---This is ignored if the project's 'Generate Mesh Distance Fields' setting is enabled.
---@field bGenerateMeshDistanceField boolean
---If true, strips unwanted complex collision data aka kDOP tree when cooking for consoles.
---              On the Playstation 3 data of this mesh will be stored in video memory.
---@field bStripComplexCollisionForConsole boolean
---If true, mesh will have NavCollision property with additional data for navmesh generation and usage.
---          Set to false for distant meshes (always outside navigation bounds) to save memory on collision data.
---@field bHasNavigationData boolean
---Mesh supports uniformly distributed sampling in constant time.
---Memory cost is 8 bytes per triangle.
---Example usage is uniform spawning of particles.
---@field bSupportUniformlyDistributedSampling boolean
---If true, complex collision data will store UVs and face remap table for use when performing
---PhysicalMaterialMask lookups in cooked builds. Note the increased memory cost for this
---functionality.
---@field bSupportPhysicalMaterialMasks boolean
---Settings related to building Ray Tracing Proxy data.
---@field RayTracingProxySettings MeshRayTracingProxySettings
---If true, a ray tracing acceleration structure will be built for this mesh and it may be used in ray tracing effects
---@field bSupportRayTracing boolean
---@field bDoFastBuild boolean
---If true, will keep geometry data CPU-accessible in cooked builds, rather than uploading to GPU memory and releasing it from CPU memory.
---This is required if you wish to access StaticMesh geometry data on the CPU at runtime in cooked builds (e.g. to convert StaticMesh to ProceduralMeshComponent)
---@field bAllowCPUAccess boolean
---If true, a GPU buffer containing required data for uniform mesh surface sampling will be created at load time.
---It is created from the cpu data so bSupportUniformlyDistributedSampling is also required to be true.
---@field bSupportGpuUniformlyDistributedSampling boolean
---Importing data and options used for this mesh
---@field AssetImportData AssetImportData
---Path to the resource used to construct this static mesh
---@field SourceFilePath string
---Date/Time-stamp of the file from the last import
---@field SourceFileTimestamp string
---Information for thumbnail rendering
---@field ThumbnailInfo ThumbnailInfo
---The stored camera position to use as a default for the static mesh editor
---@field EditorCameraPosition AssetEditorOrbitCameraPosition
---If the user has modified collision in any way or has custom collision imported. Used for determining if to auto generate collision on import
---@field bCustomizedCollision boolean
---Array of named socket locations, set up in editor and used as a shortcut instead of specifying
---everything explicitly to AttachComponent in the StaticMeshComponent.
---@field Sockets StaticMeshSocket[]
---@field PositiveBoundsExtension Vector
---@field NegativeBoundsExtension Vector
---@field ExtendedBounds BoxSphereBounds
---Array of user data stored with the asset
---@field AssetUserData AssetUserData[]
---@field EditableMesh Object
---@field ComplexCollisionMesh StaticMesh
local StaticMesh = {}

--- Methods
---Set Static Materials
---@return nil
function StaticMesh.SetStaticMaterials() end

---Set Num Source Models
---@param Num integer
---@return nil
function StaticMesh.SetNumSourceModels(Num) end

---Allow to override min lod quality levels on a staticMesh and it Default value (-1 value for Default dont override its value).
---@param Default integer
---@return nil
function StaticMesh.SetMinLODForQualityLevels(Default) end

---Set Minimum LODFor Platforms
---@return nil
function StaticMesh.SetMinimumLODForPlatforms() end

---Set Minimum LODFor Platform
---@param InMinLOD integer
---@return nil
function StaticMesh.SetMinimumLODForPlatform(InMinLOD) end

---Sets a Material given a Material Index
---@param MaterialIndex integer
---@param NewMaterial MaterialInterface
---@return nil
function StaticMesh.SetMaterial(MaterialIndex, NewMaterial) end

---Remove a socket object in this StaticMesh by providing it's pointer. Use FindSocket() if needed.
---@param Socket StaticMeshSocket
---@return nil
function StaticMesh.RemoveSocket(Socket) end

---Is LODScreen Size Auto Computed
---@return boolean
function StaticMesh.IsLODScreenSizeAutoComputed() end

---Return a new StaticMeshDescription referencing the MeshDescription of the given LOD
---@param LODIndex integer
---@return StaticMeshDescription
function StaticMesh.GetStaticMeshDescription(LODIndex) end

---Get Static Materials
---@return StaticMaterial[]
function StaticMesh.GetStaticMaterials() end

---Returns a list of sockets with the provided tag.
---@param InSocketTag string
---@return StaticMeshSocket[]
function StaticMesh.GetSocketsByTag(InSocketTag) end

---Returns the number of vertices for the specified LOD.
---@param LODIndex integer
---@return integer
function StaticMesh.GetNumVertices(LODIndex) end

---Returns the number of triangles in the render data for the specified LOD.
---@param LODIndex integer
---@return integer
function StaticMesh.GetNumTriangles(LODIndex) end

---Returns number of Sections that this StaticMesh has, in the supplied LOD (LOD 0 is the highest)
---@param InLOD integer
---@return integer
function StaticMesh.GetNumSections(InLOD) end

---Returns the number of LODs used by the mesh.
---@return integer
function StaticMesh.GetNumLODs() end

---Get Min LODFor Quality Levels
---@return nil, table<EPerQualityLevels, integer>, integer
function StaticMesh.GetMinLODForQualityLevels() end

---Get Minimum LODFor Quality Levels
---@return nil, table<string, integer>
function StaticMesh.GetMinimumLODForQualityLevels() end

---Get Minimum LODFor Quality Level
---@return integer
function StaticMesh.GetMinimumLODForQualityLevel() end

---Get Minimum LODFor Platforms
---@return nil, table<string, integer>
function StaticMesh.GetMinimumLODForPlatforms() end

---Get Minimum LODFor Platform
---@return integer
function StaticMesh.GetMinimumLODForPlatform() end

---Gets a Material index given a slot name
---@param MaterialSlotName string
---@return integer
function StaticMesh.GetMaterialIndex(MaterialSlotName) end

---Gets a Material given a Material Index and an LOD number
---@param MaterialIndex integer
---@return MaterialInterface
function StaticMesh.GetMaterial(MaterialIndex) end

---Returns the number of bounds of the mesh.
---@return BoxSphereBounds
function StaticMesh.GetBounds() end

---Returns the bounding box, in local space including bounds extension(s), of the StaticMesh asset
---@return Box
function StaticMesh.GetBoundingBox() end

---Find a socket object in this StaticMesh by name.
---Entering NAME_None will return NULL. If there are multiple sockets with the same name, will return the first one.
---@param InSocketName string
---@return StaticMeshSocket
function StaticMesh.FindSocket(InSocketName) end

---Create an empty StaticMeshDescription object, to describe a static mesh at runtime
---@param Outer Object
---@return StaticMeshDescription
function StaticMesh.CreateStaticMeshDescription(Outer) end

---Builds static mesh LODs from the array of StaticMeshDescriptions passed in
---@param bBuildSimpleCollision boolean
---@param bFastBuild boolean
---@return nil
function StaticMesh.BuildFromStaticMeshDescriptions(bBuildSimpleCollision, bFastBuild) end

---Add a socket object in this StaticMesh.
---@param Socket StaticMeshSocket
---@return nil
function StaticMesh.AddSocket(Socket) end

---Adds a new material and return its slot name
---@param Material MaterialInterface
---@return string
function StaticMesh.AddMaterial(Material) end

return StaticMesh
