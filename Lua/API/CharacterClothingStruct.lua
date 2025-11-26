---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CharacterClothingStruct
---Character Clothing Struct
---
--- Properties
---@field Shirt_5_A432CA854FACE7348074D383BBD0C58A ClothingItemDataStruct[]
---@field Pants_7_B919134E43038E00BFBFA5ACA522FEBD ClothingItemDataStruct[]
---@field Feet_9_EDAEC91D4BECEA95BEFF8AABC953433E ClothingItemDataStruct[]
local CharacterClothingStruct = {}

--- Constructor
---@return CharacterClothingStruct
---@param Shirt_5_A432CA854FACE7348074D383BBD0C58A ClothingItemDataStruct[]
---@param Pants_7_B919134E43038E00BFBFA5ACA522FEBD ClothingItemDataStruct[]
---@param Feet_9_EDAEC91D4BECEA95BEFF8AABC953433E ClothingItemDataStruct[]
function CharacterClothingStruct.new(Shirt_5_A432CA854FACE7348074D383BBD0C58A, Pants_7_B919134E43038E00BFBFA5ACA522FEBD, Feet_9_EDAEC91D4BECEA95BEFF8AABC953433E)
    local self = {}
    self.Shirt_5_A432CA854FACE7348074D383BBD0C58A = Shirt_5_A432CA854FACE7348074D383BBD0C58A
    self.Pants_7_B919134E43038E00BFBFA5ACA522FEBD = Pants_7_B919134E43038E00BFBFA5ACA522FEBD
    self.Feet_9_EDAEC91D4BECEA95BEFF8AABC953433E = Feet_9_EDAEC91D4BECEA95BEFF8AABC953433E
    return self
end

return CharacterClothingStruct
