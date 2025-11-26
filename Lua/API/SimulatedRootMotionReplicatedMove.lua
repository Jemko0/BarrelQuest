---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SimulatedRootMotionReplicatedMove
---Simulated Root Motion Replicated Move
---
--- Properties
---Local time when move was received on client and saved.
---@field Time number
---Root Motion information
---@field RootMotion RepRootMotionMontage
local SimulatedRootMotionReplicatedMove = {}

--- Constructor
---@return SimulatedRootMotionReplicatedMove
---@param Time number
---@param RootMotion RepRootMotionMontage
function SimulatedRootMotionReplicatedMove.new(Time, RootMotion)
    local self = {}
    self.Time = Time
    self.RootMotion = RootMotion
    return self
end

return SimulatedRootMotionReplicatedMove
