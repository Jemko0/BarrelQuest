---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class QuartzQuantizationBoundary
---struct used to specify the quantization boundary of an event
---
--- Properties
---resolution we are interested in
---@field Quantization EQuartzCommandQuantization
---how many "Resolutions" to wait before the onset we care about
---@field Multiplier number
---@field CountingReferencePoint EQuarztQuantizationReference
---If this is true and the Clock hasn't started yet, the event will fire immediately when the Clock starts
---@field bFireOnClockStart boolean
---If this is true, this command will be canceled if the Clock is stopped or otherwise not running
---@field bCancelCommandIfClockIsNotRunning boolean
---If this is true, queueing the sound will also call a Reset Clock command
---@field bResetClockOnQueued boolean
---If this is true, queueing the sound will also call a Resume Clock command
---@field bResumeClockOnQueued boolean
local QuartzQuantizationBoundary = {}

--- Constructor
---@return QuartzQuantizationBoundary
---@param Quantization EQuartzCommandQuantization
---@param Multiplier number
---@param CountingReferencePoint EQuarztQuantizationReference
---@param bFireOnClockStart boolean
---@param bCancelCommandIfClockIsNotRunning boolean
---@param bResetClockOnQueued boolean
---@param bResumeClockOnQueued boolean
function QuartzQuantizationBoundary.new(Quantization, Multiplier, CountingReferencePoint, bFireOnClockStart, bCancelCommandIfClockIsNotRunning, bResetClockOnQueued, bResumeClockOnQueued)
    local self = {}
    self.Quantization = Quantization
    self.Multiplier = Multiplier
    self.CountingReferencePoint = CountingReferencePoint
    self.bFireOnClockStart = bFireOnClockStart
    self.bCancelCommandIfClockIsNotRunning = bCancelCommandIfClockIsNotRunning
    self.bResetClockOnQueued = bResetClockOnQueued
    self.bResumeClockOnQueued = bResumeClockOnQueued
    return self
end

return QuartzQuantizationBoundary
