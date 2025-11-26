---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TextureFormatSettings
---Collection of values that contribute to pixel format chosen for texture
---
--- Properties
---
---@field CompressionSettings integer
---@field CompressionNoAlpha boolean
---@field CompressionForceAlpha boolean
---@field CompressionNone boolean
---@field CompressionYCoCg boolean
---@field SRGB boolean
local TextureFormatSettings = {}

--- Constructor
---@return TextureFormatSettings
---@param CompressionSettings integer
---@param CompressionNoAlpha boolean
---@param CompressionForceAlpha boolean
---@param CompressionNone boolean
---@param CompressionYCoCg boolean
---@param SRGB boolean
function TextureFormatSettings.new(CompressionSettings, CompressionNoAlpha, CompressionForceAlpha, CompressionNone, CompressionYCoCg, SRGB)
    local self = {}
    self.CompressionSettings = CompressionSettings
    self.CompressionNoAlpha = CompressionNoAlpha
    self.CompressionForceAlpha = CompressionForceAlpha
    self.CompressionNone = CompressionNone
    self.CompressionYCoCg = CompressionYCoCg
    self.SRGB = SRGB
    return self
end

return TextureFormatSettings
