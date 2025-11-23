---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class KeyBind
---Struct containing mappings for legacy method of binding keys to exec commands.
---
--- Properties
---The key to be bound to the command
---@field Key Key
---The command to execute when the key is pressed/released
---@field Command string
---Whether the control key needs to be held when the key event occurs
---@field Control boolean
---Whether the shift key needs to be held when the key event occurs
---@field Shift boolean
---Whether the alt key needs to be held when the key event occurs
---@field Alt boolean
---Whether the command key needs to be held when the key event occurs
---@field Cmd boolean
---Whether the control key must not be held when the key event occurs
---@field bIgnoreCtrl boolean
---Whether the shift key must not be held when the key event occurs
---@field bIgnoreShift boolean
---Whether the alt key must not be held when the key event occurs
---@field bIgnoreAlt boolean
---Whether the command key must not be held when the key event occurs
---@field bIgnoreCmd boolean
---@field bDisabled boolean
local KeyBind = {}
return KeyBind
