---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MaterialInterface
---Material Interface
---
--- Properties
---@field EditorOnlyData MaterialInterfaceEditorOnlyData
---SubsurfaceProfile, for Screen Space Subsurface Scattering..
---@field SubsurfaceProfile SubsurfaceProfile
---Subsurface Profiles. For internal usage, not editable/visible.
---For Substrate, there can be many in a material similarly to SpecularProfile (even though only one can be specified per pixel due to the post processing)
---@field SubsurfaceProfiles SubsurfaceProfile[]
---Specular Profile. For internal usage, not editable/visible
---@field SpecularProfiles SpecularProfile[]
---Neural network profile. For internal usage, not editable/visible
---@field NeuralProfile NeuralProfile
---The Lightmass settings for this object.
---@field LightmassSettings LightmassMaterialInterfaceSettings
---Because of redirector, the texture names need to be resorted at each load in case they changed.
---@field bTextureStreamingDataSorted boolean
---@field TextureStreamingDataVersion integer
---Data used by the texture streaming to know how each texture is sampled by the material. Sorted by names for quick access.
---@field TextureStreamingData MaterialTextureInfo[]
---Array of user data stored with the asset
---@field AssetUserData AssetUserData[]
---Pre-cached texture sampling information used for texture streaming (calculated on load) *
---@field CachedTexturesSamplingInfo any
---Whether this material interface is included in the base game (and not in a DLC)
---@field bIncludedInBaseGame boolean
---List of all used but missing texture indices in TextureStreamingData. Used for visualization / debugging only.
---@field TextureStreamingDataMissingEntries MaterialTextureInfo[]
---The mesh used by the material editor to preview the material.
---@field PreviewMesh SoftObjectPath
---Information for thumbnail rendering
---@field ThumbnailInfo ThumbnailInfo
---@field LayerParameterExpansion table<string, boolean>
---@field ParameterOverviewExpansion table<string, boolean>
---Importing data and options used for this material
---@field AssetImportData AssetImportData
local MaterialInterface = {}

--- Methods
---Force the streaming system to disregard the normal logic for the specified duration and
---instead always load all mip-levels for all textures used by this material.
---@param OverrideForceMiplevelsToBeResident boolean
---@param bForceMiplevelsToBeResidentValue boolean
---@param ForceDuration number
---@param CinematicTextureGroups integer
---@param bFastResponse boolean
---@return nil
function MaterialInterface.SetForceMipLevelsToBeResident(OverrideForceMiplevelsToBeResident, bForceMiplevelsToBeResidentValue, ForceDuration, CinematicTextureGroups, bFastResponse) end

---Return a pointer to the physical material mask used by this material instance.
---@return PhysicalMaterialMask
function MaterialInterface.GetPhysicalMaterialMask() end

---Return a pointer to the physical material from mask map at given index.
---@param Index integer
---@return PhysicalMaterial
function MaterialInterface.GetPhysicalMaterialFromMap(Index) end

---Return a pointer to the physical material used by this material instance.
---@return PhysicalMaterial
function MaterialInterface.GetPhysicalMaterial() end

---Get Parameter Info
---@param Association integer
---@param ParameterName string
---@param LayerFunction MaterialFunctionInterface
---@return MaterialParameterInfo
function MaterialInterface.GetParameterInfo(Association, ParameterName, LayerFunction) end

---Get the associated nanite override material.
---@return MaterialInterface
function MaterialInterface.GetNaniteOverideMaterial() end

---Get Blend Mode
---@return integer
function MaterialInterface.GetBlendMode() end

---Walks up parent chain and finds the base Material that this is an instance of. Just calls the virtual GetMaterial()
---@return Material
function MaterialInterface.GetBaseMaterial() end

return MaterialInterface
