---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class Info : Actor
---Info is the base class of an Actor that isn't meant to have a physical representation in the world, used primarily
---for "manager" type classes that hold settings data about the world, but might need to be an Actor for replication purposes.
---
--- Properties
---
local Info = {}

--- Methods
return Info
