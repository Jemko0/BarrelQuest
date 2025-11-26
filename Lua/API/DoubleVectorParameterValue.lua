---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class DoubleVectorParameterValue
---Editable vector parameter.
---
--- Properties
---@field ParameterInfo MaterialParameterInfo
---LWC_TODO: Blueprint?
---@field ParameterValue Vector4d
---@field ExpressionGUID Guid
local DoubleVectorParameterValue = {}
return DoubleVectorParameterValue
