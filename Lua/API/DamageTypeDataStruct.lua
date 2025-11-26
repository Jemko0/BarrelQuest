---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class DamageTypeDataStruct
---Damage Type Data Struct
---
--- Properties
---
---@field protected Flags_16_AABAF2BE4B0639FAAAFD1EBF68488F24 table<integer, number>
---@field protected Knockback_19_11EFC7B6411931A6088FD790FB6BB901 number
---@field protected HitHardness_26_B4B247EA4DD49EA49B03F4AD9DACDBA2 number
---@field protected HitTextureAlphaMask_23_3513A14B450382FC9281B98D7C6FF2B7 Texture2D
local DamageTypeDataStruct = {}

--- Constructor
---@return DamageTypeDataStruct
---@param Flags_16_AABAF2BE4B0639FAAAFD1EBF68488F24 table<integer, number>
---@param Knockback_19_11EFC7B6411931A6088FD790FB6BB901 number
---@param HitHardness_26_B4B247EA4DD49EA49B03F4AD9DACDBA2 number
---@param HitTextureAlphaMask_23_3513A14B450382FC9281B98D7C6FF2B7 Texture2D
function DamageTypeDataStruct.new(Flags_16_AABAF2BE4B0639FAAAFD1EBF68488F24, Knockback_19_11EFC7B6411931A6088FD790FB6BB901, HitHardness_26_B4B247EA4DD49EA49B03F4AD9DACDBA2, HitTextureAlphaMask_23_3513A14B450382FC9281B98D7C6FF2B7)
    local self = {}
    self.Flags_16_AABAF2BE4B0639FAAAFD1EBF68488F24 = Flags_16_AABAF2BE4B0639FAAAFD1EBF68488F24
    self.Knockback_19_11EFC7B6411931A6088FD790FB6BB901 = Knockback_19_11EFC7B6411931A6088FD790FB6BB901
    self.HitHardness_26_B4B247EA4DD49EA49B03F4AD9DACDBA2 = HitHardness_26_B4B247EA4DD49EA49B03F4AD9DACDBA2
    self.HitTextureAlphaMask_23_3513A14B450382FC9281B98D7C6FF2B7 = HitTextureAlphaMask_23_3513A14B450382FC9281B98D7C6FF2B7
    return self
end

return DamageTypeDataStruct
