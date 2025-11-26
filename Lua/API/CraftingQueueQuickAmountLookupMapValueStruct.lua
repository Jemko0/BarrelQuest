---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CraftingQueueQuickAmountLookupMapValueStruct
---Crafting Queue Quick Amount Lookup Map Value Struct
---
--- Properties
---@field Amount_2_A41B59BB447A147A252EB9AF9BCD3F5D integer
---@field ArrayIndex_4_2CA6D95045E28EA5E6EF67939F24DD40 integer
local CraftingQueueQuickAmountLookupMapValueStruct = {}

--- Constructor
---@return CraftingQueueQuickAmountLookupMapValueStruct
---@param Amount_2_A41B59BB447A147A252EB9AF9BCD3F5D integer
---@param ArrayIndex_4_2CA6D95045E28EA5E6EF67939F24DD40 integer
function CraftingQueueQuickAmountLookupMapValueStruct.new(Amount_2_A41B59BB447A147A252EB9AF9BCD3F5D, ArrayIndex_4_2CA6D95045E28EA5E6EF67939F24DD40)
    local self = {}
    self.Amount_2_A41B59BB447A147A252EB9AF9BCD3F5D = Amount_2_A41B59BB447A147A252EB9AF9BCD3F5D
    self.ArrayIndex_4_2CA6D95045E28EA5E6EF67939F24DD40 = ArrayIndex_4_2CA6D95045E28EA5E6EF67939F24DD40
    return self
end

return CraftingQueueQuickAmountLookupMapValueStruct
