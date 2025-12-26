---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class CollapsablePanelChild_C : UserWidget
---Collapsable Panel Child
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field PanelTitle string
---@field Parent CollapsablePanel_C
---@field HAlignment integer
---@field VAlignment integer
---@field OnChildPanelClosed OnChildPanelClosedDelegate
local CollapsablePanelChild_C = {}

--- Methods
return CollapsablePanelChild_C
