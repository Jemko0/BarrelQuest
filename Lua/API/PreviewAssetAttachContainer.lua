---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PreviewAssetAttachContainer
---Component which deals with attaching assets
---
--- Properties
---
---@field AttachedObjects PreviewAttachedObjectPair[]
local PreviewAssetAttachContainer = {}

--- Constructor
---@return PreviewAssetAttachContainer
---@param AttachedObjects PreviewAttachedObjectPair[]
function PreviewAssetAttachContainer.new(AttachedObjects)
    local self = {}
    self.AttachedObjects = AttachedObjects
    return self
end

return PreviewAssetAttachContainer
