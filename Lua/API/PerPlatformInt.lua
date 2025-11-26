---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PerPlatformInt
---FPerPlatformInt - int32 property with per-platform overrides
---
--- Properties
---
---@field Default integer
---@field PerPlatform table<string, integer>
local PerPlatformInt = {}

--- Constructor
---@return PerPlatformInt
---@param Default integer
---@param PerPlatform table<string, integer>
function PerPlatformInt.new(Default, PerPlatform)
    local self = {}
    self.Default = Default
    self.PerPlatform = PerPlatform
    return self
end

return PerPlatformInt
