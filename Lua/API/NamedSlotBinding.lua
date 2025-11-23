---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NamedSlotBinding
---Named Slot Binding
---
--- Properties
---@field Name string
---GUID of the NamedSlot is used as a secondary identifier to find a binding in case the name of NamedSlot has changed.
---@field Guid Guid
---@field Content Widget
local NamedSlotBinding = {}
return NamedSlotBinding
