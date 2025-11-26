---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BPEditorBookmarkNode
---Bookmark node info
---
--- Properties
---Node ID
---@field NodeGuid Guid
---Parent ID
---@field ParentGuid Guid
---Display name
---@field DisplayName string
local BPEditorBookmarkNode = {}

--- Constructor
---@return BPEditorBookmarkNode
---@param NodeGuid Guid
---@param ParentGuid Guid
---@param DisplayName string
function BPEditorBookmarkNode.new(NodeGuid, ParentGuid, DisplayName)
    local self = {}
    self.NodeGuid = NodeGuid
    self.ParentGuid = ParentGuid
    self.DisplayName = DisplayName
    return self
end

return BPEditorBookmarkNode
