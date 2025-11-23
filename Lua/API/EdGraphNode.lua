---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class EdGraphNode
---Ed Graph Node
---
--- Properties
---List of connector pins
---@field DeprecatedPins EdGraphPin_Deprecated[]
---X position of node in the editor
---@field NodePosX integer
---Y position of node in the editor
---@field NodePosY integer
---Width of node in the editor; only used when the node can be resized
---@field NodeWidth integer
---Height of node in the editor; only used when the node can be resized
---@field NodeHeight integer
---Enum to indicate if a node has advanced-display-pins, and if they are shown
---@field AdvancedPinDisplay integer
---If true, this node can be resized and should be drawn with a resize handle
---@field bCanResizeNode boolean
---Flag to check for compile error/warning
---@field bHasCompilerMessage boolean
---Comment bubble pinned state
---@field bCommentBubblePinned boolean
---Comment bubble visibility
---@field bCommentBubbleVisible boolean
---Make comment bubble visible
---@field bCommentBubbleMakeVisible boolean
---If true, this node can be renamed in the editor
---@field bCanRenameNode boolean
---Note for a node that lingers until saved
---@field NodeUpgradeMessage string
---Comment string that is drawn on the node
---@field NodeComment string
---Flag to store node specific compile error/warning
---@field ErrorType integer
---Error/Warning description
---@field ErrorMsg string
---GUID to uniquely identify this node, to facilitate diffing versions of this graph
---@field NodeGuid Guid
local EdGraphNode = {}

--- Methods
return EdGraphNode
