---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class GameStateBase : Info
---GameStateBase is a class that manages the game's global state, and is spawned by GameModeBase.
---It exists on both the client and the server and is fully replicated.
---
--- Properties
---
---Class of the server's game mode, assigned by GameModeBase.
---@field GameModeClass Class
---Instance of the current game mode, exists only on the server. For non-authority clients, this will be NULL.
---@field AuthorityGameMode GameModeBase
---Class used by spectators, assigned by GameModeBase.
---@field SpectatorClass Class
---Array of all PlayerStates, maintained on both server and clients (PlayerStates are always relevant)
---@field PlayerArray PlayerState[]
---Replicated when GameModeBase->StartPlay has been called so the client will also start play
---@field bReplicatedHasBegunPlay boolean
---@field ReplicatedWorldTimeSeconds number
---@field ReplicatedWorldTimeSecondsDouble number
---The difference from the local world's TimeSeconds and the server world's TimeSeconds.
---@field ServerWorldTimeSecondsDelta number
---Frequency that the server updates the replicated TimeSeconds from the world. Set to zero to disable periodic updates.
---@field ServerWorldTimeSecondsUpdateFrequency number
local GameStateBase = {}

--- Methods
---Returns true if the world has started match (called MatchStarted callbacks)
---@return boolean
function GameStateBase.HasMatchStarted() end

---Returns true if the match can be considered ended. Defaults to false.
---@return boolean
function GameStateBase.HasMatchEnded() end

---Returns true if the world has started play (called BeginPlay on actors)
---@return boolean
function GameStateBase.HasBegunPlay() end

---Returns the simulated TimeSeconds on the server, will be synchronized on client and server
---@return number
function GameStateBase.GetServerWorldTimeSeconds() end

---Returns the time that should be used as when a player started
---@param Controller Controller
---@return number
function GameStateBase.GetPlayerStartTime(Controller) end

---Returns how much time needs to be spent before a player can respawn
---@param Controller Controller
---@return number
function GameStateBase.GetPlayerRespawnDelay(Controller) end

return GameStateBase
