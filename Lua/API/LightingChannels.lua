---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class LightingChannels
---Specifies which lighting channels are relevant
---
--- Properties
---Default channel for all primitives and lights.
---@field bChannel0 boolean
---First custom channel
---@field bChannel1 boolean
---Second custom channel
---@field bChannel2 boolean
local LightingChannels = {}

--- Constructor
---@return LightingChannels
---@param bChannel0 boolean
---@param bChannel1 boolean
---@param bChannel2 boolean
function LightingChannels.new(bChannel0, bChannel1, bChannel2)
    local self = {}
    self.bChannel0 = bChannel0
    self.bChannel1 = bChannel1
    self.bChannel2 = bChannel2
    return self
end

return LightingChannels
