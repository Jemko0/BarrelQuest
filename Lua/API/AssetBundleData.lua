---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class AssetBundleData
---A struct with a list of asset bundle entries. If one of these is inside a UObject it will get automatically exported as the asset registry tag AssetBundleData
---
--- Properties
---List of bundles defined
---@field Bundles AssetBundleEntry[]
local AssetBundleData = {}
return AssetBundleData
