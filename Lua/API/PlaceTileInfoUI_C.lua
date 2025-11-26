---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PlaceTileInfoUI_C : UserWidget
---Place Tile Info UI
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field TextBlock_95 TextBlock
---@field TextBlock_77 TextBlock
---@field Image_82 Image
---@field cost TextBlock
---@field ID string
---@field Recipe string
---@field PlayerHasHammer boolean
local PlaceTileInfoUI_C = {}

--- Methods
---Get Color and Opacity 0
---@return SlateColor
function PlaceTileInfoUI_C.GetColorAndOpacity_0() end

---Get Visibility 0
---@return ESlateVisibility
function PlaceTileInfoUI_C.GetVisibility_0() end

return PlaceTileInfoUI_C
