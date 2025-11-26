---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class WearingClothingData
---Wearing Clothing Data
---
--- Properties
---
---@field dirtLevel number
---@field wearLevel number
---@field wetLevel number
---@field insulationLevel number
---@field holes string[]
---@field clothingType EClothingType
local WearingClothingData = {}

--- Constructor
---@return WearingClothingData
---@param dirtLevel number
---@param wearLevel number
---@param wetLevel number
---@param insulationLevel number
---@param holes string[]
---@param clothingType EClothingType
function WearingClothingData.new(dirtLevel, wearLevel, wetLevel, insulationLevel, holes, clothingType)
    local self = {}
    self.dirtLevel = dirtLevel
    self.wearLevel = wearLevel
    self.wetLevel = wetLevel
    self.insulationLevel = insulationLevel
    self.holes = holes
    self.clothingType = clothingType
    return self
end

return WearingClothingData
