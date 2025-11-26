---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class VerticalBoxSlot : PanelSlot
---The Slot for the UVerticalBox, contains the widget that is flowed vertically
---
--- Properties
---How much space this slot should occupy in the direction of the panel.
---@field Size SlateChildSize
---The padding area between the slot and the content it contains.
---@field Padding Margin
---The alignment of the object horizontally.
---@field HorizontalAlignment integer
---The alignment of the object vertically.
---@field VerticalAlignment integer
local VerticalBoxSlot = {}

--- Methods
---Set Vertical Alignment
---@param InVerticalAlignment integer
---@return nil
function VerticalBoxSlot.SetVerticalAlignment(InVerticalAlignment) end

---Set Size
---@param InSize SlateChildSize
---@return nil
function VerticalBoxSlot.SetSize(InSize) end

---Set Padding
---@param InPadding Margin
---@return nil
function VerticalBoxSlot.SetPadding(InPadding) end

---Set Horizontal Alignment
---@param InHorizontalAlignment integer
---@return nil
function VerticalBoxSlot.SetHorizontalAlignment(InHorizontalAlignment) end

return VerticalBoxSlot
