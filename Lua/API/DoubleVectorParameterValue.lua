---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class DoubleVectorParameterValue
---Editable vector parameter.
---
--- Properties
---
---@field ParameterInfo MaterialParameterInfo
---LWC_TODO: Blueprint?
---@field ParameterValue Vector4d
---@field ExpressionGUID Guid
local DoubleVectorParameterValue = {}

--- Constructor
---@return DoubleVectorParameterValue
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue Vector4d
---@param ExpressionGUID Guid
function DoubleVectorParameterValue.new(ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return DoubleVectorParameterValue
