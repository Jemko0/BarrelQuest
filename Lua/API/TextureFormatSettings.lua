---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class TextureFormatSettings
---Collection of values that contribute to pixel format chosen for texture
---
--- Properties
---@field CompressionSettings integer
---@field CompressionNoAlpha boolean
---@field CompressionForceAlpha boolean
---@field CompressionNone boolean
---@field CompressionYCoCg boolean
---@field SRGB boolean
local TextureFormatSettings = {}
return TextureFormatSettings
