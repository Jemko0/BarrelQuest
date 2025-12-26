---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class PlayerState : Info
---A PlayerState is created for every player on a server (or in a standalone game).
---PlayerStates are replicated to all clients, and contain network game relevant information about the player, such as playername, score, etc.
---
--- Properties
---
---This is used for sending game agnostic messages that can be localized
---@field EngineMessageClass Class
---Used to match up InactivePlayerState with rejoining playercontroller.
---@field SavedNetworkAddress string
---Broadcast whenever this player's possessed pawn is set
---@field OnPawnSet OnPawnSetDelegate
local PlayerState = {}

--- Methods
---Gets the literal value of bIsSpectator.
---@return boolean
function PlayerState.IsSpectator() end

---Gets the literal value of bOnlySpectator.
---@return boolean
function PlayerState.IsOnlyASpectator() end

---Gets the literal value of bIsABot.
---@return boolean
function PlayerState.IsABot() end

---Gets the literal value of Score.
---@return number
function PlayerState.GetScore() end

---returns current player name
---@return string
function PlayerState.GetPlayerName() end

---Gets the literal value of PlayerId.
---@return integer
function PlayerState.GetPlayerId() end

---Return the player controller that created this player state, or null for remote clients
---@return PlayerController
function PlayerState.GetPlayerController() end

---Returns the ping (in milliseconds)
---Returns ExactPing if available (local players or when running on the server), and
---the replicated CompressedPing (converted back to milliseconds) otherwise.
---Note that replication of CompressedPing is controlled by bShouldUpdateReplicatedPing,
---and if disabled then this will return 0 or a stale value on clients for player states
---that aren't related to local players
---@return number
function PlayerState.GetPingInMilliseconds() end

---Return the pawn controlled by this Player State.
---@return Pawn
function PlayerState.GetPawn() end

---Gets the literal value of the compressed Ping value (Ping = PingInMS / 4).
---@return integer
function PlayerState.GetCompressedPing() end

---Gets the online unique id for a player. If a player is logged in this will be consistent across all clients and servers.
---@return UniqueNetIdRepl
function PlayerState.BP_GetUniqueId() end

return PlayerState
