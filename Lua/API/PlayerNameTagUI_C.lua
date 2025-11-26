---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PlayerNameTagUI_C : UserWidget
---Player Name Tag UI
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field TextBlock_32 TextBlock
---@field Player BarrelCharacter_C
---@field display string
---@field name string
local PlayerNameTagUI_C = {}

--- Methods
---Set Player
---@param Player BarrelCharacter_C
---@return nil
function PlayerNameTagUI_C.SetPlayer(Player) end

return PlayerNameTagUI_C
