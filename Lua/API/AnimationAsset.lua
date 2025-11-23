---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class AnimationAsset
---Animation Asset
---
--- Properties
---Parent Asset, if set, you won't be able to edit any data in here but just mapping table
---During cooking, this data will be used to bake out to normal asset
---@field ParentAsset AnimationAsset
---note this is transient as they're added as they're loaded
---@field ChildrenAssets AnimationAsset[]
---Asset mapping table when ParentAsset is set
---@field AssetMappingTable AssetMappingTable
---Array of user data stored with the asset
---@field AssetUserData AssetUserData[]
---Information for thumbnail rendering
---@field ThumbnailInfo ThumbnailInfo
---The default skeletal mesh to use when previewing this asset - this only applies when you open Persona using this asset// @todo: note that this doesn't retarget right now
---@field PreviewPoseAsset PoseAsset
local AnimationAsset = {}

--- Methods
---Sets or updates the preview skeletal mesh
---@param PreviewMesh SkeletalMesh
---@return nil
function AnimationAsset.SetPreviewSkeletalMesh(PreviewMesh) end

---Get Play Length
---@return number
function AnimationAsset.GetPlayLength() end

---Returns the first metadata of the specified class
---@param MetaDataClass Class
---@return AnimMetaData
function AnimationAsset.FindMetaDataByClass(MetaDataClass) end

return AnimationAsset
