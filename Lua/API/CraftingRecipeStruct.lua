---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

--- Constructor
---@return CraftingRecipeStruct
---@param RecipeName_20_A567E2704450B7C8956CD88295AC65E6 string
---@param RecipeIcon_23_2FAEE7DB49CFEE606ECCB985899B97EB any
---@param Ingredients_39_3B63B5D04A5381CC1DF3E68949CD628B table<string, CraftingRecipeIngredientStruct>
---@param Result_15_C1D80B3546062BE31CE6DDB973A1AC8D CraftingResultStruct[]
---@param CraftingTime_29_F5F1AA814C3BA4CAA40349A128541B03 number
function CraftingRecipeStruct.new(RecipeName_20_A567E2704450B7C8956CD88295AC65E6, RecipeIcon_23_2FAEE7DB49CFEE606ECCB985899B97EB, Ingredients_39_3B63B5D04A5381CC1DF3E68949CD628B, Result_15_C1D80B3546062BE31CE6DDB973A1AC8D, CraftingTime_29_F5F1AA814C3BA4CAA40349A128541B03)
    local self = {}
    self.RecipeName_20_A567E2704450B7C8956CD88295AC65E6 = RecipeName_20_A567E2704450B7C8956CD88295AC65E6
    self.RecipeIcon_23_2FAEE7DB49CFEE606ECCB985899B97EB = RecipeIcon_23_2FAEE7DB49CFEE606ECCB985899B97EB
    self.Ingredients_39_3B63B5D04A5381CC1DF3E68949CD628B = Ingredients_39_3B63B5D04A5381CC1DF3E68949CD628B
    self.Result_15_C1D80B3546062BE31CE6DDB973A1AC8D = Result_15_C1D80B3546062BE31CE6DDB973A1AC8D
    self.CraftingTime_29_F5F1AA814C3BA4CAA40349A128541B03 = CraftingTime_29_F5F1AA814C3BA4CAA40349A128541B03
    return self
end

return CraftingRecipeStruct
