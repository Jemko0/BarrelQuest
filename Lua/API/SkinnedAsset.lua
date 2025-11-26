---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SkinnedAsset : StreamableRenderAsset
---Skinned Asset
---
--- Properties
local SkinnedAsset = {}

--- Methods
---Find a socket object and associated info in this SkeletalMesh by name.
---Entering NAME_None will return NULL. If there are multiple sockets with the same name, will return the first one.
---Also returns the index for the socket allowing for future fast access via GetSocketByIndex()
---Also returns the socket transform and the bone index (if any)
---@param InSocketName string
---@return SkeletalMeshSocket
function SkinnedAsset.FindSocketInfo(InSocketName) end

---Find a socket object in this SkeletalMesh by name.
---Entering NAME_None will return NULL. If there are multiple sockets with the same name, will return the first one.
---@param InSocketName string
---@return SkeletalMeshSocket
function SkinnedAsset.FindSocket(InSocketName) end

return SkinnedAsset
