---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TimelineComponent : ActorComponent
---TimelineComponent holds a series of events, floats, vectors or colors with associated keyframes.
---Events can be triggered at keyframes along the timeline.
---Floats, vectors, and colors are interpolated between keyframes along the timeline.
---
--- Properties
---
local TimelineComponent = {}

--- Methods
---Stop playback of timeline
---@return nil
function TimelineComponent.Stop() end

---Update a certain vector track's curve
---@param NewVectorCurve CurveVector
---@param VectorTrackName string
---@return nil
function TimelineComponent.SetVectorCurve(NewVectorCurve, VectorTrackName) end

---Set the delegate to call after each timeline tick
---@param NewTimelinePostUpdateFunc function
---@return nil
function TimelineComponent.SetTimelinePostUpdateFunc(NewTimelinePostUpdateFunc) end

---Sets the length mode of the timeline
---@param NewLengthMode integer
---@return nil
function TimelineComponent.SetTimelineLengthMode(NewLengthMode) end

---Set length of the timeline
---@param NewLength number
---@return nil
function TimelineComponent.SetTimelineLength(NewLength) end

---Set the delegate to call when timeline is finished
---@param NewTimelineFinishedFunc function
---@return nil
function TimelineComponent.SetTimelineFinishedFunc(NewTimelineFinishedFunc) end

---Sets the new play rate for this timeline
---@param NewRate number
---@return nil
function TimelineComponent.SetPlayRate(NewRate) end

---Jump to a position in the timeline.
---@param NewPosition number
---@param bFireEvents boolean
---@param bFireUpdate boolean
---@return nil
function TimelineComponent.SetPlaybackPosition(NewPosition, bFireEvents, bFireUpdate) end

---Set the new playback position time to use
---@param NewTime number
---@return nil
function TimelineComponent.SetNewTime(NewTime) end

---true means we would loop, false means we should not.
---@param bNewLooping boolean
---@return nil
function TimelineComponent.SetLooping(bNewLooping) end

---Update a certain linear color track's curve
---@param NewLinearColorCurve CurveLinearColor
---@param LinearColorTrackName string
---@return nil
function TimelineComponent.SetLinearColorCurve(NewLinearColorCurve, LinearColorTrackName) end

---Set whether to ignore time dilation.
---@param bNewIgnoreTimeDilation boolean
---@return nil
function TimelineComponent.SetIgnoreTimeDilation(bNewIgnoreTimeDilation) end

---Update a certain float track's curve
---@param NewFloatCurve CurveFloat
---@param FloatTrackName string
---@return nil
function TimelineComponent.SetFloatCurve(NewFloatCurve, FloatTrackName) end

---Start playback of timeline in reverse from the end
---@return nil
function TimelineComponent.ReverseFromEnd() end

---Start playback of timeline in reverse
---@return nil
function TimelineComponent.Reverse() end

---Start playback of timeline from the start
---@return nil
function TimelineComponent.PlayFromStart() end

---Start playback of timeline
---@return nil
function TimelineComponent.Play() end

---Get whether we are reversing or not
---@return boolean
function TimelineComponent.IsReversing() end

---Get whether this timeline is playing or not.
---@return boolean
function TimelineComponent.IsPlaying() end

---Get whether we are looping or not
---@return boolean
function TimelineComponent.IsLooping() end

---Get length of the timeline
---@return number
function TimelineComponent.GetTimelineLength() end

---Get length of the timeline divided by the play rate
---@return number
function TimelineComponent.GetScaledTimelineLength() end

---Get the current play rate for this timeline
---@return number
function TimelineComponent.GetPlayRate() end

---Get the current playback position of the Timeline
---@return number
function TimelineComponent.GetPlaybackPosition() end

---Get whether to ignore time dilation.
---@return boolean
function TimelineComponent.GetIgnoreTimeDilation() end

---Add a vector interpolation to the timeline
---@param VectorCurve CurveVector
---@param InterpFunc function
---@param PropertyName string
---@param TrackName string
---@return nil
function TimelineComponent.AddInterpVector(VectorCurve, InterpFunc, PropertyName, TrackName) end

---Add a linear color interpolation to the timeline
---@param LinearColorCurve CurveLinearColor
---@param InterpFunc function
---@param PropertyName string
---@param TrackName string
---@return nil
function TimelineComponent.AddInterpLinearColor(LinearColorCurve, InterpFunc, PropertyName, TrackName) end

---Add a float interpolation to the timeline
---@param FloatCurve CurveFloat
---@param InterpFunc function
---@param PropertyName string
---@param TrackName string
---@return nil
function TimelineComponent.AddInterpFloat(FloatCurve, InterpFunc, PropertyName, TrackName) end

---Add a callback event to the timeline
---@param Time number
---@param EventFunc function
---@return nil
function TimelineComponent.AddEvent(Time, EventFunc) end

return TimelineComponent
