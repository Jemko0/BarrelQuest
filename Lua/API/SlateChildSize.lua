---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SlateChildSize
---A struct exposing size param related properties to UMG.
---
--- Properties
---The parameter of the size rule.
---@field Value number
---The sizing rule of the content.
---@field SizeRule integer
local SlateChildSize = {}

--- Constructor
---@return SlateChildSize
---@param Value number
---@param SizeRule integer
function SlateChildSize.new(Value, SizeRule)
    local self = {}
    self.Value = Value
    self.SizeRule = SizeRule
    return self
end

return SlateChildSize
