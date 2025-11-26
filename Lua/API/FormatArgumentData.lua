---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class FormatArgumentData
---Used to pass argument/value pairs into FText::Format.
---The full C++ struct is located here: Engine\Source\Runtime\Core\Public\Internationalization\Text.h
---
--- Properties
---@field ArgumentName string
---@field ArgumentValueType integer
---@field ArgumentValue string
---@field ArgumentValueInt integer
---@field ArgumentValueFloat number
---@field ArgumentValueDouble number
---@field ArgumentValueGender ETextGender
local FormatArgumentData = {}

--- Constructor
---@return FormatArgumentData
---@param ArgumentName string
---@param ArgumentValueType integer
---@param ArgumentValue string
---@param ArgumentValueInt integer
---@param ArgumentValueFloat number
---@param ArgumentValueDouble number
---@param ArgumentValueGender ETextGender
function FormatArgumentData.new(ArgumentName, ArgumentValueType, ArgumentValue, ArgumentValueInt, ArgumentValueFloat, ArgumentValueDouble, ArgumentValueGender)
    local self = {}
    self.ArgumentName = ArgumentName
    self.ArgumentValueType = ArgumentValueType
    self.ArgumentValue = ArgumentValue
    self.ArgumentValueInt = ArgumentValueInt
    self.ArgumentValueFloat = ArgumentValueFloat
    self.ArgumentValueDouble = ArgumentValueDouble
    self.ArgumentValueGender = ArgumentValueGender
    return self
end

return FormatArgumentData
