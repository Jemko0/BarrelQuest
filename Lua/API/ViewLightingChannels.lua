---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ViewLightingChannels
---View / light masking support
---
--- Properties
---View specific lighting channel 0 (enabled by default).
---@field bViewChannel0 boolean
---View specific lighting channel 1.
---@field bViewChannel1 boolean
---View specific lighting channel 2.
---@field bViewChannel2 boolean
---View specific lighting channel 3.
---@field bViewChannel3 boolean
---View specific lighting channel 4.
---@field bViewChannel4 boolean
local ViewLightingChannels = {}

--- Constructor
---@return ViewLightingChannels
---@param bViewChannel0 boolean
---@param bViewChannel1 boolean
---@param bViewChannel2 boolean
---@param bViewChannel3 boolean
---@param bViewChannel4 boolean
function ViewLightingChannels.new(bViewChannel0, bViewChannel1, bViewChannel2, bViewChannel3, bViewChannel4)
    local self = {}
    self.bViewChannel0 = bViewChannel0
    self.bViewChannel1 = bViewChannel1
    self.bViewChannel2 = bViewChannel2
    self.bViewChannel3 = bViewChannel3
    self.bViewChannel4 = bViewChannel4
    return self
end

return ViewLightingChannels
