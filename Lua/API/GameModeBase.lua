---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class GameModeBase : Info
---The GameModeBase defines the game being played. It governs the game rules, scoring, what actors
---are allowed to exist in this game type, and who may enter the game.
---It is only instanced on the server and will never exist on the client.
---A GameModeBase actor is instantiated when the level is initialized for gameplay in
---C++ UGameEngine::LoadMap().
---The class of this GameMode actor is determined by (in order) either the URL ?game=xxx,
---the GameMode Override value set in the World Settings, or the DefaultGameMode entry set
---in the game's Project Settings.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Framework/GameMode/index.html
---
--- Properties
---Save options string and parse it when needed
---@field OptionsString string
---Class of GameSession, which handles login approval and online game interface
---@field GameSessionClass Class
---Class of GameState associated with this GameMode.
---@field GameStateClass Class
---The class of PlayerController to spawn for players logging in.
---@field PlayerControllerClass Class
---A PlayerState of this class will be associated with every player to replicate relevant player information to all clients.
---@field PlayerStateClass Class
---HUD class this game uses.
---@field HUDClass Class
---The default pawn class used by players.
---@field DefaultPawnClass Class
---The pawn class used by the PlayerController for players when spectating.
---@field SpectatorClass Class
---The PlayerController class used when spectating a network replay.
---@field ReplaySpectatorPlayerControllerClass Class
---@field ServerStatReplicatorClass Class
---Game Session handles login approval, arbitration, online game interface
---@field GameSession GameSession
---GameState is used to replicate game state relevant properties to all clients.
---@field GameState GameStateBase
---@field ServerStatReplicator ServerStatReplicator
---The default player name assigned to players that join with no name specified.
---@field DefaultPlayerName string
---Whether the game perform map travels using SeamlessTravel() which loads in the background and doesn't disconnect clients
---@field bUseSeamlessTravel boolean
---Whether players should immediately spawn when logging in, or stay as spectators until they manually spawn
---@field bStartPlayersAsSpectators boolean
---Whether the game is pauseable.
---@field bPauseable boolean
---Can be used to request a specific replication system for a GameNetDriver that will replicate this game mode.
---Leave to Default to use the game engine's preferred system.
---Useful when migrating from one repsystem to another and a game mode does not fully support both repsystem yet.
---@field GameNetDriverReplicationSystem EReplicationSystem
local GameModeBase = {}

--- Methods
---Transitions to calls BeginPlay on actors.
---@return nil
function GameModeBase.StartPlay() end

---Return to main menu, and disconnect any players
---@return nil
function GameModeBase.ReturnToMainMenuHost() end

---Tries to spawn the player's pawn at a specific location
---@param NewPlayer Controller
---@return nil
function GameModeBase.RestartPlayerAtTransform(NewPlayer) end

---Tries to spawn the player's pawn at the specified actor's location
---@param NewPlayer Controller
---@param StartSpot Actor
---@return nil
function GameModeBase.RestartPlayerAtPlayerStart(NewPlayer, StartSpot) end

---Tries to spawn the player's pawn, at the location returned by FindPlayerStart
---@param NewPlayer Controller
---@return nil
function GameModeBase.RestartPlayer(NewPlayer) end

---Overridable function called when resetting level. This is used to reset the game state while staying in the same map
---Default implementation calls Reset() on all actors except GameMode and Controllers
---@return nil
function GameModeBase.ResetLevel() end

---Returns true if it's valid to call RestartPlayer. By default will call Player->CanRestartPlayer
---@param Player PlayerController
---@return boolean
function GameModeBase.PlayerCanRestart(Player) end

---Return the specific player start actor that should be used for the next spawn
---This will either use a previously saved startactor, or calls ChoosePlayerStart
---@param Player Controller
---@param IncomingName string
---@return Actor
function GameModeBase.K2_FindPlayerStart(Player, IncomingName) end

---Returns true if the match start callbacks have been called
---@return boolean
function GameModeBase.HasMatchStarted() end

---Returns true if the match can be considered ended
---@return boolean
function GameModeBase.HasMatchEnded() end

---Returns number of human players currently spectating
---@return integer
function GameModeBase.GetNumSpectators() end

---Returns number of active human players, excluding spectators
---@return integer
function GameModeBase.GetNumPlayers() end

---Returns default pawn class for given controller
---@param InController Controller
---@return Class
function GameModeBase.GetDefaultPawnClassForController(InController) end

---Sets the name for a controller
---@param Controller Controller
---@param NewName string
---@param bNameChange boolean
---@return nil
function GameModeBase.ChangeName(Controller, NewName, bNameChange) end

return GameModeBase
