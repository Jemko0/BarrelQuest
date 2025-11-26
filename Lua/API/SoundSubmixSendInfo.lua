---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SoundSubmixSendInfo
---Sound Submix Send Info
---
--- Properties
---Defines at what mix stage the send should happen.
---@field SendStage ESubmixSendStage
---Manual: Use Send Level only
---Linear: Interpolate between Min and Max Send Levels based on listener distance (between Min/Max Send Distance)
---Custom Curve: Use the float curve to map Send Level to distance (0.0-1.0 on curve maps to Min/Max Send Distance)
---@field SendLevelControlMethod ESendLevelControlMethod
---The Submix to send the audio to
---@field SoundSubmix SoundSubmixBase
---Manually set the amount of audio to send
---@field SendLevel number
---Whether to disable the internal 0-1 clamp for Manual Send Level control
---@field DisableManualSendClamp boolean
---The amount to send to the Submix when sound is located at a distance less than or equal to value specified in the Min Send Distance
---@field MinSendLevel number
---The amount to send to the Submix when sound is located at a distance greater than or equal to value specified in the Max Send Distance
---@field MaxSendLevel number
---The distance at which to start mapping between to Min/Max Send Level
---Distances LESS than this will result in a clamped Min Send Level
---@field MinSendDistance number
---The distance at which to stop mapping between Min/Max Send Level
---Distances GREATER than this will result in a clamped Max Send Level
---@field MaxSendDistance number
---The custom send curve to use for distance-based send level. (0.0-1.0 on the curve's X-axis maps to Min/Max Send Distance)
---@field CustomSendLevelCurve RuntimeFloatCurve
local SoundSubmixSendInfo = {}

--- Constructor
---@return SoundSubmixSendInfo
---@param SendStage ESubmixSendStage
---@param SendLevelControlMethod ESendLevelControlMethod
---@param SoundSubmix SoundSubmixBase
---@param SendLevel number
---@param DisableManualSendClamp boolean
---@param MinSendLevel number
---@param MaxSendLevel number
---@param MinSendDistance number
---@param MaxSendDistance number
---@param CustomSendLevelCurve RuntimeFloatCurve
function SoundSubmixSendInfo.new(SendStage, SendLevelControlMethod, SoundSubmix, SendLevel, DisableManualSendClamp, MinSendLevel, MaxSendLevel, MinSendDistance, MaxSendDistance, CustomSendLevelCurve)
    local self = {}
    self.SendStage = SendStage
    self.SendLevelControlMethod = SendLevelControlMethod
    self.SoundSubmix = SoundSubmix
    self.SendLevel = SendLevel
    self.DisableManualSendClamp = DisableManualSendClamp
    self.MinSendLevel = MinSendLevel
    self.MaxSendLevel = MaxSendLevel
    self.MinSendDistance = MinSendDistance
    self.MaxSendDistance = MaxSendDistance
    self.CustomSendLevelCurve = CustomSendLevelCurve
    return self
end

return SoundSubmixSendInfo
