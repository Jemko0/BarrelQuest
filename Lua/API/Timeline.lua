---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Timeline
---Timeline
---
--- Properties
---Specified how the timeline determines its own length (e.g. specified length, last keyframe)
---@field LengthMode integer
---Whether timeline should loop when it reaches the end, or stop
---@field bLooping boolean
---If playback should move the current position backwards instead of forwards
---@field bReversePlayback boolean
---@field bPlaying boolean
---If the first bit is set to 1 (PlayingStateTracker & 0x01 == 1), then we are playing
---The rest of the bits in the uint8 are reserved for keeping track of the "dirty" state,
---being incremented when our state is modified. This ensures that the value is replicated
---if it changes multiple times in one frame, such as calling "Play From Start" in the resulting
---"Finished" delegate.
---You should modify this value using the "ChangeMarkPlayingState" function.
---@field PlayingStateTracker integer
---How long the timeline is, will stop or loop at the end
---@field Length number
---How fast we should play through the timeline
---@field PlayRate number
---Current position in the timeline
---@field Position number
---Array of events that are fired at various times during the timeline
---@field Events TimelineEventEntry[]
---Array of vector interpolations performed during the timeline
---@field InterpVectors TimelineVectorTrack[]
---Array of float interpolations performed during the timeline
---@field InterpFloats TimelineFloatTrack[]
---Array of linear color interpolations performed during the timeline
---@field InterpLinearColors TimelineLinearColorTrack[]
---Called whenever this timeline is playing and updates - done after all delegates are executed and variables updated
---@field TimelinePostUpdateFunc function
---Called whenever this timeline is finished. Is not called if 'stop' is used to terminate timeline early
---@field TimelineFinishedFunc function
---Optional. If set, Timeline will also set float/vector properties on this object using the PropertyName set in the tracks.
---@field PropertySetObject any
---Optional. If set, Timeline will also set ETimelineDirection property on PropertySetObject using the name.
---@field DirectionPropertyName string
local Timeline = {}

--- Constructor
---@return Timeline
---@param LengthMode integer
---@param bLooping boolean
---@param bReversePlayback boolean
---@param bPlaying boolean
---@param PlayingStateTracker integer
---@param Length number
---@param PlayRate number
---@param Position number
---@param Events TimelineEventEntry[]
---@param InterpVectors TimelineVectorTrack[]
---@param InterpFloats TimelineFloatTrack[]
---@param InterpLinearColors TimelineLinearColorTrack[]
---@param TimelinePostUpdateFunc function
---@param TimelineFinishedFunc function
---@param PropertySetObject any
---@param DirectionPropertyName string
function Timeline.new(LengthMode, bLooping, bReversePlayback, bPlaying, PlayingStateTracker, Length, PlayRate, Position, Events, InterpVectors, InterpFloats, InterpLinearColors, TimelinePostUpdateFunc, TimelineFinishedFunc, PropertySetObject, DirectionPropertyName)
    local self = {}
    self.LengthMode = LengthMode
    self.bLooping = bLooping
    self.bReversePlayback = bReversePlayback
    self.bPlaying = bPlaying
    self.PlayingStateTracker = PlayingStateTracker
    self.Length = Length
    self.PlayRate = PlayRate
    self.Position = Position
    self.Events = Events
    self.InterpVectors = InterpVectors
    self.InterpFloats = InterpFloats
    self.InterpLinearColors = InterpLinearColors
    self.TimelinePostUpdateFunc = TimelinePostUpdateFunc
    self.TimelineFinishedFunc = TimelineFinishedFunc
    self.PropertySetObject = PropertySetObject
    self.DirectionPropertyName = DirectionPropertyName
    return self
end

return Timeline
