---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NamedSlotBinding
---Named Slot Binding
---
--- Properties
---
---@field Name string
---GUID of the NamedSlot is used as a secondary identifier to find a binding in case the name of NamedSlot has changed.
---@field Guid Guid
---@field Content Widget
local NamedSlotBinding = {}

--- Constructor
---@return NamedSlotBinding
---@param Name string
---@param Guid Guid
---@param Content Widget
function NamedSlotBinding.new(Name, Guid, Content)
    local self = {}
    self.Name = Name
    self.Guid = Guid
    self.Content = Content
    return self
end

return NamedSlotBinding
