---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class BasedMovementInfo
---Struct to hold information about the "base" object the character is standing on.
---
--- Properties
---Unique (within a reasonable timespan) ID of the base component. Can be used to detect changes in the base when the pointer can't replicate, eg during fast shared replication.
---@field BaseID any
---Whether the server says that there is a base. On clients, the component may not have resolved yet.
---@field bServerHasBaseComponent boolean
---Whether rotation is relative to the base or absolute. It can only be relative if location is also relative.
---@field bRelativeRotation boolean
---Whether there is a velocity on the server. Used for forcing replication when velocity goes to zero.
---@field bServerHasVelocity boolean
---Bone name on component, for skeletal meshes. NAME_None if not a skeletal mesh or if bone is invalid.
---@field BoneName string
---Component we are based on
---@field MovementBase PrimitiveComponent
---Location relative to MovementBase. Only valid if HasRelativeLocation() is true.
---@field Location Vector_NetQuantize100
---Rotation: relative to MovementBase if HasRelativeRotation() is true, absolute otherwise.
---@field Rotation Rotator
local BasedMovementInfo = {}
return BasedMovementInfo
