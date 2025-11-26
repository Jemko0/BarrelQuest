---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PanelSlot : Visual
---The base class for all Slots in UMG.
---
--- Properties
---
---@field Parent PanelWidget
---@field Content Widget
local PanelSlot = {}

--- Methods
---Get Content
---@return Widget
function PanelSlot.GetContent() end

return PanelSlot
