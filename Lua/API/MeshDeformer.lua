---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class MeshDeformer
---Base class for mesh deformer assets.
---Mesh deformers can be added to mesh components to implement flexible deformation systems.
---A UMeshDeformer needs to implement creation of a UMeshDeformerInstance which will apply deformer actions and store deformer state.
---
--- Properties
---
local MeshDeformer = {}

--- Methods
return MeshDeformer
