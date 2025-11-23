---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class Player
---Player
---
--- Properties
---The actor this player controls.
---@field PlayerController PlayerController
---the current speed of the connection
---@field CurrentNetSpeed integer
---@todo document
---@field ConfiguredInternetSpeed integer
---@todo document
---@field ConfiguredLanSpeed integer
local Player = {}

--- Methods
return Player
