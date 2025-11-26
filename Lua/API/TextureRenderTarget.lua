---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class TextureRenderTarget : Texture
---Texture Render Target
---
--- Properties
---Will override FTextureRenderTarget2DResource::GetDisplayGamma if > 0.
---@field TargetGamma number
local TextureRenderTarget = {}

--- Methods
return TextureRenderTarget
