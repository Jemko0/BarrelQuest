---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Anchors
---Describes how a widget is anchored.
---
--- Properties
---Holds the minimum anchors, left + top.
---@field Minimum Vector2D
---Holds the maximum anchors, right + bottom.
---@field Maximum Vector2D
local Anchors = {}
return Anchors
