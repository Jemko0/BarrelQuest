---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

--- Constructor
---@return LatentActionInfo
---@param Linkage integer
---@param UUID integer
---@param ExecutionFunction string
---@param CallbackTarget Object
function LatentActionInfo.new(Linkage, UUID, ExecutionFunction, CallbackTarget)
    local self = {}
    self.Linkage = Linkage
    self.UUID = UUID
    self.ExecutionFunction = ExecutionFunction
    self.CallbackTarget = CallbackTarget
    return self
end

return LatentActionInfo
