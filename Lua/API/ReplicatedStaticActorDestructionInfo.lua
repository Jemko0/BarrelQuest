---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ReplicatedStaticActorDestructionInfo
---Stored information about replicated static/placed actors that have been destroyed in a level.
---This information is cached in ULevel so that any net drivers that are created after these actors
---are destroyed can access this info and correctly replicate the destruction to their clients.
---
--- Properties
---
---@field ObjClass Class
local ReplicatedStaticActorDestructionInfo = {}

--- Constructor
---@return ReplicatedStaticActorDestructionInfo
---@param ObjClass Class
function ReplicatedStaticActorDestructionInfo.new(ObjClass)
    local self = {}
    self.ObjClass = ObjClass
    return self
end

return ReplicatedStaticActorDestructionInfo
