---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ClothingAssetData_Legacy
---Legacy struct for handling back compat serialization
---
--- Properties
---
---@field AssetName string
---@field ApexFileName string
---@field bClothPropertiesChanged boolean
---@field PhysicsProperties ClothPhysicsProperties_Legacy
local ClothingAssetData_Legacy = {}

--- Constructor
---@return ClothingAssetData_Legacy
---@param AssetName string
---@param ApexFileName string
---@param bClothPropertiesChanged boolean
---@param PhysicsProperties ClothPhysicsProperties_Legacy
function ClothingAssetData_Legacy.new(AssetName, ApexFileName, bClothPropertiesChanged, PhysicsProperties)
    local self = {}
    self.AssetName = AssetName
    self.ApexFileName = ApexFileName
    self.bClothPropertiesChanged = bClothPropertiesChanged
    self.PhysicsProperties = PhysicsProperties
    return self
end

return ClothingAssetData_Legacy
