---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MovementProperties
---Movement capabilities, determining available movement options for Pawns and used by AI for reachability tests.
---
--- Properties
---If true, this Pawn is capable of crouching.
---@field bCanCrouch boolean
---If true, this Pawn is capable of jumping.
---@field bCanJump boolean
---If true, this Pawn is capable of walking or moving on the ground.
---@field bCanWalk boolean
---If true, this Pawn is capable of swimming or moving through fluid volumes.
---@field bCanSwim boolean
---If true, this Pawn is capable of flying.
---@field bCanFly boolean
local MovementProperties = {}

--- Constructor
---@return MovementProperties
---@param bCanCrouch boolean
---@param bCanJump boolean
---@param bCanWalk boolean
---@param bCanSwim boolean
---@param bCanFly boolean
function MovementProperties.new(bCanCrouch, bCanJump, bCanWalk, bCanSwim, bCanFly)
    local self = {}
    self.bCanCrouch = bCanCrouch
    self.bCanJump = bCanJump
    self.bCanWalk = bCanWalk
    self.bCanSwim = bCanSwim
    self.bCanFly = bCanFly
    return self
end

return MovementProperties
