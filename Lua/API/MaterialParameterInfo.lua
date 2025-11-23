---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class MaterialParameterInfo
---Material Parameter Info
---
--- Properties
---@field Name string
---Whether this is a global parameter, or part of a layer or blend
---@field Association integer
---Layer or blend index this parameter is part of. INDEX_NONE for global parameters.
---@field Index integer
local MaterialParameterInfo = {}
return MaterialParameterInfo
