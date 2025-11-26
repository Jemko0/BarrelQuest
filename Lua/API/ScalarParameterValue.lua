---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ScalarParameterValue
---Scalar Parameter Value
---
--- Properties
---@field ParameterName string
---@field AtlasData ScalarParameterAtlasInstanceData
---@field ParameterInfo MaterialParameterInfo
---@field ParameterValue number
---@field ExpressionGUID Guid
local ScalarParameterValue = {}

--- Constructor
---@return ScalarParameterValue
---@param ParameterName string
---@param AtlasData ScalarParameterAtlasInstanceData
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue number
---@param ExpressionGUID Guid
function ScalarParameterValue.new(ParameterName, AtlasData, ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterName = ParameterName
    self.AtlasData = AtlasData
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return ScalarParameterValue
