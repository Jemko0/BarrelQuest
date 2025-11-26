---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ProcMeshSection
---One section of the procedural mesh. Each material has its own section.
---
--- Properties
---
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

--- Constructor
---@return ProcMeshSection
---@param ProcVertexBuffer ProcMeshVertex[]
---@param ProcIndexBuffer integer[]
---@param SectionLocalBox Box
---@param bEnableCollision boolean
---@param bSectionVisible boolean
function ProcMeshSection.new(ProcVertexBuffer, ProcIndexBuffer, SectionLocalBox, bEnableCollision, bSectionVisible)
    local self = {}
    self.ProcVertexBuffer = ProcVertexBuffer
    self.ProcIndexBuffer = ProcIndexBuffer
    self.SectionLocalBox = SectionLocalBox
    self.bEnableCollision = bEnableCollision
    self.bSectionVisible = bSectionVisible
    return self
end

return ProcMeshSection
