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
return LightingChannels
