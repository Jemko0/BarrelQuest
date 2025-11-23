---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class LatentActionInfo
---Latent action info
---
--- Properties
---The resume point within the function to execute
---@field Linkage integer
---the UUID for this action
---@field UUID integer
---The function to execute.
---@field ExecutionFunction string
---Object to execute the function on.
---@field CallbackTarget Object
local LatentActionInfo = {}
return LatentActionInfo
