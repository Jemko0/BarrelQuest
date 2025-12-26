---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class LocalPlayer : Player
---Each player that is active on the current client/listen server has a LocalPlayer.
---It stays active across maps, and there may be several spawned in the case of splitscreen/coop.
---There will be 0 spawned on dedicated servers.
---
--- Properties
---
---The primary viewport containing this player's view.
---@field ViewportClient GameViewportClient
---How to constrain perspective viewport FOV
---@field AspectRatioAxisConstraint integer
---The class of PlayerController to spawn for players logging in.
---@field PendingLevelPlayerControllerClass Class
---set when we've sent a split join request
---@field bSentSplitJoin boolean
local LocalPlayer = {}

--- Methods
return LocalPlayer
