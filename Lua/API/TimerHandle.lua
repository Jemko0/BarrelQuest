---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TimerHandle
---Unique handle that can be used to distinguish timers that have identical delegates.
---
--- Properties
---
---@field Handle integer
local TimerHandle = {}

--- Constructor
---@return TimerHandle
---@param Handle integer
function TimerHandle.new(Handle)
    local self = {}
    self.Handle = Handle
    return self
end

return TimerHandle
