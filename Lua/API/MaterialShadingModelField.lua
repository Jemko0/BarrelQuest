---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class MaterialShadingModelField
---Wrapper for a bitfield of shading models. A material contains one of these to describe what possible shading models can be used by that material.
---
--- Properties
---
---@field ShadingModelField any
local MaterialShadingModelField = {}

--- Constructor
---@return MaterialShadingModelField
---@param ShadingModelField any
function MaterialShadingModelField.new(ShadingModelField)
    local self = {}
    self.ShadingModelField = ShadingModelField
    return self
end

return MaterialShadingModelField
