---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class GeomSelection
---Selection information for geometry mode
---
--- Properties
---@field Type integer
---EGeometrySelectionType_
---@field Index integer
---Index into the geometry data structures
---@field SelectionIndex integer
local GeomSelection = {}
return GeomSelection
