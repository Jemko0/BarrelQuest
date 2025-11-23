---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

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
return FormatArgumentData
