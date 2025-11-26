---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PerPlatformBool
---FPerPlatformBool - bool property with per-platform overrides
---
--- Properties
---@field Default boolean
---@field PerPlatform table<string, boolean>
local PerPlatformBool = {}

--- Constructor
---@return PerPlatformBool
---@param Default boolean
---@param PerPlatform table<string, boolean>
function PerPlatformBool.new(Default, PerPlatform)
    local self = {}
    self.Default = Default
    self.PerPlatform = PerPlatform
    return self
end

return PerPlatformBool
