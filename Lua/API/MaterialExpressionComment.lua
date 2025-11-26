---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MaterialExpressionComment : MaterialExpression
---Material Expression Comment
---
--- Properties
---@field SizeX integer
---@field SizeY integer
---@field Text string
---Color to style comment with
---@field CommentColor LinearColor
---Size of the text in the comment box
---@field FontSize integer
---Whether to show a zoom-invariant comment bubble when zoomed out (making the comment readable at any distance).
---@field bCommentBubbleVisible_InDetailsPanel boolean
---Whether to use Comment Color to color the background of the comment bubble shown when zoomed out.
---@field bColorCommentBubble boolean
---Whether the comment should move any fully enclosed nodes around when it is moved
---@field bGroupMode boolean
local MaterialExpressionComment = {}

--- Methods
return MaterialExpressionComment
