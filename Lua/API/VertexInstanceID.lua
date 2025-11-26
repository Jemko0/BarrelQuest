---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class VertexInstanceID
---Vertex Instance ID
---
--- Properties
---
---The actual mesh element index this ID represents.  Read-only.
---@field IDValue integer
local VertexInstanceID = {}

--- Constructor
---@return VertexInstanceID
---@param IDValue integer
function VertexInstanceID.new(IDValue)
    local self = {}
    self.IDValue = IDValue
    return self
end

return VertexInstanceID
