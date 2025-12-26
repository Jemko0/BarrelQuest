---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class AnimNotifyState
---Anim Notify State
---
--- Properties
---
---Color of Notify in editor
---@field NotifyColor Color
---Whether this notify state instance should fire in animation editors
---@field bShouldFireInEditor boolean
local AnimNotifyState = {}

--- Methods
return AnimNotifyState
