---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MeshRayTracingProxySettings
---Mesh Ray Tracing Proxy Settings
---
--- Properties
---If true, Ray Tracing Proxy data will be generated.
---@field bEnabled boolean
---Which heuristic to use when generating the fallback mesh.
---@field FallbackTarget ENaniteFallbackTarget
---Percentage of triangles to keep from source mesh for fallback. 1.0 = no reduction, 0.0 = no triangles.
---@field FallbackPercentTriangles number
---Reduce until at least this amount of error is reached relative to size of the mesh
---@field FallbackRelativeError number
---@field LOD1PercentTriangles number
---A bias to reduce foliage over occlusion in Lumen GI. 0: no adjustment, 1: full strength.
---@field FoliageOverOcclusionBias number
local MeshRayTracingProxySettings = {}
return MeshRayTracingProxySettings
