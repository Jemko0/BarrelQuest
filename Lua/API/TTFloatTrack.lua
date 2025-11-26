---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TTFloatTrack
---Structure storing information about one float interpolation track
---
--- Properties
---
---Curve object used to define float value over time
---@field CurveFloat CurveFloat
---@field PropertyName string
---Name of this track
---@field TrackName string
---Flag to identify internal/external curve
---@field bIsExternalCurve boolean
---Whether or not this track is expanded in the UI.
---@field bIsExpanded boolean
---Whether or not this track has its curve's view synchronized with the other curve views.
---@field bIsCurveViewSynchronized boolean
local TTFloatTrack = {}

--- Constructor
---@return TTFloatTrack
---@param CurveFloat CurveFloat
---@param PropertyName string
---@param TrackName string
---@param bIsExternalCurve boolean
---@param bIsExpanded boolean
---@param bIsCurveViewSynchronized boolean
function TTFloatTrack.new(CurveFloat, PropertyName, TrackName, bIsExternalCurve, bIsExpanded, bIsCurveViewSynchronized)
    local self = {}
    self.CurveFloat = CurveFloat
    self.PropertyName = PropertyName
    self.TrackName = TrackName
    self.bIsExternalCurve = bIsExternalCurve
    self.bIsExpanded = bIsExpanded
    self.bIsCurveViewSynchronized = bIsCurveViewSynchronized
    return self
end

return TTFloatTrack
