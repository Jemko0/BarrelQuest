---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraAssetTagDefinitionReference
---A Tag Definition Reference stores the guid of a Tag Definition. This is what assets should be storing.
---
--- Properties
---
---@field AssetTagDefinitionGuid Guid
local NiagaraAssetTagDefinitionReference = {}

--- Constructor
---@return NiagaraAssetTagDefinitionReference
---@param AssetTagDefinitionGuid Guid
function NiagaraAssetTagDefinitionReference.new(AssetTagDefinitionGuid)
    local self = {}
    self.AssetTagDefinitionGuid = AssetTagDefinitionGuid
    return self
end

return NiagaraAssetTagDefinitionReference
