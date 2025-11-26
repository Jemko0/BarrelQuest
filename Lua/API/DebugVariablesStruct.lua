---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class DebugVariablesStruct
---Debug Variables Struct
---
--- Properties
---@field DrawTemperatureDebug_1_0763FC1C4C89A65E3BA2EFA39780C803 boolean
---@field DrawRoomDebug_3_7A8E8B9C41240436251F5AB54994BAEF boolean
---@field ViewConeDebug_7_00508C3B496201566B3E848745E2D46D boolean
---@field ViewTargetDebug_9_FB9B961A4A365E4006EAEC8E5BFB9954 boolean
---@field InventoryDebug_11_44BB4AC043F22E59D4E7BE82D75F67B0 boolean
---@field TileCullingDebug_13_B0A483774AA503A4296B1BA43EC208D3 boolean
local DebugVariablesStruct = {}

--- Constructor
---@return DebugVariablesStruct
---@param DrawTemperatureDebug_1_0763FC1C4C89A65E3BA2EFA39780C803 boolean
---@param DrawRoomDebug_3_7A8E8B9C41240436251F5AB54994BAEF boolean
---@param ViewConeDebug_7_00508C3B496201566B3E848745E2D46D boolean
---@param ViewTargetDebug_9_FB9B961A4A365E4006EAEC8E5BFB9954 boolean
---@param InventoryDebug_11_44BB4AC043F22E59D4E7BE82D75F67B0 boolean
---@param TileCullingDebug_13_B0A483774AA503A4296B1BA43EC208D3 boolean
function DebugVariablesStruct.new(DrawTemperatureDebug_1_0763FC1C4C89A65E3BA2EFA39780C803, DrawRoomDebug_3_7A8E8B9C41240436251F5AB54994BAEF, ViewConeDebug_7_00508C3B496201566B3E848745E2D46D, ViewTargetDebug_9_FB9B961A4A365E4006EAEC8E5BFB9954, InventoryDebug_11_44BB4AC043F22E59D4E7BE82D75F67B0, TileCullingDebug_13_B0A483774AA503A4296B1BA43EC208D3)
    local self = {}
    self.DrawTemperatureDebug_1_0763FC1C4C89A65E3BA2EFA39780C803 = DrawTemperatureDebug_1_0763FC1C4C89A65E3BA2EFA39780C803
    self.DrawRoomDebug_3_7A8E8B9C41240436251F5AB54994BAEF = DrawRoomDebug_3_7A8E8B9C41240436251F5AB54994BAEF
    self.ViewConeDebug_7_00508C3B496201566B3E848745E2D46D = ViewConeDebug_7_00508C3B496201566B3E848745E2D46D
    self.ViewTargetDebug_9_FB9B961A4A365E4006EAEC8E5BFB9954 = ViewTargetDebug_9_FB9B961A4A365E4006EAEC8E5BFB9954
    self.InventoryDebug_11_44BB4AC043F22E59D4E7BE82D75F67B0 = InventoryDebug_11_44BB4AC043F22E59D4E7BE82D75F67B0
    self.TileCullingDebug_13_B0A483774AA503A4296B1BA43EC208D3 = TileCullingDebug_13_B0A483774AA503A4296B1BA43EC208D3
    return self
end

return DebugVariablesStruct
