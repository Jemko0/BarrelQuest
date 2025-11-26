---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ClothingAssetBase
---An interface object for any clothing asset the engine can use.
---Any clothing asset concrete object should derive from this.
---
--- Properties
---
---@field ImportedFilePath string
---Guid to identify this asset. Will be embedded into chunks that are created using this asset
---@field AssetGuid Guid
local ClothingAssetBase = {}

--- Methods
return ClothingAssetBase
