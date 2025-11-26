---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CharacterMovementComponentPostPhysicsTickFunction
---Tick function that calls UCharacterMovementComponent::PostPhysicsTickComponent
---
--- Properties
---Defines the minimum tick group for this tick function. These groups determine the relative order of when objects tick during a frame update.
---Given prerequisites, the tick may be delayed.
---@see ETickingGroup
---@see FTickFunction::AddPrerequisite()
---@field TickGroup integer
---Defines the tick group that this tick function must finish in. These groups determine the relative order of when objects tick during a frame update.
---@see ETickingGroup
---@field EndTickGroup integer
---Bool indicating that this function should execute even if the game is paused. Pause ticks are very limited in capabilities. *
---@field bTickEvenWhenPaused boolean
---If false, this tick function will never be registered and will never tick. Only settable in defaults.
---@field bCanEverTick boolean
---If true, this tick function will start enabled, but can be disabled later on.
---@field bStartWithTickEnabled boolean
---If we allow this tick to run on a dedicated server
---@field bAllowTickOnDedicatedServer boolean
---The frequency in seconds at which this tick function will be executed.  If less than or equal to 0 then it will tick every frame
---@field TickInterval number
local CharacterMovementComponentPostPhysicsTickFunction = {}

--- Constructor
---@return CharacterMovementComponentPostPhysicsTickFunction
---@param TickGroup integer
---@param EndTickGroup integer
---@param bTickEvenWhenPaused boolean
---@param bCanEverTick boolean
---@param bStartWithTickEnabled boolean
---@param bAllowTickOnDedicatedServer boolean
---@param TickInterval number
function CharacterMovementComponentPostPhysicsTickFunction.new(TickGroup, EndTickGroup, bTickEvenWhenPaused, bCanEverTick, bStartWithTickEnabled, bAllowTickOnDedicatedServer, TickInterval)
    local self = {}
    self.TickGroup = TickGroup
    self.EndTickGroup = EndTickGroup
    self.bTickEvenWhenPaused = bTickEvenWhenPaused
    self.bCanEverTick = bCanEverTick
    self.bStartWithTickEnabled = bStartWithTickEnabled
    self.bAllowTickOnDedicatedServer = bAllowTickOnDedicatedServer
    self.TickInterval = TickInterval
    return self
end

return CharacterMovementComponentPostPhysicsTickFunction
