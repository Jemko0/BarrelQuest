---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class TemperatureManager : Actor
---Temperature Manager
---
--- Properties
---
---@field ambientTemperature number
---@field temperatureMap table<Vector, number>
---@field registeredInvokers table<TemperatureInvoker, boolean>
---@field drawDebug boolean
---@field globalHeatTransferRate number
---@field drawHeatFlow boolean
---@field drawWallTraces boolean
---@field wallTraceChannel integer
---@field MAX_NEIGHBOR_ITERATIONS integer
---@field UseUpdateTimer boolean
---@field UpdateTimerInterval number
local TemperatureManager = {}

--- Methods
---Update Temperatures
---@param ucenter Vector
---@param temp number
---@return nil
function TemperatureManager.UpdateTemperatures(ucenter, temp) end

---Update Invokers
---@return nil
function TemperatureManager.UpdateInvokers() end

---Unregister Invoker
---@param invoker TemperatureInvoker
---@return nil
function TemperatureManager.UnregisterInvoker(invoker) end

---Set Outside Temperature
---@param outsideTemperature number
---@return nil
function TemperatureManager.SetOutsideTemperature(outsideTemperature) end

---Register Invoker
---@param invoker TemperatureInvoker
---@return nil
function TemperatureManager.RegisterInvoker(invoker) end

---Get Temperature Color
---@param temperature number
---@return LinearColor
function TemperatureManager.GetTemperatureColor(temperature) end

---Get Interp Temperature
---@param position Vector
---@return number
function TemperatureManager.GetInterpTemperature(position) end

---Find Neighbors Iterative
---@param startCenter Vector
---@param invokerTemp number
---@return nil
function TemperatureManager.FindNeighborsIterative(startCenter, invokerTemp) end

---Draw Heat Sources
---@return nil
function TemperatureManager.DrawHeatSources() end

---Draw Heat Flow Arrows
---@param tileCenter Vector
---@param tileTemp number
---@return nil
function TemperatureManager.DrawHeatFlowArrows(tileCenter, tileTemp) end

---Check for Wall
---@param center Vector
---@param direction Vector
---@return WallCheckResult
function TemperatureManager.CheckForWall(center, direction) end

return TemperatureManager
