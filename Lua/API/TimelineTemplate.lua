---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TimelineTemplate
---Timeline Template
---
--- Properties
---
---Length of this timeline
---@field TimelineLength number
---How we want the timeline to determine its own length (e.g. specified length, last keyframe)
---@field LengthMode integer
---If we want the timeline to auto-play
---@field bAutoPlay boolean
---If we want the timeline to loop
---@field bLoop boolean
---If we want the timeline to loop
---@field bReplicated boolean
---If we want the timeline to ignore global time dilation
---@field bIgnoreTimeDilation boolean
---Set of event tracks
---@field EventTracks TTEventTrack[]
---Set of float interpolation tracks
---@field FloatTracks TTFloatTrack[]
---Set of vector interpolation tracks
---@field VectorTracks TTVectorTrack[]
---Set of linear color interpolation tracks
---@field LinearColorTracks TTLinearColorTrack[]
---Metadata information for this timeline
---@field MetaDataArray BPVariableMetaDataEntry[]
---@field TimelineGuid Guid
---Allow control of Timeline component TickGroup assignment via TimelineTemplates
---@field TimelineTickGroup integer
local TimelineTemplate = {}

--- Methods
return TimelineTemplate
