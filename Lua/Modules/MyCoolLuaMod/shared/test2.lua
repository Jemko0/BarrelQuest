---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class InventoryItemStruct
---Inventory Item Struct
---
--- Properties
---@field ItemID string
---@field Amount integer
---@field Data string[]
---@field ExtSubcontainer ExternalSubcontainer_C
local InventoryItemStruct = {}

--- Constructor
---@return InventoryItemStruct
---@param ItemID string
---@param Amount integer
---@param Data string[]
---@param ExtSubcontainer ExternalSubcontainer_C

function InventoryItemStruct.new(ItemID, Amount, Data, ExtSubcontainer)
    local self = {}
    self.ItemID_7_DF6FEDCF4FDB0BF7EF0B2F894916B840 = ItemID
    self.Amount_5_F0A028CE423624CCED3A53A7AB83EAE7 = Amount
    self.Data_23_8B1C6D1E44A4E61BA4E2FF887765F680 = Data
    self.ExtSubcontainer_20_F0E53FD2495A861E564E3681AA5A59E7 = ExtSubcontainer
    return self
end

return InventoryItemStruct
