---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SkeletalMeshLODSettings : DataAsset
---Skeletal Mesh LODSettings
---
--- Properties
---Minimum Quality Level LOD to render. Can be overridden per mesh as well as set here for all mesh instances
---@field MinQualityLevelLod PerQualityLevelInt
---Minimum LOD to render. Can be overridden per mesh as well as set here for all mesh instances
---@field MinLod PerPlatformInt
---When true LODs below MinLod will not be stripped during cook.
---@field DisableBelowMinLodStripping PerPlatformBool
---Whether meshes in this group override default LOD streaming settings.
---@field bOverrideLODStreamingSettings boolean
---Whether meshes in this group stream LODs by default
---@field bSupportLODStreaming PerPlatformBool
---Default maximum number of streamed LODs for meshes in this group
---@field MaxNumStreamedLODs PerPlatformInt
---Default maximum number of optional LODs for meshes in this group (currently, need to be either 0 or > num of LODs below MinLod)
---@field MaxNumOptionalLODs PerPlatformInt
---@field LODGroups SkeletalMeshLODGroupSettings[]
local SkeletalMeshLODSettings = {}

--- Methods
return SkeletalMeshLODSettings
