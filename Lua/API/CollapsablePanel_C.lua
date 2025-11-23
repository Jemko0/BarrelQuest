---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class CollapsablePanel_C : UserWidget
---Collapsable Panel
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field UniversalButton_1 UniversalButton_C
---@field UniversalButton UniversalButton_C
---@field TextBlock_98 TextBlock
---@field PanelInnerVert VerticalBox
---@field Overlay_81 Overlay
---@field MainFront Border
---@field Darken Border
---@field In WidgetAnimation
---@field panelTitle string
---@field collapsed boolean
---@field OnClose function
local CollapsablePanel_C = {}

--- Methods
---Check If Should Stay In Blocking UIMode
---Original name: "Check if Should Stay in Blocking UIMode"
---@return nil
function CollapsablePanel_C.Check_if_Should_Stay_in_Blocking_UIMode() end

---Get Text 0
---@return string
function CollapsablePanel_C.GetText_0() end

---Get Brush Color 0
---@return LinearColor
function CollapsablePanel_C.GetBrushColor_0() end

---Finished 32377CF34934011E0E02CC893F1F2D5B
---@return nil
function CollapsablePanel_C.Finished_32377CF34934011E0E02CC893F1F2D5B() end

---Force Close Unresolved
---@return nil
function CollapsablePanel_C.ForceCloseUnresolved() end

---Set Free
---@return nil
function CollapsablePanel_C.SetFree() end

---Player Death
---@return nil
function CollapsablePanel_C.PlayerDeath() end

return CollapsablePanel_C
