---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class DynamicPropertyPath
---Dynamic Property Path
---
--- Properties
---Path segments for this path
---@field Segments PropertyPathSegment[]
---Cached function for function-terminated paths
---@field CachedFunction Function
local DynamicPropertyPath = {}
return DynamicPropertyPath
