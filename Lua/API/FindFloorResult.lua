---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class FindFloorResult
---Data about the floor for walking movement, used by CharacterMovementComponent.
---
--- Properties
---True if there was a blocking hit in the floor test that was NOT in initial penetration.
---The HitResult can give more info about other circumstances.
---@field bBlockingHit boolean
---True if the hit found a valid walkable floor.
---@field bWalkableFloor boolean
---True if the hit found a valid walkable floor using a line trace (rather than a sweep test, which happens when the sweep test fails to yield a walkable surface).
---@field bLineTrace boolean
---The distance to the floor, computed from the swept capsule trace.
---@field FloorDist number
---The distance to the floor, computed from the trace. Only valid if bLineTrace is true.
---@field LineDist number
---Hit result of the test that found a floor. Includes more specific data about the point of impact and surface normal at that point.
---@field HitResult HitResult
local FindFloorResult = {}

--- Constructor
---@return FindFloorResult
---@param bBlockingHit boolean
---@param bWalkableFloor boolean
---@param bLineTrace boolean
---@param FloorDist number
---@param LineDist number
---@param HitResult HitResult
function FindFloorResult.new(bBlockingHit, bWalkableFloor, bLineTrace, FloorDist, LineDist, HitResult)
    local self = {}
    self.bBlockingHit = bBlockingHit
    self.bWalkableFloor = bWalkableFloor
    self.bLineTrace = bLineTrace
    self.FloorDist = FloorDist
    self.LineDist = LineDist
    self.HitResult = HitResult
    return self
end

return FindFloorResult
