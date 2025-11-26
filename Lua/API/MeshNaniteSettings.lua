---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class MeshNaniteSettings
---Settings applied when building Nanite data.
---
--- Properties
---
---If true, Nanite data will be generated.
---@field bEnabled boolean
---Whether to try and maintain the same surface area at all distances. Useful for foliage that thins out otherwise.
---@field bPreserveArea boolean
---Whether to store explicit tangents instead of using the implicitly derived ones.
---@field bExplicitTangents boolean
---Whether to interpolate UVs when simplifying.
---Should be enabled whenever possible.
---For real UV coordinates this allows calculating the lowest error optimal UVs for new vertices when simplifying,
---assuming the UVs are used as normal texture coordinates and will interpolate across the face of the triangles.
---Disable if data stored in UVs isn't valid to interpolate, for example if indexes are stored in UVs.
---Lerping an index doesn't make sense and would break the shader trying to use it.
---Note: If disabled, error from UVs is no longer accounted for when Nanite selects the LOD to render because
---error due to arbitrary vertex attributes that aren't interpolatable can't be generally reasoned about.
---@field bLerpUVs boolean
---@field bSeparable boolean
---@field bVoxelNDF boolean
---@field bVoxelOpacity boolean
---Position Precision. Step size is 2^(-PositionPrecision) cm. MIN_int32 is auto.
---@field PositionPrecision integer
---Normal Precision in bits. -1 is auto.
---@field NormalPrecision integer
---Tangent Precision in bits. -1 is auto.
---@field TangentPrecision integer
---Blend Weight Precision in bits. -1 is auto. 0 is rigid.
---@field BoneWeightPrecision integer
---How much of the resource should always be resident (In KB). Approximate due to paging. 0: Minimum size (single page). MAX_uint32: Entire mesh.
---@field TargetMinimumResidencyInKB integer
---Percentage of triangles to keep from source mesh. 1.0 = no reduction, 0.0 = no triangles.
---@field KeepPercentTriangles number
---Reduce until at least this amount of error is reached relative to size of the mesh
---@field TrimRelativeError number
---Whether fallback mesh should be generated.
---@field GenerateFallback ENaniteGenerateFallback
---Which heuristic to use when generating the fallback mesh.
---@field FallbackTarget ENaniteFallbackTarget
---Percentage of triangles to keep from source mesh for fallback. 1.0 = no reduction, 0.0 = no triangles.
---@field FallbackPercentTriangles number
---Reduce until at least this amount of error is reached relative to size of the mesh
---@field FallbackRelativeError number
---Controls the maximum distance allowed between each vertex of the mesh on screen. Can be used to prevent oversimplification
---of meshes that are intended to be deformed (e.g. animation using World Position Offset, Spline Mesh Component, etc.).
---Should be left at default of 0 unless explicitly needed to fix oversimplification issues.
---@field MaxEdgeLengthFactor number
---Number of rays
---@field NumRays integer
---@field VoxelLevel integer
---@field RayBackUp number
---UV channel used to sample displacement maps
---@field DisplacementUVChannel integer
---@field DisplacementMaps MeshDisplacementMap[]
---Nanite Assembly data set up by the import
---@field NaniteAssemblyData NaniteAssemblyData
local MeshNaniteSettings = {}

--- Constructor
---@return MeshNaniteSettings
---@param bEnabled boolean
---@param bPreserveArea boolean
---@param bExplicitTangents boolean
---@param bLerpUVs boolean
---@param bSeparable boolean
---@param bVoxelNDF boolean
---@param bVoxelOpacity boolean
---@param PositionPrecision integer
---@param NormalPrecision integer
---@param TangentPrecision integer
---@param BoneWeightPrecision integer
---@param TargetMinimumResidencyInKB integer
---@param KeepPercentTriangles number
---@param TrimRelativeError number
---@param GenerateFallback ENaniteGenerateFallback
---@param FallbackTarget ENaniteFallbackTarget
---@param FallbackPercentTriangles number
---@param FallbackRelativeError number
---@param MaxEdgeLengthFactor number
---@param NumRays integer
---@param VoxelLevel integer
---@param RayBackUp number
---@param DisplacementUVChannel integer
---@param DisplacementMaps MeshDisplacementMap[]
---@param NaniteAssemblyData NaniteAssemblyData
function MeshNaniteSettings.new(bEnabled, bPreserveArea, bExplicitTangents, bLerpUVs, bSeparable, bVoxelNDF, bVoxelOpacity, PositionPrecision, NormalPrecision, TangentPrecision, BoneWeightPrecision, TargetMinimumResidencyInKB, KeepPercentTriangles, TrimRelativeError, GenerateFallback, FallbackTarget, FallbackPercentTriangles, FallbackRelativeError, MaxEdgeLengthFactor, NumRays, VoxelLevel, RayBackUp, DisplacementUVChannel, DisplacementMaps, NaniteAssemblyData)
    local self = {}
    self.bEnabled = bEnabled
    self.bPreserveArea = bPreserveArea
    self.bExplicitTangents = bExplicitTangents
    self.bLerpUVs = bLerpUVs
    self.bSeparable = bSeparable
    self.bVoxelNDF = bVoxelNDF
    self.bVoxelOpacity = bVoxelOpacity
    self.PositionPrecision = PositionPrecision
    self.NormalPrecision = NormalPrecision
    self.TangentPrecision = TangentPrecision
    self.BoneWeightPrecision = BoneWeightPrecision
    self.TargetMinimumResidencyInKB = TargetMinimumResidencyInKB
    self.KeepPercentTriangles = KeepPercentTriangles
    self.TrimRelativeError = TrimRelativeError
    self.GenerateFallback = GenerateFallback
    self.FallbackTarget = FallbackTarget
    self.FallbackPercentTriangles = FallbackPercentTriangles
    self.FallbackRelativeError = FallbackRelativeError
    self.MaxEdgeLengthFactor = MaxEdgeLengthFactor
    self.NumRays = NumRays
    self.VoxelLevel = VoxelLevel
    self.RayBackUp = RayBackUp
    self.DisplacementUVChannel = DisplacementUVChannel
    self.DisplacementMaps = DisplacementMaps
    self.NaniteAssemblyData = NaniteAssemblyData
    return self
end

return MeshNaniteSettings
