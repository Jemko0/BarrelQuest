---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

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
return SimpleMemberReference
