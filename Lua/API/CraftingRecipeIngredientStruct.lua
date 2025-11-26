---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CraftingRecipeIngredientStruct
---Crafting Recipe Ingredient Struct
---
--- Properties
---
---@field protected Tag_20_22C1B90A4FFC44301B978EAE91537E64 TagDataAsset_C
---@field protected Amount_17_B68E59F94B4D640E02476E9CCDD369AD integer
---@field protected IsTag_14_379180984422AD747D93DCB1EED46FFF boolean
local CraftingRecipeIngredientStruct = {}

--- Constructor
---@return CraftingRecipeIngredientStruct
---@param Tag_20_22C1B90A4FFC44301B978EAE91537E64 TagDataAsset_C
---@param Amount_17_B68E59F94B4D640E02476E9CCDD369AD integer
---@param IsTag_14_379180984422AD747D93DCB1EED46FFF boolean
function CraftingRecipeIngredientStruct.new(Tag_20_22C1B90A4FFC44301B978EAE91537E64, Amount_17_B68E59F94B4D640E02476E9CCDD369AD, IsTag_14_379180984422AD747D93DCB1EED46FFF)
    local self = {}
    self.Tag_20_22C1B90A4FFC44301B978EAE91537E64 = Tag_20_22C1B90A4FFC44301B978EAE91537E64
    self.Amount_17_B68E59F94B4D640E02476E9CCDD369AD = Amount_17_B68E59F94B4D640E02476E9CCDD369AD
    self.IsTag_14_379180984422AD747D93DCB1EED46FFF = IsTag_14_379180984422AD747D93DCB1EED46FFF
    return self
end

return CraftingRecipeIngredientStruct
