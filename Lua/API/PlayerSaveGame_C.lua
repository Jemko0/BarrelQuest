---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class PlayerSaveGame_C : SaveGame
---Player Save Game
---
--- Properties
---
---@field SavedPlayers table<string, PlayerSaveDataStruct>
local PlayerSaveGame_C = {}

--- Methods
---returns true if a players id exists in the saved data
---@return nil, boolean
function PlayerSaveGame_C.DoesPlayerExistInSave() end

---Get Player
---@return nil, PlayerSaveDataStruct
function PlayerSaveGame_C.GetPlayer() end

---Add Player
---@return nil
function PlayerSaveGame_C.AddPlayer() end

return PlayerSaveGame_C
