---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class DangerSensingComponent_C : ActorComponent
---Danger Sensing Component
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field DangerLevel number
local DangerSensingComponent_C = {}

--- Methods
---Get Value
---@return nil, number
function DangerSensingComponent_C.GetValue() end

---Tick
---@return nil
function DangerSensingComponent_C.Tick() end

return DangerSensingComponent_C
