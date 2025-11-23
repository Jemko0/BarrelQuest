---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class StatsComponent_C : ActorComponent
---Stats Component
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field StatTickTimer TimerHandle
---@field Stats StatDefinitionStruct[]
---@field InitialStats StatDefinitionStruct[]
---@field StatsTicked function
local StatsComponent_C = {}

--- Methods
---Get Stat Component
---@return nil, StatsComponent_C
function StatsComponent_C.GetStatComponent() end

---Set Stat
---@param Index integer
---@return nil
function StatsComponent_C.SetStat(Index) end

---Get Stat Value
---@param Stat_Name string
---@return nil, number
function StatsComponent_C.GetStatValue(Stat_Name) end

---Has Stat
---@param StatName string
---@return nil, boolean
function StatsComponent_C.HasStat(StatName) end

---Get All Stats
---@return nil, StatDefinitionStruct[]
function StatsComponent_C.GetAllStats() end

---Add Value
---@param statName string
---@param Value number
---@return nil
function StatsComponent_C.AddValue(statName, Value) end

---Get Stat by Name
---@param statName string
---@return nil, integer, boolean, StatDefinitionStruct
function StatsComponent_C.GetStatByName(statName) end

---Get Stat
---@param index integer
---@return nil, StatDefinitionStruct
function StatsComponent_C.GetStat(index) end

---Init Stats
---@return nil
function StatsComponent_C.InitStats() end

---Tick Stat
---@param Index integer
---@return nil
function StatsComponent_C.TickStat(Index) end

---Tick Stats
---@return nil
function StatsComponent_C.TickStats() end

---SVTick Stats
---@return nil
function StatsComponent_C.SVTickStats() end

---Add Value to Stat
---@param statName string
---@param value number
---@return nil
function StatsComponent_C.AddValueToStat(statName, value) end

---SV Add Value
---Original name: "SV Add Value"
---@param statName string
---@param Value number
---@return nil
function StatsComponent_C.SV_Add_Value(statName, Value) end

---Broadcast Stat Tick
---@return nil
function StatsComponent_C.BroadcastStatTick() end

return StatsComponent_C
