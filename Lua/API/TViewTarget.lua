---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class TViewTarget
---A ViewTarget is the primary actor the camera is associated with.
---
--- Properties
---Target Actor used to compute POV
---@field Target Actor
---Computed point of view
---@field POV MinimalViewInfo
---PlayerState (used to follow same player through pawn transitions, etc., when spectating)
---@field PlayerState PlayerState
local TViewTarget = {}
return TViewTarget
