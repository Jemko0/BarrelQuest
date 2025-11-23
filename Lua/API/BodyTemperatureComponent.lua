---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class BodyTemperatureComponent : ActorComponent
---Body Temperature Component
---
--- Properties
---@field BodyTemp number
---@field InsulationWeights table<EClothingType, number>
---@field ClothingInsulation number
---@field BaseHeatLossFactor number
---@field SafeBodyTempRange number
---@field BaseBodyTemp number
---@field OutsideTemperature number
---@field OutsideInfluence number
---@field ClothingInsulationInfluence number
---@field InternalHeatProduction number
local BodyTemperatureComponent = {}

--- Methods
---Update Clothing Insulation
---@return number
function BodyTemperatureComponent.UpdateClothingInsulation() end

---Update Body Temperature
---@param delta number
---@return nil
function BodyTemperatureComponent.UpdateBodyTemperature(delta) end

---Raise Heat Production
---@param heatDelta number
---@return nil
function BodyTemperatureComponent.RaiseHeatProduction(heatDelta) end

---Log Vars
---@param deltaTime number
---@return nil
function BodyTemperatureComponent.LogVars(deltaTime) end

---Init Body Temperature
---@return nil
function BodyTemperatureComponent.InitBodyTemperature() end

---Get Heat Loss Multiplier
---@param insulation number
---@return number
function BodyTemperatureComponent.GetHeatLossMultiplier(insulation) end

---Get Clothing Data
---@return WearingClothingData[]
function BodyTemperatureComponent.GetClothingData() end

return BodyTemperatureComponent
