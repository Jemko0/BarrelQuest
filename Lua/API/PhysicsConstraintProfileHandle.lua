---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PhysicsConstraintProfileHandle
---Physics Constraint Profile Handle
---
--- Properties
---
---@field ProfileProperties ConstraintProfileProperties
---@field ProfileName string
local PhysicsConstraintProfileHandle = {}

--- Constructor
---@return PhysicsConstraintProfileHandle
---@param ProfileProperties ConstraintProfileProperties
---@param ProfileName string
function PhysicsConstraintProfileHandle.new(ProfileProperties, ProfileName)
    local self = {}
    self.ProfileProperties = ProfileProperties
    self.ProfileName = ProfileName
    return self
end

return PhysicsConstraintProfileHandle
