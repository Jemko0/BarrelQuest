---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class QuartzClockHandle
---This class is a BP / Game thread wrapper around FQuartzClockProxy
---   (to talk to the underlying clock)
---...and inherits from FQuartzTickableObject
---   (to listen to the underlying clock)
---It can subscribe to Quantized Event & Metronome delegates to synchronize
---gameplay & VFX to Quartz events fired from the Audio Engine
---
--- Properties
---
local QuartzClockHandle = {}

--- Methods
---Unsubscribe from Time Division
---@param WorldContextObject Object
---@param InQuantizationBoundary EQuartzCommandQuantization
---@return nil, QuartzClockHandle
function QuartzClockHandle.UnsubscribeFromTimeDivision(WorldContextObject, InQuantizationBoundary) end

---Unsubscribe from All Time Divisions
---@param WorldContextObject Object
---@return nil, QuartzClockHandle
function QuartzClockHandle.UnsubscribeFromAllTimeDivisions(WorldContextObject) end

---Metronome subscription
---@param WorldContextObject Object
---@param InQuantizationBoundary EQuartzCommandQuantization
---@return nil, QuartzClockHandle
function QuartzClockHandle.SubscribeToQuantizationEvent(WorldContextObject, InQuantizationBoundary) end

---Subscribe to All Quantization Events
---@param WorldContextObject Object
---@return nil, QuartzClockHandle
function QuartzClockHandle.SubscribeToAllQuantizationEvents(WorldContextObject) end

---Stop Clock
---@param WorldContextObject Object
---@param CancelPendingEvents boolean
---@return nil, QuartzClockHandle
function QuartzClockHandle.StopClock(WorldContextObject, CancelPendingEvents) end

---"other" clock manipulation
---@param WorldContextObject Object
---@param OtherClockName string
---@param InQuantizationBoundary QuartzQuantizationBoundary
---@return nil
function QuartzClockHandle.StartOtherClock(WorldContextObject, OtherClockName, InQuantizationBoundary) end

---Clock manipulation
---@param WorldContextObject Object
---@return nil, QuartzClockHandle
function QuartzClockHandle.StartClock(WorldContextObject) end

---Set Ticks Per Second
---@param WorldContextObject Object
---@param TicksPerSecond number
---@return nil, QuartzClockHandle
function QuartzClockHandle.SetTicksPerSecond(WorldContextObject, TicksPerSecond) end

---Set Thirty Second Notes Per Minute
---@param WorldContextObject Object
---@param ThirtySecondsNotesPerMinute number
---@return nil, QuartzClockHandle
function QuartzClockHandle.SetThirtySecondNotesPerMinute(WorldContextObject, ThirtySecondsNotesPerMinute) end

---Set Seconds Per Tick
---@param WorldContextObject Object
---@param SecondsPerTick number
---@return nil, QuartzClockHandle
function QuartzClockHandle.SetSecondsPerTick(WorldContextObject, SecondsPerTick) end

---Metronome Alteration (setters)
---@param WorldContextObject Object
---@param MillisecondsPerTick number
---@return nil, QuartzClockHandle
function QuartzClockHandle.SetMillisecondsPerTick(WorldContextObject, MillisecondsPerTick) end

---Set Beats Per Minute
---@param WorldContextObject Object
---@param BeatsPerMinute number
---@return nil, QuartzClockHandle
function QuartzClockHandle.SetBeatsPerMinute(WorldContextObject, BeatsPerMinute) end

---Resume Clock
---@param WorldContextObject Object
---@return nil, QuartzClockHandle
function QuartzClockHandle.ResumeClock(WorldContextObject) end

---Reset Transport Quantized
---@param WorldContextObject Object
---@param InQuantizationBoundary QuartzQuantizationBoundary
---@return nil, QuartzClockHandle
function QuartzClockHandle.ResetTransportQuantized(WorldContextObject, InQuantizationBoundary) end

---Reset Transport
---@param WorldContextObject Object
---@return nil
function QuartzClockHandle.ResetTransport(WorldContextObject) end

---Pause Clock
---@param WorldContextObject Object
---@return nil, QuartzClockHandle
function QuartzClockHandle.PauseClock(WorldContextObject) end

---Notify on Quantization Boundary
---@param WorldContextObject Object
---@param InQuantizationBoundary QuartzQuantizationBoundary
---@param InMsOffset number
---@return nil
function QuartzClockHandle.NotifyOnQuantizationBoundary(WorldContextObject, InQuantizationBoundary, InMsOffset) end

---Is Clock Running
---@param WorldContextObject Object
---@return boolean
function QuartzClockHandle.IsClockRunning(WorldContextObject) end

---Get Ticks Per Second
---@param WorldContextObject Object
---@return number
function QuartzClockHandle.GetTicksPerSecond(WorldContextObject) end

---Get Thirty Second Notes Per Minute
---@param WorldContextObject Object
---@return number
function QuartzClockHandle.GetThirtySecondNotesPerMinute(WorldContextObject) end

---Get Seconds Per Tick
---@param WorldContextObject Object
---@return number
function QuartzClockHandle.GetSecondsPerTick(WorldContextObject) end

---Metronome getters
---@param WorldContextObject Object
---@return number
function QuartzClockHandle.GetMillisecondsPerTick(WorldContextObject) end

---Returns the amount of time, in seconds, the clock has been running. Caution: due to latency, this will not be perfectly accurate
---@param WorldContextObject Object
---@return number
function QuartzClockHandle.GetEstimatedRunTime(WorldContextObject) end

---Returns the duration in seconds of the given Quantization Type
---@param WorldContextObject Object
---@param Multiplier number
---@return number
function QuartzClockHandle.GetDurationOfQuantizationTypeInSeconds(WorldContextObject, Multiplier) end

---Retrieves a timestamp for the clock
---@param WorldContextObject Object
---@return QuartzTransportTimeStamp
function QuartzClockHandle.GetCurrentTimestamp(WorldContextObject) end

---Get Beats Per Minute
---@param WorldContextObject Object
---@return number
function QuartzClockHandle.GetBeatsPerMinute(WorldContextObject) end

---Returns the current progress until the next occurrence of the provided musical duration as a float value from 0 (previous beat) to 1 (next beat).
---This is useful for indexing into curves to animate parameters to musical time.
---Ms and Phase offsets are combined internally.
---@param QuantizationBoundary EQuartzCommandQuantization
---@param PhaseOffset number
---@param MsOffset number
---@return number
function QuartzClockHandle.GetBeatProgressPercent(QuantizationBoundary, PhaseOffset, MsOffset) end

return QuartzClockHandle
