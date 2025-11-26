---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SimpleMemberReference
---Simple Member Reference
---
--- Properties
---Most often the Class that this member is defined in. Could be a UPackage
---if it is a native delegate signature function (declared globally).
---@field MemberParent Object
---Name of the member
---@field MemberName string
---The Guid of the member
---@field MemberGuid Guid
local SimpleMemberReference = {}

--- Constructor
---@return SimpleMemberReference
---@param MemberParent Object
---@param MemberName string
---@param MemberGuid Guid
function SimpleMemberReference.new(MemberParent, MemberName, MemberGuid)
    local self = {}
    self.MemberParent = MemberParent
    self.MemberName = MemberName
    self.MemberGuid = MemberGuid
    return self
end

return SimpleMemberReference
