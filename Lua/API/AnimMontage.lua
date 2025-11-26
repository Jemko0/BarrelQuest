---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AnimMontage : AnimCompositeBase
---Any property you're adding to AnimMontage and parent class has to be considered for Child Asset
---Child Asset is considered to be only asset mapping feature using everything else in the class
---For example, you can just use all parent's setting  for the montage, but only remap assets
---This isn't magic bullet unfortunately and it is consistent effort of keeping the data synced with parent
---If you add new property, please make sure those property has to be copied for children.
---If it does, please add the copy in the function RefreshParentAssetData
---
--- Properties
---@field BlendModeIn EMontageBlendMode
---@field BlendModeOut EMontageBlendMode
---Blend in option.
---@field BlendIn AlphaBlend
---@field BlendInTime number
---Blend out option. This is only used when it blends out itself. If it's interrupted by other montages, it will use new montage's BlendIn option to blend out.
---@field BlendOut AlphaBlend
---@field BlendOutTime number
---Time from Sequence End to trigger blend out.
---<0 means using BlendOutTime, so BlendOut finishes as Montage ends.
--->=0 means using 'SequenceEnd - BlendOutTriggerTime' to trigger blend out.
---@field BlendOutTriggerTime number
---If you're using marker based sync for this montage, make sure to add sync group name. For now we only support one group
---@field SyncGroup string
---Index of the slot track used for collecting sync markers
---@field SyncSlotIndex integer
---@field MarkerData MarkerSyncData
---composite section.
---@field CompositeSections CompositeSection[]
---slot data, each slot contains anim track
---@field SlotAnimTracks SlotAnimationTrack[]
---Remove this when VER_UE4_MONTAGE_BRANCHING_POINT_REMOVAL is removed.
---@field BranchingPoints BranchingPoint[]
---If this is on, it will allow extracting root motion translation. DEPRECATED in 4.5 root motion is controlled by anim sequences *
---@field bEnableRootMotionTranslation boolean
---If this is on, it will allow extracting root motion rotation. DEPRECATED in 4.5 root motion is controlled by anim sequences *
---@field bEnableRootMotionRotation boolean
---When it hits end, it automatically blends out. If this is false, it won't blend out but keep the last pose until stopped explicitly
---@field bEnableAutoBlendOut boolean
---The blend profile to use.
---@field BlendProfileIn BlendProfile
---The blend profile to use.
---@field BlendProfileOut BlendProfile
---Root Bone will be locked to that position when extracting root motion. DEPRECATED in 4.5 root motion is controlled by anim sequences *
---@field RootMotionRootLock integer
---Preview Base pose for additive BlendSpace *
---@field PreviewBasePose AnimSequence
---Keep track of which AnimNotify_State are marked as BranchingPoints, so we can update their state when the Montage is ticked
---@field BranchingPointStateNotifyIndices integer[]
---Time stretch curve will only be used when the montage has a non-default play rate
---@field TimeStretchCurve TimeStretchCurve
---Name of optional TimeStretchCurveName to look for in Montage. Time stretch curve will only be used when the montage has a non-default play rate
---@field TimeStretchCurveName string
local AnimMontage = {}

--- Methods
---@param InSectionName string
---@return boolean
function AnimMontage.IsValidSectionName(InSectionName) end

---Check if this slot has a valid additive animation for the specified slot.
---The slot name should not include the group name.
---i.e. for "DefaultGroup.DefaultSlot", the slot name is "DefaultSlot".
---@return boolean
function AnimMontage.IsValidAdditiveSlot() end

---Is Dynamic Montage
---@return boolean
function AnimMontage.IsDynamicMontage() end

---Get SectionName from SectionIndex. Returns NAME_None if not found
---@param SectionIndex integer
---@return string
function AnimMontage.GetSectionName(SectionIndex) end

---Get SectionIndex from SectionName. Returns INDEX_None if not found
---@param InSectionName string
---@return integer
function AnimMontage.GetSectionIndex(InSectionName) end

---Returns the number of sections this montage has
---@return integer
function AnimMontage.GetNumSections() end

---Get the Montage's Group Name. This is the group from the first slot.
---@return string
function AnimMontage.GetGroupName() end

---Get First Anim Reference
---@return AnimSequenceBase
function AnimMontage.GetFirstAnimReference() end

---Get Default Blend Out Time
---@return number
function AnimMontage.GetDefaultBlendOutTime() end

---Get Default Blend in Time
---@return number
function AnimMontage.GetDefaultBlendInTime() end

---Get Blend Out Args
---@return AlphaBlendArgs
function AnimMontage.GetBlendOutArgs() end

---Get Blend in Args
---@return AlphaBlendArgs
function AnimMontage.GetBlendInArgs() end

---Utility function to create dynamic montage from AnimSequence with blend in settings
---@param Asset AnimSequenceBase
---@param SlotNodeName string
---@param InPlayRate number
---@param LoopCount integer
---@param InBlendOutTriggerTime number
---@return AnimMontage
function AnimMontage.CreateSlotAnimationAsDynamicMontage_WithBlendSettings(Asset, SlotNodeName, InPlayRate, LoopCount, InBlendOutTriggerTime) end

return AnimMontage
