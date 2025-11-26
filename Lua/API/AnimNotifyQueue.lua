---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AnimNotifyQueue
---Anim Notify Queue
---
--- Properties
---Animation Notifies that has been triggered in the latest tick *
---@field AnimNotifies AnimNotifyEventReference[]
---Animation Notifies from montages that still need to be filtered by slot weight
---@field UnfilteredMontageAnimNotifies table<string, AnimNotifyArray>
local AnimNotifyQueue = {}
return AnimNotifyQueue
