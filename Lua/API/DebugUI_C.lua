---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class DebugUI_C : UserWidget
---Debug UI
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field VerticalBox_0 VerticalBox
local DebugUI_C = {}

--- Methods
---Create
---@param New_Object Object
---@param New_Property_Name string
---@return nil
function DebugUI_C.create(New_Object, New_Property_Name) end

return DebugUI_C
