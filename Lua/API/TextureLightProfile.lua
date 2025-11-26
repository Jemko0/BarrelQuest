---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TextureLightProfile : Texture2D
---Texture Light Profile
---
--- Properties
---
---Light brightness in Candelas, imported from IES profile, <= 0 if the profile is used for masking only. Use with InverseSquareFalloff.
---@field Brightness number
---Multiplier to map texture value to result to integrate over the sphere to 1.0f
---@field TextureMultiplier number
local TextureLightProfile = {}

--- Methods
return TextureLightProfile
