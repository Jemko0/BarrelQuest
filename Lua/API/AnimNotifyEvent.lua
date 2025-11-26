---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class AnimNotifyEvent
---Triggers an animation notify.  Each AnimNotifyEvent contains an AnimNotify object
---which has its Notify method called and passed to the animation.
---
--- Properties
---
---The user requested time for this notify
---@field DisplayTime number
---An offset from the DisplayTime to the actual time we will trigger the notify, as we cannot always trigger it exactly at the time the user wants
---@field TriggerTimeOffset number
---An offset similar to TriggerTimeOffset but used for the end scrub handle of a notify state's duration
---@field EndTriggerTimeOffset number
---@field TriggerWeightThreshold number
---@field NotifyName string
---@field Notify AnimNotify
---@field NotifyStateClass AnimNotifyState
---@field Duration number
---Linkable element to use for the end handle representing a notify state duration
---@field EndLink AnimLinkableElement
---If TRUE, this notify has been converted from an old BranchingPoint.
---@field bConvertedFromBranchingPoint boolean
---@field MontageTickType integer
---Defines the chance of this notify triggering, 0 = No Chance, 1 = Always triggers
---@field NotifyTriggerChance number
---Defines a method for filtering notifies (stopping them triggering) e.g. by looking at the meshes current LOD
---@field NotifyFilterType integer
---LOD to start filtering this notify from.
---@field NotifyFilterLOD integer
---Allow notify event to be filtered if requested at runtime (e. g. via an Anim Graph Message)
---@field bCanBeFilteredViaRequest boolean
---If disabled this notify will be skipped on dedicated servers
---@field bTriggerOnDedicatedServer boolean
---If enabled this notify will trigger when the animation is a follower in a sync group (by default only the sync group leaders notifies trigger
---@field bTriggerOnFollower boolean
---Color of Notify in editor
---@field NotifyColor Color
---Guid for tracking notifies in editor
---@field Guid Guid
---'Track' that the notify exists on, used for visual placement in editor and sorting priority in runtime
---@field TrackIndex integer
---The montage that this element is currently linked to
---@field LinkedMontage AnimMontage
---The slot index we are currently using within LinkedMontage
---@field SlotIndex integer
---The index of the segment we are linked to within the slot we are using
---@field SegmentIndex integer
---The method we are using to calculate our times
---@field LinkMethod integer
---Cached link method used to transform the time when LinkMethod changes, always relates to the currently stored time
---@field CachedLinkMethod integer
---The absolute time in the montage that our currently linked segment begins
---@field SegmentBeginTime number
---The absolute length of our currently linked segment
---@field SegmentLength number
---The time of this montage. This will differ depending upon the method we are using to link the time for this element
---@field LinkValue number
---The Animation Sequence that this montage element will link to, when the sequence changes
---in either length or rate; the element will correctly place itself in relation to the sequence
---@field LinkedSequence AnimSequenceBase
local AnimNotifyEvent = {}

--- Constructor
---@return AnimNotifyEvent
---@param DisplayTime number
---@param TriggerTimeOffset number
---@param EndTriggerTimeOffset number
---@param TriggerWeightThreshold number
---@param NotifyName string
---@param Notify AnimNotify
---@param NotifyStateClass AnimNotifyState
---@param Duration number
---@param EndLink AnimLinkableElement
---@param bConvertedFromBranchingPoint boolean
---@param MontageTickType integer
---@param NotifyTriggerChance number
---@param NotifyFilterType integer
---@param NotifyFilterLOD integer
---@param bCanBeFilteredViaRequest boolean
---@param bTriggerOnDedicatedServer boolean
---@param bTriggerOnFollower boolean
---@param NotifyColor Color
---@param Guid Guid
---@param TrackIndex integer
---@param LinkedMontage AnimMontage
---@param SlotIndex integer
---@param SegmentIndex integer
---@param LinkMethod integer
---@param CachedLinkMethod integer
---@param SegmentBeginTime number
---@param SegmentLength number
---@param LinkValue number
---@param LinkedSequence AnimSequenceBase
function AnimNotifyEvent.new(DisplayTime, TriggerTimeOffset, EndTriggerTimeOffset, TriggerWeightThreshold, NotifyName, Notify, NotifyStateClass, Duration, EndLink, bConvertedFromBranchingPoint, MontageTickType, NotifyTriggerChance, NotifyFilterType, NotifyFilterLOD, bCanBeFilteredViaRequest, bTriggerOnDedicatedServer, bTriggerOnFollower, NotifyColor, Guid, TrackIndex, LinkedMontage, SlotIndex, SegmentIndex, LinkMethod, CachedLinkMethod, SegmentBeginTime, SegmentLength, LinkValue, LinkedSequence)
    local self = {}
    self.DisplayTime = DisplayTime
    self.TriggerTimeOffset = TriggerTimeOffset
    self.EndTriggerTimeOffset = EndTriggerTimeOffset
    self.TriggerWeightThreshold = TriggerWeightThreshold
    self.NotifyName = NotifyName
    self.Notify = Notify
    self.NotifyStateClass = NotifyStateClass
    self.Duration = Duration
    self.EndLink = EndLink
    self.bConvertedFromBranchingPoint = bConvertedFromBranchingPoint
    self.MontageTickType = MontageTickType
    self.NotifyTriggerChance = NotifyTriggerChance
    self.NotifyFilterType = NotifyFilterType
    self.NotifyFilterLOD = NotifyFilterLOD
    self.bCanBeFilteredViaRequest = bCanBeFilteredViaRequest
    self.bTriggerOnDedicatedServer = bTriggerOnDedicatedServer
    self.bTriggerOnFollower = bTriggerOnFollower
    self.NotifyColor = NotifyColor
    self.Guid = Guid
    self.TrackIndex = TrackIndex
    self.LinkedMontage = LinkedMontage
    self.SlotIndex = SlotIndex
    self.SegmentIndex = SegmentIndex
    self.LinkMethod = LinkMethod
    self.CachedLinkMethod = CachedLinkMethod
    self.SegmentBeginTime = SegmentBeginTime
    self.SegmentLength = SegmentLength
    self.LinkValue = LinkValue
    self.LinkedSequence = LinkedSequence
    return self
end

return AnimNotifyEvent
