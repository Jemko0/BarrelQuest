---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class MaterialParameterInfo
---Material Parameter Info
---
--- Properties
---
---@field Name string
---Whether this is a global parameter, or part of a layer or blend
---@field Association integer
---Layer or blend index this parameter is part of. INDEX_NONE for global parameters.
---@field Index integer
local MaterialParameterInfo = {}

--- Constructor
---@return MaterialParameterInfo
---@param Name string
---@param Association integer
---@param Index integer
function MaterialParameterInfo.new(Name, Association, Index)
    local self = {}
    self.Name = Name
    self.Association = Association
    self.Index = Index
    return self
end

return MaterialParameterInfo
