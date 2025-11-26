---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SoftObjectPath
---A struct that contains a string reference to an object, either a top level asset or a subobject.
---@note The full C++ class is located here: Engine\Source\Runtime\CoreUObject\Public\UObject\SoftObjectPath.h
---
--- Properties
---Asset path, patch to a top level object in a package
---@field AssetPath TopLevelAssetPath
---Optional FString for subobject within an asset
---@field SubPathString any
local SoftObjectPath = {}
return SoftObjectPath
