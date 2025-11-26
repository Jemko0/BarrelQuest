---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Key
---Key
---
--- Properties
---
---@field KeyName string
local Key = {}

--- Constructor
---@return Key
---@param KeyName string
function Key.new(KeyName)
    local self = {}
    self.KeyName = KeyName
    return self
end

return Key
