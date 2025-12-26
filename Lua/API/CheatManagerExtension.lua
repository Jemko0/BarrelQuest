---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class CheatManagerExtension
---A cheat manager extension can extend the main cheat manager in a modular way, being enabled or disabled when the system associated with the cheats is enabled or disabled
---
--- Properties
---
local CheatManagerExtension = {}

--- Methods
---Get Player Controller
---@return PlayerController
function CheatManagerExtension.GetPlayerController() end

return CheatManagerExtension
