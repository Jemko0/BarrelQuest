---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CachedKeyToActionInfo
---Struct that exists to store runtime cache to make key to action lookups faster.
---
--- Properties
---Which PlayerInput object this has been built for
---@field PlayerInput any
local CachedKeyToActionInfo = {}
return CachedKeyToActionInfo
