---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class API_TEST_C : UserWidget
---API TEST
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field user EditableTextBox
---@field UniversalButton UniversalButton_C
---@field response MultiLineEditableTextBox
---@field pass EditableTextBox
local API_TEST_C = {}

--- Methods
---Set Response
---@param InText string
---@return nil
function API_TEST_C.setResponse(InText) end

---Niggers
---@param Status integer
---@param ResponseString string
---@return nil
function API_TEST_C.Niggers(Status, ResponseString) end

return API_TEST_C
