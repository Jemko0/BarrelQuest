---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class FXSystemAsset
---FXSystem Asset
---
--- Properties
---
---Max number of components of this system to keep resident in the world component pool.
---@field MaxPoolSize integer
---How many instances we should use to initially prime the pool.
---This can amortize runtime activation cost by moving it to load time.
---Use with care as this could cause large hitches for systems loaded/unloaded during play rather than at level load.
---@field PoolPrimeSize integer
local FXSystemAsset = {}

--- Methods
return FXSystemAsset
