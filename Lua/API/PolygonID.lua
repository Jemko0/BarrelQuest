---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PolygonID
---Polygon ID
---
--- Properties
---
---The actual mesh element index this ID represents.  Read-only.
---@field IDValue integer
local PolygonID = {}

--- Constructor
---@return PolygonID
---@param IDValue integer
function PolygonID.new(IDValue)
    local self = {}
    self.IDValue = IDValue
    return self
end

return PolygonID
