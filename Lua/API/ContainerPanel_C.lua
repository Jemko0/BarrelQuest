---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class ContainerPanel_C : CollapsablePanelChild_C
---Container Panel
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field PlayerContainer ContainerWrapper_C
---@field Container ContainerWrapper_C
local ContainerPanel_C = {}

--- Methods
---Get Brush Color 0
---@return LinearColor
function ContainerPanel_C.GetBrushColor_0() end

return ContainerPanel_C
