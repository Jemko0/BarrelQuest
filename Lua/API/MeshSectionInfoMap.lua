---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class MeshSectionInfoMap
---Map containing per-section settings for each section of each LOD.
---
--- Properties
---
---Maps an LOD+Section to the material it should render with.
---@field Map table<integer, MeshSectionInfo>
local MeshSectionInfoMap = {}

--- Constructor
---@return MeshSectionInfoMap
---@param Map table<integer, MeshSectionInfo>
function MeshSectionInfoMap.new(Map)
    local self = {}
    self.Map = Map
    return self
end

return MeshSectionInfoMap
