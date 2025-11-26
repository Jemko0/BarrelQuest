---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SkelMeshComponentLODInfo
---LOD specific setup for the skeletal mesh component.
---
--- Properties
---Material corresponds to section. To show/hide each section, use this.
---@field HiddenMaterials boolean[]
local SkelMeshComponentLODInfo = {}
return SkelMeshComponentLODInfo
