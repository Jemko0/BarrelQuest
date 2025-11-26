---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class InventoryItemStruct
---Inventory Item Struct
---
--- Properties
---
---@field protected ItemID_7_DF6FEDCF4FDB0BF7EF0B2F894916B840 string
---@field protected Amount_5_F0A028CE423624CCED3A53A7AB83EAE7 integer
---@field protected Data_23_8B1C6D1E44A4E61BA4E2FF887765F680 string[]
---@field protected ExtSubcontainer_20_F0E53FD2495A861E564E3681AA5A59E7 ExternalSubcontainer_C
local InventoryItemStruct = {}

--- Constructor
---@return InventoryItemStruct
---@param ItemID_7_DF6FEDCF4FDB0BF7EF0B2F894916B840 string
---@param Amount_5_F0A028CE423624CCED3A53A7AB83EAE7 integer
---@param Data_23_8B1C6D1E44A4E61BA4E2FF887765F680 string[]
---@param ExtSubcontainer_20_F0E53FD2495A861E564E3681AA5A59E7 ExternalSubcontainer_C
function InventoryItemStruct.new(ItemID_7_DF6FEDCF4FDB0BF7EF0B2F894916B840, Amount_5_F0A028CE423624CCED3A53A7AB83EAE7, Data_23_8B1C6D1E44A4E61BA4E2FF887765F680, ExtSubcontainer_20_F0E53FD2495A861E564E3681AA5A59E7)
    local self = {}
    self.ItemID_7_DF6FEDCF4FDB0BF7EF0B2F894916B840 = ItemID_7_DF6FEDCF4FDB0BF7EF0B2F894916B840
    self.Amount_5_F0A028CE423624CCED3A53A7AB83EAE7 = Amount_5_F0A028CE423624CCED3A53A7AB83EAE7
    self.Data_23_8B1C6D1E44A4E61BA4E2FF887765F680 = Data_23_8B1C6D1E44A4E61BA4E2FF887765F680
    self.ExtSubcontainer_20_F0E53FD2495A861E564E3681AA5A59E7 = ExtSubcontainer_20_F0E53FD2495A861E564E3681AA5A59E7
    return self
end

return InventoryItemStruct
