---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class WalkableSlopeOverride
---Struct allowing control over "walkable" normals, by allowing a restriction or relaxation of what steepness is normally walkable.
---
--- Properties
---Behavior of this surface (whether we affect the walkable slope).
---@see GetWalkableSlopeBehavior(), SetWalkableSlopeBehavior()
---@field WalkableSlopeBehavior integer
---Override walkable slope angle (in degrees), applying the rules of the Walkable Slope Behavior.
---@see GetWalkableSlopeAngle(), SetWalkableSlopeAngle()
---@field WalkableSlopeAngle number
local WalkableSlopeOverride = {}
return WalkableSlopeOverride
