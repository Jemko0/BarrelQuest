---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RightClickMenuOption
---Right Click Menu Option
---
--- Properties
---@field OptionName_6_A59D68C1426DA07A5C3664B2F24B168A string
---@field OverrideColor_11_12C6477E44114EEA391C578D5D9C240F string
---@field ID_7_6EE840AC4847B81EA5A3DAAD2C61266C string
local RightClickMenuOption = {}

--- Constructor
---@return RightClickMenuOption
---@param OptionName_6_A59D68C1426DA07A5C3664B2F24B168A string
---@param OverrideColor_11_12C6477E44114EEA391C578D5D9C240F string
---@param ID_7_6EE840AC4847B81EA5A3DAAD2C61266C string
function RightClickMenuOption.new(OptionName_6_A59D68C1426DA07A5C3664B2F24B168A, OverrideColor_11_12C6477E44114EEA391C578D5D9C240F, ID_7_6EE840AC4847B81EA5A3DAAD2C61266C)
    local self = {}
    self.OptionName_6_A59D68C1426DA07A5C3664B2F24B168A = OptionName_6_A59D68C1426DA07A5C3664B2F24B168A
    self.OverrideColor_11_12C6477E44114EEA391C578D5D9C240F = OverrideColor_11_12C6477E44114EEA391C578D5D9C240F
    self.ID_7_6EE840AC4847B81EA5A3DAAD2C61266C = ID_7_6EE840AC4847B81EA5A3DAAD2C61266C
    return self
end

return RightClickMenuOption
