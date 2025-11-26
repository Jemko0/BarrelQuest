---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class StatDefinitionStruct
---Stat Definition Struct
---
--- Properties
---
---@field protected statName_2_67DD0FB74FEAF2265F557B8EC0CFE645 string
---@field protected statMaxValue_5_7CDFF5274C5EF2846D08CA88430E9713 number
---@field protected statDefaultValue_7_4CCC476D444362782B2D118AEAD6575B number
---@field protected statCurrentValue_11_B4FD1BDA462C875A5E85BBB04C82417E number
---@field protected statAmountChange_9_F31F149D4A2719D7CEE1A48517B4CB99 number
local StatDefinitionStruct = {}

--- Constructor
---@return StatDefinitionStruct
---@param statName_2_67DD0FB74FEAF2265F557B8EC0CFE645 string
---@param statMaxValue_5_7CDFF5274C5EF2846D08CA88430E9713 number
---@param statDefaultValue_7_4CCC476D444362782B2D118AEAD6575B number
---@param statCurrentValue_11_B4FD1BDA462C875A5E85BBB04C82417E number
---@param statAmountChange_9_F31F149D4A2719D7CEE1A48517B4CB99 number
function StatDefinitionStruct.new(statName_2_67DD0FB74FEAF2265F557B8EC0CFE645, statMaxValue_5_7CDFF5274C5EF2846D08CA88430E9713, statDefaultValue_7_4CCC476D444362782B2D118AEAD6575B, statCurrentValue_11_B4FD1BDA462C875A5E85BBB04C82417E, statAmountChange_9_F31F149D4A2719D7CEE1A48517B4CB99)
    local self = {}
    self.statName_2_67DD0FB74FEAF2265F557B8EC0CFE645 = statName_2_67DD0FB74FEAF2265F557B8EC0CFE645
    self.statMaxValue_5_7CDFF5274C5EF2846D08CA88430E9713 = statMaxValue_5_7CDFF5274C5EF2846D08CA88430E9713
    self.statDefaultValue_7_4CCC476D444362782B2D118AEAD6575B = statDefaultValue_7_4CCC476D444362782B2D118AEAD6575B
    self.statCurrentValue_11_B4FD1BDA462C875A5E85BBB04C82417E = statCurrentValue_11_B4FD1BDA462C875A5E85BBB04C82417E
    self.statAmountChange_9_F31F149D4A2719D7CEE1A48517B4CB99 = statAmountChange_9_F31F149D4A2719D7CEE1A48517B4CB99
    return self
end

return StatDefinitionStruct
