---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ClothingAssetData_Legacy
---Legacy struct for handling back compat serialization
---
--- Properties
---@field AssetName string
---@field ApexFileName string
---@field bClothPropertiesChanged boolean
---@field PhysicsProperties ClothPhysicsProperties_Legacy
local ClothingAssetData_Legacy = {}
return ClothingAssetData_Legacy
