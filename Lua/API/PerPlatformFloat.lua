---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PerPlatformFloat
---FPerPlatformFloat - float property with per-platform overrides
---
--- Properties
---
---@field Default number
---@field PerPlatform table<string, number>
local PerPlatformFloat = {}

--- Constructor
---@return PerPlatformFloat
---@param Default number
---@param PerPlatform table<string, number>
function PerPlatformFloat.new(Default, PerPlatform)
    local self = {}
    self.Default = Default
    self.PerPlatform = PerPlatform
    return self
end

return PerPlatformFloat
