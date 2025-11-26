---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CachedKeyToActionInfo
---Struct that exists to store runtime cache to make key to action lookups faster.
---
--- Properties
---
---Which PlayerInput object this has been built for
---@field PlayerInput any
local CachedKeyToActionInfo = {}

--- Constructor
---@return CachedKeyToActionInfo
---@param PlayerInput any
function CachedKeyToActionInfo.new(PlayerInput)
    local self = {}
    self.PlayerInput = PlayerInput
    return self
end

return CachedKeyToActionInfo
