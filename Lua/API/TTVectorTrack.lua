---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TTVectorTrack
---Structure storing information about one vector interpolation track
---
--- Properties
---
---Curve object used to define vector value over time
---@field CurveVector CurveVector
---@field PropertyName string
---Name of this track
---@field TrackName string
---Flag to identify internal/external curve
---@field bIsExternalCurve boolean
---Whether or not this track is expanded in the UI.
---@field bIsExpanded boolean
---Whether or not this track has its curve's view synchronized with the other curve views.
---@field bIsCurveViewSynchronized boolean
local TTVectorTrack = {}

--- Constructor
---@return TTVectorTrack
---@param CurveVector CurveVector
---@param PropertyName string
---@param TrackName string
---@param bIsExternalCurve boolean
---@param bIsExpanded boolean
---@param bIsCurveViewSynchronized boolean
function TTVectorTrack.new(CurveVector, PropertyName, TrackName, bIsExternalCurve, bIsExpanded, bIsCurveViewSynchronized)
    local self = {}
    self.CurveVector = CurveVector
    self.PropertyName = PropertyName
    self.TrackName = TrackName
    self.bIsExternalCurve = bIsExternalCurve
    self.bIsExpanded = bIsExpanded
    self.bIsCurveViewSynchronized = bIsCurveViewSynchronized
    return self
end

return TTVectorTrack
