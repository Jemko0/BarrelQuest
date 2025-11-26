---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Margin
---Describes the space around a Widget.
---
--- Properties
---Holds the margin to the left.
---@field Left number
---Holds the margin to the top.
---@field Top number
---Holds the margin to the right.
---@field Right number
---Holds the margin to the bottom.
---@field Bottom number
local Margin = {}

--- Constructor
---@return Margin
---@param Left number
---@param Top number
---@param Right number
---@param Bottom number
function Margin.new(Left, Top, Right, Bottom)
    local self = {}
    self.Left = Left
    self.Top = Top
    self.Right = Right
    self.Bottom = Bottom
    return self
end

return Margin
