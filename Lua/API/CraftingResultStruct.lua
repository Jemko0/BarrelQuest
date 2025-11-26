---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CraftingResultStruct
---Crafting Result Struct
---
--- Properties
---@field ResultingItem_2_FD6C1EC742DDE36A1441578BB98178B1 string
---@field Amount_5_B290DA0443F5D0EA6F0BA48AE753E63E integer
---@field SuccessChance_10_2F0B89284EDBC895452A5D9379A237B7 number
---@field FailedResult_11_A3C3E69245970FE0BC04DEBCB54F4B02 string
---@field FailedResultAmount_14_FB6764614B65F3ED0AE92A88CCCEF4AD integer
local CraftingResultStruct = {}

--- Constructor
---@return CraftingResultStruct
---@param ResultingItem_2_FD6C1EC742DDE36A1441578BB98178B1 string
---@param Amount_5_B290DA0443F5D0EA6F0BA48AE753E63E integer
---@param SuccessChance_10_2F0B89284EDBC895452A5D9379A237B7 number
---@param FailedResult_11_A3C3E69245970FE0BC04DEBCB54F4B02 string
---@param FailedResultAmount_14_FB6764614B65F3ED0AE92A88CCCEF4AD integer
function CraftingResultStruct.new(ResultingItem_2_FD6C1EC742DDE36A1441578BB98178B1, Amount_5_B290DA0443F5D0EA6F0BA48AE753E63E, SuccessChance_10_2F0B89284EDBC895452A5D9379A237B7, FailedResult_11_A3C3E69245970FE0BC04DEBCB54F4B02, FailedResultAmount_14_FB6764614B65F3ED0AE92A88CCCEF4AD)
    local self = {}
    self.ResultingItem_2_FD6C1EC742DDE36A1441578BB98178B1 = ResultingItem_2_FD6C1EC742DDE36A1441578BB98178B1
    self.Amount_5_B290DA0443F5D0EA6F0BA48AE753E63E = Amount_5_B290DA0443F5D0EA6F0BA48AE753E63E
    self.SuccessChance_10_2F0B89284EDBC895452A5D9379A237B7 = SuccessChance_10_2F0B89284EDBC895452A5D9379A237B7
    self.FailedResult_11_A3C3E69245970FE0BC04DEBCB54F4B02 = FailedResult_11_A3C3E69245970FE0BC04DEBCB54F4B02
    self.FailedResultAmount_14_FB6764614B65F3ED0AE92A88CCCEF4AD = FailedResultAmount_14_FB6764614B65F3ED0AE92A88CCCEF4AD
    return self
end

return CraftingResultStruct
