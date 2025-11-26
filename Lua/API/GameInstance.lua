---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class GameInstance
---GameInstance: high-level manager object for an instance of the running game.
---Spawned at game creation and not destroyed until game instance is shut down.
---Running as a standalone game, there will be one of these.
---Running in PIE (play-in-editor) will generate one of these per PIE instance.
---
--- Properties
---List of locally participating players in this game instance
---@field LocalPlayers LocalPlayer[]
---Class to manage online services
---@field OnlineSession OnlineSession
---List of objects that are being kept alive by this game instance. Stored as array for fast iteration, should not be modified every frame
---@field ReferencedObjects Object[]
---gets triggered shortly after a pawn's controller is set. Most of the time
---    it signals that the Controller has changed but in edge cases (like during
---    replication) it might end up broadcasting the same pawn-controller pair
---    more than once
---@field OnPawnControllerChangedDelegates function
---Callback for when an input device connection state has changed (a new gamepad was connected or disconnected)
---@field OnInputDeviceConnectionChange function
---Callback when an input device has changed pairings (the owning platform user has changed for that device)
---@field OnUserInputDevicePairingChange function
local GameInstance = {}

--- Methods
return GameInstance
