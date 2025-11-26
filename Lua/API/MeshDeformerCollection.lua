---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MeshDeformerCollection : DataAsset
---A simple collection of Mesh Deformers
---
--- Properties
---@field Description string
---@field MeshDeformers any[]
---@field MeshDeformerCollections MeshDeformerCollection[]
local MeshDeformerCollection = {}

--- Methods
return MeshDeformerCollection
