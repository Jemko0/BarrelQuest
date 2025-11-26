---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class TextureCollectionParameterValue
---Editable texture collection parameter.
---
--- Properties
---@field ParameterInfo MaterialParameterInfo
---@field ParameterValue TextureCollection
---@field ExpressionGUID Guid
local TextureCollectionParameterValue = {}

--- Constructor
---@return TextureCollectionParameterValue
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue TextureCollection
---@param ExpressionGUID Guid
function TextureCollectionParameterValue.new(ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return TextureCollectionParameterValue
