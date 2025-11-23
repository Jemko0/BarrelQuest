---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class TextureSourceColorSettings
---Texture Source Color Settings
---
--- Properties
---Source encoding of the texture, exposing more options than just sRGB.
---@field EncodingOverride ETextureSourceEncoding
---Source color space of the texture.
---@field ColorSpace ETextureColorSpace
---Red chromaticity coordinate of the source color space.
---@field RedChromaticityCoordinate Vector2D
---Green chromaticity coordinate of the source color space.
---@field GreenChromaticityCoordinate Vector2D
---Blue chromaticity coordinate of the source color space.
---@field BlueChromaticityCoordinate Vector2D
---White chromaticity coordinate of the source color space.
---@field WhiteChromaticityCoordinate Vector2D
---Chromatic adaption method applied if the source white point differs from the working color space white point.
---@field ChromaticAdaptationMethod ETextureChromaticAdaptationMethod
local TextureSourceColorSettings = {}
return TextureSourceColorSettings
