---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RepAttachment
---Handles attachment replication to clients.
---
--- Properties
---Actor we are attached to, movement replication will not happen while AttachParent is non-nullptr
---@field AttachParent Actor
---Location offset from attach parent
---@field LocationOffset Vector_NetQuantize100
---Scale relative to attach parent
---@field RelativeScale3D Vector_NetQuantize100
---Rotation offset from attach parent
---@field RotationOffset Rotator
---Specific socket we are attached to
---@field AttachSocket string
---Specific component we are attached to
---@field AttachComponent SceneComponent
local RepAttachment = {}

--- Constructor
---@return RepAttachment
---@param AttachParent Actor
---@param LocationOffset Vector_NetQuantize100
---@param RelativeScale3D Vector_NetQuantize100
---@param RotationOffset Rotator
---@param AttachSocket string
---@param AttachComponent SceneComponent
function RepAttachment.new(AttachParent, LocationOffset, RelativeScale3D, RotationOffset, AttachSocket, AttachComponent)
    local self = {}
    self.AttachParent = AttachParent
    self.LocationOffset = LocationOffset
    self.RelativeScale3D = RelativeScale3D
    self.RotationOffset = RotationOffset
    self.AttachSocket = AttachSocket
    self.AttachComponent = AttachComponent
    return self
end

return RepAttachment
