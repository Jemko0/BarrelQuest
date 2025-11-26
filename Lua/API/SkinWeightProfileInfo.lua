---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SkinWeightProfileInfo
---Structure storing user facing properties, and is used to identify profiles at the SkeletalMesh level
---
--- Properties
---
---Name of the Skin Weight Profile
---@field Name string
---Whether or not this Profile should be considered the Default loaded for specific LODs rather than the original Skin Weights of the Skeletal Mesh
---@field DefaultProfile PerPlatformBool
---When DefaultProfile is set any LOD below this LOD Index will override the Skin Weights of the Skeletal Mesh with the Skin Weights from this Profile
---@field DefaultProfileFromLODIndex PerPlatformInt
---@field PerLODSourceFiles table<integer, string>
local SkinWeightProfileInfo = {}

--- Constructor
---@return SkinWeightProfileInfo
---@param Name string
---@param DefaultProfile PerPlatformBool
---@param DefaultProfileFromLODIndex PerPlatformInt
---@param PerLODSourceFiles table<integer, string>
function SkinWeightProfileInfo.new(Name, DefaultProfile, DefaultProfileFromLODIndex, PerLODSourceFiles)
    local self = {}
    self.Name = Name
    self.DefaultProfile = DefaultProfile
    self.DefaultProfileFromLODIndex = DefaultProfileFromLODIndex
    self.PerLODSourceFiles = PerLODSourceFiles
    return self
end

return SkinWeightProfileInfo
