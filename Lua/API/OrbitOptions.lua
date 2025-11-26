---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class OrbitOptions
---Container struct for holding options on the data updating for the module.
---
--- Properties
---Whether to process the data during spawning.
---@field bProcessDuringSpawn boolean
---Whether to process the data during updating.
---@field bProcessDuringUpdate boolean
---Whether to use emitter time during data retrieval.
---@field bUseEmitterTime boolean
local OrbitOptions = {}

--- Constructor
---@return OrbitOptions
---@param bProcessDuringSpawn boolean
---@param bProcessDuringUpdate boolean
---@param bUseEmitterTime boolean
function OrbitOptions.new(bProcessDuringSpawn, bProcessDuringUpdate, bUseEmitterTime)
    local self = {}
    self.bProcessDuringSpawn = bProcessDuringSpawn
    self.bProcessDuringUpdate = bProcessDuringUpdate
    self.bUseEmitterTime = bUseEmitterTime
    return self
end

return OrbitOptions
