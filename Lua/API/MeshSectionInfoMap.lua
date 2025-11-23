---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class MeshSectionInfoMap
---Map containing per-section settings for each section of each LOD.
---
--- Properties
---Maps an LOD+Section to the material it should render with.
---@field Map table<integer, MeshSectionInfo>
local MeshSectionInfoMap = {}
return MeshSectionInfoMap
