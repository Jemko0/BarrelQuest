---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class FontParameterValue
---Editable font parameter.
---
--- Properties
---@field ParameterName string
---@field ParameterInfo MaterialParameterInfo
---@field FontValue Font
---@field FontPage integer
---@field ExpressionGUID Guid
local FontParameterValue = {}

--- Constructor
---@return FontParameterValue
---@param ParameterName string
---@param ParameterInfo MaterialParameterInfo
---@param FontValue Font
---@param FontPage integer
---@param ExpressionGUID Guid
function FontParameterValue.new(ParameterName, ParameterInfo, FontValue, FontPage, ExpressionGUID)
    local self = {}
    self.ParameterName = ParameterName
    self.ParameterInfo = ParameterInfo
    self.FontValue = FontValue
    self.FontPage = FontPage
    self.ExpressionGUID = ExpressionGUID
    return self
end

return FontParameterValue
