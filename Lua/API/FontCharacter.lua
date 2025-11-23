---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class FontCharacter
---This struct is serialized using native serialization so any changes to it require a package version bump.
---
--- Properties
---@field StartU integer
---@field StartV integer
---@field USize integer
---@field VSize integer
---@field TextureIndex integer
---@field VerticalOffset integer
local FontCharacter = {}
return FontCharacter
