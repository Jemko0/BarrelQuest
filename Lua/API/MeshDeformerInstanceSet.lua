---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class MeshDeformerInstanceSet
---Same as FMeshDeformerSet, except for mesh deformer instances
---
--- Properties
---
---@field DeformerInstances MeshDeformerInstance[]
local MeshDeformerInstanceSet = {}

--- Constructor
---@return MeshDeformerInstanceSet
---@param DeformerInstances MeshDeformerInstance[]
function MeshDeformerInstanceSet.new(DeformerInstances)
    local self = {}
    self.DeformerInstances = DeformerInstances
    return self
end

return MeshDeformerInstanceSet
