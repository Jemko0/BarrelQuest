---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BarrelGamemode_C : GameModeBase
---Barrel Gamemode
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field DefaultSceneRoot SceneComponent
---@field SpawnedPlayers table<string, Pawn>
---@field NetLoadClientLuaFiles string[]
---@field LuaNetActor BarrelLuaNetworkActor_C
local BarrelGamemode_C = {}

--- Methods
---Spawn Lua Net Actor
---@return nil
function BarrelGamemode_C.SpawnLuaNetActor() end

---Save Players
---@return nil
function BarrelGamemode_C.SavePlayers() end

---Save World
---@return nil
function BarrelGamemode_C.SaveWorld() end

---Is Player Banned
---@return nil, boolean
function BarrelGamemode_C.IsPlayerBanned() end

---Finalize Player Spawn
---@param Player Controller
---@param UserID string
---@return nil
function BarrelGamemode_C.FinalizePlayerSpawn(Player, UserID) end

---Spawn Player for Client
---@param Controller Controller
---@param UserID string
---@return nil
function BarrelGamemode_C.SpawnPlayerForClient(Controller, UserID) end

return BarrelGamemode_C
