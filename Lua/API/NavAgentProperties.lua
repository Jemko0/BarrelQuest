---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NavAgentProperties
---Properties of representation of an 'agent' (or Pawn) used by AI navigation/pathfinding.
---
--- Properties
---
---Radius of the capsule used for navigation/pathfinding.
---@field AgentRadius number
---Total height of the capsule used for navigation/pathfinding.
---@field AgentHeight number
---Step height to use, or -1 for default value from navdata's config.
---@field AgentStepHeight number
---Scale factor to apply to height of bounds when searching for navmesh to project to when nav walking
---@field NavWalkingSearchHeightScale number
---Type of navigation data used by agent, null means "any"
---@field PreferredNavData SoftClassPath
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
local NavAgentProperties = {}

--- Constructor
---@return NavAgentProperties
---@param AgentRadius number
---@param AgentHeight number
---@param AgentStepHeight number
---@param NavWalkingSearchHeightScale number
---@param PreferredNavData SoftClassPath
---@param bCanCrouch boolean
---@param bCanJump boolean
---@param bCanWalk boolean
---@param bCanSwim boolean
---@param bCanFly boolean
function NavAgentProperties.new(AgentRadius, AgentHeight, AgentStepHeight, NavWalkingSearchHeightScale, PreferredNavData, bCanCrouch, bCanJump, bCanWalk, bCanSwim, bCanFly)
    local self = {}
    self.AgentRadius = AgentRadius
    self.AgentHeight = AgentHeight
    self.AgentStepHeight = AgentStepHeight
    self.NavWalkingSearchHeightScale = NavWalkingSearchHeightScale
    self.PreferredNavData = PreferredNavData
    self.bCanCrouch = bCanCrouch
    self.bCanJump = bCanJump
    self.bCanWalk = bCanWalk
    self.bCanSwim = bCanSwim
    self.bCanFly = bCanFly
    return self
end

return NavAgentProperties
