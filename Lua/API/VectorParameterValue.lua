---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class VectorParameterValue
---Editable vector parameter.
---
--- Properties
---
---@field ParameterName string
---@field ParameterInfo MaterialParameterInfo
---@field ParameterValue LinearColor
---@field ExpressionGUID Guid
local VectorParameterValue = {}

--- Constructor
---@return VectorParameterValue
---@param ParameterName string
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue LinearColor
---@param ExpressionGUID Guid
function VectorParameterValue.new(ParameterName, ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterName = ParameterName
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return VectorParameterValue
