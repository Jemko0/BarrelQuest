---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class DayCycleManager_C : Actor
---Day Cycle Manager
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field SkyAtmosphere SkyAtmosphereComponent
---@field CameraRainParticles NiagaraComponent
---@field RainParticles NiagaraComponent
---@field Arrow ArrowComponent
---@field SkyLight SkyLightComponent
---@field DirectionalLight DirectionalLightComponent
---@field DefaultSceneRoot SceneComponent
---@field DayTime number
---@field TimeAccel number
---@field Day integer
---@field Month integer
---@field Year integer
---@field YearCycle number
---@field DayTimeWave number
---@field DayTimeWaveNoExponent number
---@field TodaysTemps number[]
---@field HottestTemp number
---@field ColdestTemp number
---@field TodaysNegativeVariation number
---@field TodaysPositiveVariation number
---@field TodaysLowestTemp number
---@field TodaysHighestTemp number
---@field OnNewDay function
---@field CurrentTemperature number
---@field TemperatureManager BPTemperatureManager_C
---@field RainOffset number
---@field RainFactor number
---@field DrynessLevel number
---@field DrynessMultiplier number
---@field DrynessCooldown integer
---@field ClientIsInside boolean
---@field AmbientColor LinearColor
---@field AmbientLightIntensity number
local DayCycleManager_C = {}

--- Methods
---Set Time Acceleration
---@param TimeAccel number
---@return nil
function DayCycleManager_C.SetTimeAcceleration(TimeAccel) end

---Get Ambient Light Intensity
---@return nil, number
function DayCycleManager_C.GetAmbientLightIntensity() end

---Get Ambient Color
---@return nil, LinearColor
function DayCycleManager_C.GetAmbientColor() end

---Bind Inside Change
---@return nil
function DayCycleManager_C.BindInsideChange() end

---Update Raising Rain
---@return nil
function DayCycleManager_C.UpdateRaisingRain() end

---Update Dryness
---@return nil
function DayCycleManager_C.UpdateDryness() end

---Update Rain VFX
---@return nil
function DayCycleManager_C.UpdateRainVFX() end

---Update Rain
---@return nil
function DayCycleManager_C.UpdateRain() end

---Get Weather Temperature
---@param InTemp number
---@return nil, number
function DayCycleManager_C.GetWeatherTemperature(InTemp) end

---Get Temperature for Now
---@return nil, number
function DayCycleManager_C.GetTemperatureForNow() end

---Get Temperature for Day Time
---@param DayTime number
---@return nil, number
function DayCycleManager_C.GetTemperatureForDayTime(DayTime) end

---Get Temperature Lerp Value
---@param xdaytime number
---@return number
function DayCycleManager_C.GetTemperatureLerpValue(xdaytime) end

---Calc Temperatures
---@return nil
function DayCycleManager_C.CalcTemperatures() end

---Get Month Name
---@return nil, string
function DayCycleManager_C.GetMonthName() end

---Get Calendar Date
---@return nil
function DayCycleManager_C.GetCalendarDate() end

---Get Corrected Day Time
---@return number
function DayCycleManager_C.GetCorrectedDayTime() end

---Set Day Time
---@param NewDayTime number
---@return nil
function DayCycleManager_C.SetDayTime(NewDayTime) end

---Update Sky Light
---@return nil
function DayCycleManager_C.UpdateSkyLight() end

---Update Sun
---@return nil
function DayCycleManager_C.UpdateSun() end

---Calc Day Time
---@return nil
function DayCycleManager_C.CalcDayTime() end

---New Day Started
---@return nil
function DayCycleManager_C.NewDayStarted() end

---Inside Changed
---@param IsInterior boolean
---@return nil
function DayCycleManager_C.InsideChanged(IsInterior) end

return DayCycleManager_C
