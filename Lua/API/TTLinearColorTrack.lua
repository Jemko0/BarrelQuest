---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class TTLinearColorTrack
---Structure storing information about one color interpolation track
---
--- Properties
---Curve object used to define color value over time
---@field CurveLinearColor CurveLinearColor
---@field PropertyName string
---Name of this track
---@field TrackName string
---Flag to identify internal/external curve
---@field bIsExternalCurve boolean
---Whether or not this track is expanded in the UI.
---@field bIsExpanded boolean
---Whether or not this track has its curve's view synchronized with the other curve views.
---@field bIsCurveViewSynchronized boolean
local TTLinearColorTrack = {}
return TTLinearColorTrack
