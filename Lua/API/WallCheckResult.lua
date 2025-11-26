---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class WallCheckResult
---Wall Check Result
---
--- Properties
local WallCheckResult = {}

--- Constructor
---@return WallCheckResult
function WallCheckResult.new()
    local self = {}
    return self
end

return WallCheckResult
