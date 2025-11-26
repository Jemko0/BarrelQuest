---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class EdGraphPinReference
---Ed Graph Pin Reference
---
--- Properties
---The node that owns the pin referred to by this struct. Updated at Set and Save time.
---@field OwningNode any
---The pin's unique ID. Updated at Set and Save time.
---@field PinId Guid
local EdGraphPinReference = {}

--- Constructor
---@return EdGraphPinReference
---@param OwningNode any
---@param PinId Guid
function EdGraphPinReference.new(OwningNode, PinId)
    local self = {}
    self.OwningNode = OwningNode
    self.PinId = PinId
    return self
end

return EdGraphPinReference
