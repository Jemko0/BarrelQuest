---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CollapsablePanelChild_C : UserWidget
---Collapsable Panel Child
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field PanelTitle string
---@field Parent CollapsablePanel_C
---@field HAlignment integer
---@field VAlignment integer
---@field OnChildPanelClosed function
local CollapsablePanelChild_C = {}

--- Methods
return CollapsablePanelChild_C
