---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MaterialTextureInfo
---This struct holds data about how a texture is sampled within a material.
---
--- Properties
---The scale used when sampling the texture
---@field SamplingScale number
---The coordinate index used when sampling the texture
---@field UVChannelIndex integer
---The texture name. Used for debugging and also to for quick matching of the entries.
---@field TextureName string
---The reference to the texture, used to keep the TextureName valid even if it gets renamed.
---@field TextureReference SoftObjectPath
---The texture index in the material resource the data was built from.
---This must be transient as it depends on which shader map was used for the build.
---@field TextureIndex integer
local MaterialTextureInfo = {}

--- Constructor
---@return MaterialTextureInfo
---@param SamplingScale number
---@param UVChannelIndex integer
---@param TextureName string
---@param TextureReference SoftObjectPath
---@param TextureIndex integer
function MaterialTextureInfo.new(SamplingScale, UVChannelIndex, TextureName, TextureReference, TextureIndex)
    local self = {}
    self.SamplingScale = SamplingScale
    self.UVChannelIndex = UVChannelIndex
    self.TextureName = TextureName
    self.TextureReference = TextureReference
    self.TextureIndex = TextureIndex
    return self
end

return MaterialTextureInfo
