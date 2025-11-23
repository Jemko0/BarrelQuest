---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class TTEventTrack
---Structure storing information about one event track
---
--- Properties
---@field FunctionName string
---Curve object used to store keys
---@field CurveKeys CurveFloat
---Name of this track
---@field TrackName string
---Flag to identify internal/external curve
---@field bIsExternalCurve boolean
---Whether or not this track is expanded in the UI.
---@field bIsExpanded boolean
---Whether or not this track has its curve's view synchronized with the other curve views.
---@field bIsCurveViewSynchronized boolean
local TTEventTrack = {}
return TTEventTrack
