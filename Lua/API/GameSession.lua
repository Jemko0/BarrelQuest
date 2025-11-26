---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class GameSession : Info
---Acts as a game-specific wrapper around the session interface. The game code makes calls to this when it needs to interact with the session interface.
---A game session exists only the server, while running an online game.
---
--- Properties
---
---Maximum number of spectators allowed by this server.
---@field MaxSpectators integer
---Maximum number of players allowed by this server.
---@field MaxPlayers integer
---Restrictions on the largest party that can join together
---@field MaxPartySize integer
---Maximum number of splitscreen players to allow from one connection
---@field MaxSplitscreensPerConnection integer
---Is voice enabled always or via a push to talk keybinding
---@field bRequiresPushToTalk boolean
---SessionName local copy from PlayerState class.  should really be define in this class, but need to address replication issues
---@field SessionName string
local GameSession = {}

--- Methods
return GameSession
