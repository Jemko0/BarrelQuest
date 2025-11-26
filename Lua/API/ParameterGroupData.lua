---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ParameterGroupData
---Parameter Group Data
---
--- Properties
---
---@field GroupName string
---@field GroupSortPriority integer
local ParameterGroupData = {}

--- Constructor
---@return ParameterGroupData
---@param GroupName string
---@param GroupSortPriority integer
function ParameterGroupData.new(GroupName, GroupSortPriority)
    local self = {}
    self.GroupName = GroupName
    self.GroupSortPriority = GroupSortPriority
    return self
end

return ParameterGroupData
