---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BoneHealthStruct
---Bone Health Struct
---
--- Properties
---@field BoneName_7_22C93D924C9AF8A9E0673B9BCB194EF8 string
---@field Health_5_CBA31EC94F2DA50BD4C6FD98B51CBCAA number
---@field Flags_13_BB59466543FB65295396D4938FB3E31B integer[]
---@field Bandage_17_42FD6F834F3DB287868CE1836B16C1E9 InventoryItemStruct
---@field DataComponents_22_6FA7E17B43E0614896099EB1CEB9A70C string[]
local BoneHealthStruct = {}

--- Constructor
---@return BoneHealthStruct
---@param BoneName_7_22C93D924C9AF8A9E0673B9BCB194EF8 string
---@param Health_5_CBA31EC94F2DA50BD4C6FD98B51CBCAA number
---@param Flags_13_BB59466543FB65295396D4938FB3E31B integer[]
---@param Bandage_17_42FD6F834F3DB287868CE1836B16C1E9 InventoryItemStruct
---@param DataComponents_22_6FA7E17B43E0614896099EB1CEB9A70C string[]
function BoneHealthStruct.new(BoneName_7_22C93D924C9AF8A9E0673B9BCB194EF8, Health_5_CBA31EC94F2DA50BD4C6FD98B51CBCAA, Flags_13_BB59466543FB65295396D4938FB3E31B, Bandage_17_42FD6F834F3DB287868CE1836B16C1E9, DataComponents_22_6FA7E17B43E0614896099EB1CEB9A70C)
    local self = {}
    self.BoneName_7_22C93D924C9AF8A9E0673B9BCB194EF8 = BoneName_7_22C93D924C9AF8A9E0673B9BCB194EF8
    self.Health_5_CBA31EC94F2DA50BD4C6FD98B51CBCAA = Health_5_CBA31EC94F2DA50BD4C6FD98B51CBCAA
    self.Flags_13_BB59466543FB65295396D4938FB3E31B = Flags_13_BB59466543FB65295396D4938FB3E31B
    self.Bandage_17_42FD6F834F3DB287868CE1836B16C1E9 = Bandage_17_42FD6F834F3DB287868CE1836B16C1E9
    self.DataComponents_22_6FA7E17B43E0614896099EB1CEB9A70C = DataComponents_22_6FA7E17B43E0614896099EB1CEB9A70C
    return self
end

return BoneHealthStruct
