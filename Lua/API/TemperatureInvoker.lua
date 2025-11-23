---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class TemperatureInvoker : ActorComponent
---Temperature Invoker
---
--- Properties
---@field targetTemperature number
---@field emit boolean
local TemperatureInvoker = {}

--- Methods
---Set Target Temperature
---@param temperature number
---@return nil
function TemperatureInvoker.SetTargetTemperature(temperature) end

---Set Emit State
---@param newState boolean
---@return nil
function TemperatureInvoker.SetEmitState(newState) end

---Get Target Temperature
---@return number
function TemperatureInvoker.GetTargetTemperature() end

---Get Emit State
---@return boolean
function TemperatureInvoker.GetEmitState() end

return TemperatureInvoker
