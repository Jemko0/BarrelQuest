---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class UniqueNetIdRepl
---Wrapper for opaque type FUniqueNetId
---Makes sure that the opaque aspects of FUniqueNetId are properly handled/serialized
---over network RPC and actor replication
---
--- Properties
---Network serialized data cache
---@field ReplicationBytes integer[]
local UniqueNetIdRepl = {}
return UniqueNetIdRepl
