---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class GameCommandStruct
---Game Command Struct
---
--- Properties
---@field MinPermissionLevel_3_1D83C25745F8AF3AE9EE2EAD373A5A4C integer
---@field Arguments_8_C13E4372422AE89B64309EB969BE7295 GameCommandArgumentStruct
local GameCommandStruct = {}

--- Constructor
---@return GameCommandStruct
---@param MinPermissionLevel_3_1D83C25745F8AF3AE9EE2EAD373A5A4C integer
---@param Arguments_8_C13E4372422AE89B64309EB969BE7295 GameCommandArgumentStruct
function GameCommandStruct.new(MinPermissionLevel_3_1D83C25745F8AF3AE9EE2EAD373A5A4C, Arguments_8_C13E4372422AE89B64309EB969BE7295)
    local self = {}
    self.MinPermissionLevel_3_1D83C25745F8AF3AE9EE2EAD373A5A4C = MinPermissionLevel_3_1D83C25745F8AF3AE9EE2EAD373A5A4C
    self.Arguments_8_C13E4372422AE89B64309EB969BE7295 = Arguments_8_C13E4372422AE89B64309EB969BE7295
    return self
end

return GameCommandStruct
