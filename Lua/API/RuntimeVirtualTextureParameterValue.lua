---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RuntimeVirtualTextureParameterValue
---Editable runtime virtual texture parameter.
---
--- Properties
---@field ParameterInfo MaterialParameterInfo
---@field ParameterValue RuntimeVirtualTexture
---@field ExpressionGUID Guid
local RuntimeVirtualTextureParameterValue = {}

--- Constructor
---@return RuntimeVirtualTextureParameterValue
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue RuntimeVirtualTexture
---@param ExpressionGUID Guid
function RuntimeVirtualTextureParameterValue.new(ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return RuntimeVirtualTextureParameterValue
