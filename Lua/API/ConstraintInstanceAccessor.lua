---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ConstraintInstanceAccessor
---Wrapping type around instance pointer to be returned per value in Blueprints
---
--- Properties
---
---@field Owner any
---@field Index integer
local ConstraintInstanceAccessor = {}

--- Constructor
---@return ConstraintInstanceAccessor
---@param Owner any
---@param Index integer
function ConstraintInstanceAccessor.new(Owner, Index)
    local self = {}
    self.Owner = Owner
    self.Index = Index
    return self
end

return ConstraintInstanceAccessor
