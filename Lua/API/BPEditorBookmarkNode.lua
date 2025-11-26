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
return BPEditorBookmarkNode
