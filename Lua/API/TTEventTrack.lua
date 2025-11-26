---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TTEventTrack
---Structure storing information about one event track
---
--- Properties
---
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

--- Constructor
---@return TTEventTrack
---@param FunctionName string
---@param CurveKeys CurveFloat
---@param TrackName string
---@param bIsExternalCurve boolean
---@param bIsExpanded boolean
---@param bIsCurveViewSynchronized boolean
function TTEventTrack.new(FunctionName, CurveKeys, TrackName, bIsExternalCurve, bIsExpanded, bIsCurveViewSynchronized)
    local self = {}
    self.FunctionName = FunctionName
    self.CurveKeys = CurveKeys
    self.TrackName = TrackName
    self.bIsExternalCurve = bIsExternalCurve
    self.bIsExpanded = bIsExpanded
    self.bIsCurveViewSynchronized = bIsCurveViewSynchronized
    return self
end

return TTEventTrack
