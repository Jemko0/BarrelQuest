---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TViewTarget
---A ViewTarget is the primary actor the camera is associated with.
---
--- Properties
---
---Target Actor used to compute POV
---@field Target Actor
---Computed point of view
---@field POV MinimalViewInfo
---PlayerState (used to follow same player through pawn transitions, etc., when spectating)
---@field PlayerState PlayerState
local TViewTarget = {}

--- Constructor
---@return TViewTarget
---@param Target Actor
---@param POV MinimalViewInfo
---@param PlayerState PlayerState
function TViewTarget.new(Target, POV, PlayerState)
    local self = {}
    self.Target = Target
    self.POV = POV
    self.PlayerState = PlayerState
    return self
end

return TViewTarget
