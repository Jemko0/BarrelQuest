---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class UniqueNetIdRepl
---Wrapper for opaque type FUniqueNetId
---Makes sure that the opaque aspects of FUniqueNetId are properly handled/serialized
---over network RPC and actor replication
---
--- Properties
---Network serialized data cache
---@field ReplicationBytes integer[]
local UniqueNetIdRepl = {}

--- Constructor
---@return UniqueNetIdRepl
---@param ReplicationBytes integer[]
function UniqueNetIdRepl.new(ReplicationBytes)
    local self = {}
    self.ReplicationBytes = ReplicationBytes
    return self
end

return UniqueNetIdRepl
