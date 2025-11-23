---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class LevelSimplificationDetails
---Level Simplification Details
---
--- Properties
---Whether to create separate packages for each generated asset. All in map package otherwise
---@field bCreatePackagePerAsset boolean
---Percentage of details for static mesh proxy
---@field DetailsPercentage number
---Landscape material simplification
---@field StaticMeshMaterialSettings MaterialProxySettings
---@field bOverrideLandscapeExportLOD boolean
---Landscape LOD to use for static mesh generation, when not specified 'Max LODLevel' from landscape actor will be used
---@field LandscapeExportLOD integer
---Landscape material simplification
---@field LandscapeMaterialSettings MaterialProxySettings
---Whether to bake foliage into landscape static mesh texture
---@field bBakeFoliageToLandscape boolean
---Whether to bake grass into landscape static mesh texture
---@field bBakeGrassToLandscape boolean
local LevelSimplificationDetails = {}
return LevelSimplificationDetails
