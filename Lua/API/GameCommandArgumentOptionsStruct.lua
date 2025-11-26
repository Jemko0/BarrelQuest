---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class GameCommandArgumentOptionsStruct
---Game Command Argument Options Struct
---
--- Properties
---@field argType_4_E816316540C5BAE1CD8E0C98F85FC262 integer
---@field isOptional_3_1B8F2D3D4BAD8877587A93B235F6FF56 boolean
---@field defaultValue_8_43BD092E4F47433FEE41E1A89990E75B string
local GameCommandArgumentOptionsStruct = {}

--- Constructor
---@return GameCommandArgumentOptionsStruct
---@param argType_4_E816316540C5BAE1CD8E0C98F85FC262 integer
---@param isOptional_3_1B8F2D3D4BAD8877587A93B235F6FF56 boolean
---@param defaultValue_8_43BD092E4F47433FEE41E1A89990E75B string
function GameCommandArgumentOptionsStruct.new(argType_4_E816316540C5BAE1CD8E0C98F85FC262, isOptional_3_1B8F2D3D4BAD8877587A93B235F6FF56, defaultValue_8_43BD092E4F47433FEE41E1A89990E75B)
    local self = {}
    self.argType_4_E816316540C5BAE1CD8E0C98F85FC262 = argType_4_E816316540C5BAE1CD8E0C98F85FC262
    self.isOptional_3_1B8F2D3D4BAD8877587A93B235F6FF56 = isOptional_3_1B8F2D3D4BAD8877587A93B235F6FF56
    self.defaultValue_8_43BD092E4F47433FEE41E1A89990E75B = defaultValue_8_43BD092E4F47433FEE41E1A89990E75B
    return self
end

return GameCommandArgumentOptionsStruct
