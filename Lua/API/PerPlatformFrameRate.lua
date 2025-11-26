---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PerPlatformFrameRate
---FPerPlatformFrameRate - FFrameRate property with per-platform overrides
---
--- Properties
---
---@field Default FrameRate
---@field PerPlatform table<string, FrameRate>
local PerPlatformFrameRate = {}

--- Constructor
---@return PerPlatformFrameRate
---@param Default FrameRate
---@param PerPlatform table<string, FrameRate>
function PerPlatformFrameRate.new(Default, PerPlatform)
    local self = {}
    self.Default = Default
    self.PerPlatform = PerPlatform
    return self
end

return PerPlatformFrameRate
