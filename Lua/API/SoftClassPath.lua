---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoftClassPath
---A struct that contains a string reference to a class, can be used to make soft references to classes.
---@note The full C++ class is located here: Engine\Source\Runtime\CoreUObject\Public\UObject\SoftObjectPath.h
---
--- Properties
---
---Asset path, patch to a top level object in a package
---@field AssetPath TopLevelAssetPath
---Optional FString for subobject within an asset
---@field SubPathString any
local SoftClassPath = {}

--- Constructor
---@return SoftClassPath
---@param AssetPath TopLevelAssetPath
---@param SubPathString any
function SoftClassPath.new(AssetPath, SubPathString)
    local self = {}
    self.AssetPath = AssetPath
    self.SubPathString = SubPathString
    return self
end

return SoftClassPath
