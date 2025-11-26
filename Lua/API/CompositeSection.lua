---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CompositeSection
---Section data for each track. Reference of data will be stored in the child class for the way they want
---AnimComposite vs AnimMontage have different requirement for the actual data reference
---This only contains composite section information. (vertical sequences)
---
--- Properties
---
---Section Name
---@field SectionName string
---Start Time *
---@field StartTime number
---Should this animation loop.
---@field NextSectionName string
---Meta data that can be saved with the asset
---You can query by GetMetaData function
---@field MetaData AnimMetaData[]
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
local CompositeSection = {}

--- Constructor
---@return CompositeSection
---@param SectionName string
---@param StartTime number
---@param NextSectionName string
---@param MetaData AnimMetaData[]
---@param LinkedMontage AnimMontage
---@param SlotIndex integer
---@param SegmentIndex integer
---@param LinkMethod integer
---@param CachedLinkMethod integer
---@param SegmentBeginTime number
---@param SegmentLength number
---@param LinkValue number
---@param LinkedSequence AnimSequenceBase
function CompositeSection.new(SectionName, StartTime, NextSectionName, MetaData, LinkedMontage, SlotIndex, SegmentIndex, LinkMethod, CachedLinkMethod, SegmentBeginTime, SegmentLength, LinkValue, LinkedSequence)
    local self = {}
    self.SectionName = SectionName
    self.StartTime = StartTime
    self.NextSectionName = NextSectionName
    self.MetaData = MetaData
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

return CompositeSection
