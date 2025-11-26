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
return RepRootMotionMontage
