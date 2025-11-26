---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class DebugTextInfo
---* Single entry of a debug text item to render.
---*
---* @see AHud
---* @see AddDebugText(), RemoveDebugText() and DrawDebugTextList()
---
--- Properties
---AActor related to text item
---@field SrcActor Actor
---Offset from SrcActor.Location to apply
---@field SrcActorOffset Vector
---Desired offset to interpolate to
---@field SrcActorDesiredOffset Vector
---Text to display
---@field DebugText string
---Time remaining for the debug text, -1.f == infinite
---@field TimeRemaining number
---Duration used to lerp desired offset
---@field Duration number
---Text color
---@field TextColor Color
---whether the offset should be treated as absolute world location of the string
---@field bAbsoluteLocation boolean
---If the actor moves does the text also move with it?
---@field bKeepAttachedToActor boolean
---Whether to draw a shadow for the text
---@field bDrawShadow boolean
---When we first spawn store off the original actor location for use with bKeepAttachedToActor
---@field OrigActorLocation Vector
---The Font which to display this as.  Will Default to GetSmallFont()*
---@field Font Font
---Scale to apply to font when rendering
---@field FontScale number
local DebugTextInfo = {}

--- Constructor
---@return DebugTextInfo
---@param SrcActor Actor
---@param SrcActorOffset Vector
---@param SrcActorDesiredOffset Vector
---@param DebugText string
---@param TimeRemaining number
---@param Duration number
---@param TextColor Color
---@param bAbsoluteLocation boolean
---@param bKeepAttachedToActor boolean
---@param bDrawShadow boolean
---@param OrigActorLocation Vector
---@param Font Font
---@param FontScale number
function DebugTextInfo.new(SrcActor, SrcActorOffset, SrcActorDesiredOffset, DebugText, TimeRemaining, Duration, TextColor, bAbsoluteLocation, bKeepAttachedToActor, bDrawShadow, OrigActorLocation, Font, FontScale)
    local self = {}
    self.SrcActor = SrcActor
    self.SrcActorOffset = SrcActorOffset
    self.SrcActorDesiredOffset = SrcActorDesiredOffset
    self.DebugText = DebugText
    self.TimeRemaining = TimeRemaining
    self.Duration = Duration
    self.TextColor = TextColor
    self.bAbsoluteLocation = bAbsoluteLocation
    self.bKeepAttachedToActor = bKeepAttachedToActor
    self.bDrawShadow = bDrawShadow
    self.OrigActorLocation = OrigActorLocation
    self.Font = Font
    self.FontScale = FontScale
    return self
end

return DebugTextInfo
