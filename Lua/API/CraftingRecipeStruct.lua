---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CraftingRecipeStruct
---Crafting Recipe Struct
---
--- Properties
---@field RecipeName_20_A567E2704450B7C8956CD88295AC65E6 string
---@field RecipeIcon_23_2FAEE7DB49CFEE606ECCB985899B97EB any
---@field Ingredients_39_3B63B5D04A5381CC1DF3E68949CD628B table<string, CraftingRecipeIngredientStruct>
---@field Result_15_C1D80B3546062BE31CE6DDB973A1AC8D CraftingResultStruct[]
---@field CraftingTime_29_F5F1AA814C3BA4CAA40349A128541B03 number
local CraftingRecipeStruct = {}
return CraftingRecipeStruct
