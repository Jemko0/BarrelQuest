---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ProcMeshSection
---One section of the procedural mesh. Each material has its own section.
---
--- Properties
---Vertex buffer for this section
---@field ProcVertexBuffer ProcMeshVertex[]
---Index buffer for this section
---@field ProcIndexBuffer integer[]
---Local bounding box of section
---@field SectionLocalBox Box
---Should we build collision data for triangles in this section
---@field bEnableCollision boolean
---Should we display this section
---@field bSectionVisible boolean
local ProcMeshSection = {}
return ProcMeshSection
