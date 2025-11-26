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
return TextureParameterValue
