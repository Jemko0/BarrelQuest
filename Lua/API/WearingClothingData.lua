---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class WearingClothingData
---Wearing Clothing Data
---
--- Properties
---@field dirtLevel number
---@field wearLevel number
---@field wetLevel number
---@field insulationLevel number
---@field holes string[]
---@field clothingType EClothingType
local WearingClothingData = {}
return WearingClothingData
