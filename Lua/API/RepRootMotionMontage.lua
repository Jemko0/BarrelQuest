---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RepRootMotionMontage
---Replicated data when playing a root motion montage.
---
--- Properties
---Animation providing Root Motion
---@field Animation AnimSequenceBase
---Whether this has useful/active data.
---@field bIsActive boolean
---Additional replicated flag, if MovementBase can't be resolved on the client. So we don't use wrong data.
---@field bRelativePosition boolean
---Whether rotation is relative or absolute.
---@field bRelativeRotation boolean
---Track position of Montage
---@field Position number
---Location
---@field Location Vector_NetQuantize100
---Rotation
---@field Rotation Rotator
---Movement Relative to Base
---@field MovementBase PrimitiveComponent
---Bone on the MovementBase, if a skeletal mesh.
---@field MovementBaseBoneName string
---State of Root Motion Sources on Authority
---@field AuthoritativeRootMotion RootMotionSourceGroup
---Acceleration
---@field Acceleration Vector_NetQuantize10
---Velocity
---@field LinearVelocity Vector_NetQuantize10
local RepRootMotionMontage = {}

--- Constructor
---@return RepRootMotionMontage
---@param Animation AnimSequenceBase
---@param bIsActive boolean
---@param bRelativePosition boolean
---@param bRelativeRotation boolean
---@param Position number
---@param Location Vector_NetQuantize100
---@param Rotation Rotator
---@param MovementBase PrimitiveComponent
---@param MovementBaseBoneName string
---@param AuthoritativeRootMotion RootMotionSourceGroup
---@param Acceleration Vector_NetQuantize10
---@param LinearVelocity Vector_NetQuantize10
function RepRootMotionMontage.new(Animation, bIsActive, bRelativePosition, bRelativeRotation, Position, Location, Rotation, MovementBase, MovementBaseBoneName, AuthoritativeRootMotion, Acceleration, LinearVelocity)
    local self = {}
    self.Animation = Animation
    self.bIsActive = bIsActive
    self.bRelativePosition = bRelativePosition
    self.bRelativeRotation = bRelativeRotation
    self.Position = Position
    self.Location = Location
    self.Rotation = Rotation
    self.MovementBase = MovementBase
    self.MovementBaseBoneName = MovementBaseBoneName
    self.AuthoritativeRootMotion = AuthoritativeRootMotion
    self.Acceleration = Acceleration
    self.LinearVelocity = LinearVelocity
    return self
end

return RepRootMotionMontage
