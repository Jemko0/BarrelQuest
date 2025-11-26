---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class TextureParameterValue
---Editable texture parameter.
---
--- Properties
---@field ParameterName string
---@field ParameterInfo MaterialParameterInfo
---@field ParameterValue Texture
---@field ExpressionGUID Guid
local TextureParameterValue = {}

--- Constructor
---@return TextureParameterValue
---@param ParameterName string
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue Texture
---@param ExpressionGUID Guid
function TextureParameterValue.new(ParameterName, ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterName = ParameterName
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return TextureParameterValue
