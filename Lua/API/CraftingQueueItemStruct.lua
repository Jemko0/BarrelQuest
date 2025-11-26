---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CraftingQueueItemStruct
---Crafting Queue Item Struct
---
--- Properties
---@field RecipeID_14_699A0D284650786E5F2E67ACB189C507 string
---@field CraftingTime_8_CC37469A40212EEA8EA488A0AD8DA761 number
---@field EndTime_5_5DA823184E2F5A98C02F2DAC6254F93D integer
---@field Amount_11_4254A68C460685C751B578BA2C570B45 integer
local CraftingQueueItemStruct = {}

--- Constructor
---@return CraftingQueueItemStruct
---@param RecipeID_14_699A0D284650786E5F2E67ACB189C507 string
---@param CraftingTime_8_CC37469A40212EEA8EA488A0AD8DA761 number
---@param EndTime_5_5DA823184E2F5A98C02F2DAC6254F93D integer
---@param Amount_11_4254A68C460685C751B578BA2C570B45 integer
function CraftingQueueItemStruct.new(RecipeID_14_699A0D284650786E5F2E67ACB189C507, CraftingTime_8_CC37469A40212EEA8EA488A0AD8DA761, EndTime_5_5DA823184E2F5A98C02F2DAC6254F93D, Amount_11_4254A68C460685C751B578BA2C570B45)
    local self = {}
    self.RecipeID_14_699A0D284650786E5F2E67ACB189C507 = RecipeID_14_699A0D284650786E5F2E67ACB189C507
    self.CraftingTime_8_CC37469A40212EEA8EA488A0AD8DA761 = CraftingTime_8_CC37469A40212EEA8EA488A0AD8DA761
    self.EndTime_5_5DA823184E2F5A98C02F2DAC6254F93D = EndTime_5_5DA823184E2F5A98C02F2DAC6254F93D
    self.Amount_11_4254A68C460685C751B578BA2C570B45 = Amount_11_4254A68C460685C751B578BA2C570B45
    return self
end

return CraftingQueueItemStruct
