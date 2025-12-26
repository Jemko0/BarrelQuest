---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class AnimSequence : AnimSequenceBase
---Anim Sequence
---
--- Properties
---
---The DCC framerate of the imported file. UI information only, unit are Hz
---@field ImportFileFramerate number
---The resample framerate that was computed during import. UI information only, unit are Hz
---@field ImportResampleFramerate integer
---@field NumFrames integer
---@field NumberOfKeys integer
---@field SamplingFrameRate FrameRate
---@field RawDataGuid Guid
---@field AnimationTrackNames string[]
---Allow frame stripping to be performed on this animation if the platform requests it
---Can be disabled if animation has high frequency movements that are being lost.
---@field bAllowFrameStripping boolean
---Set a scale for error threshold on compression. This is useful if the animation will
---be played back at a different scale (e.g. if you know the animation will be played
---on an actor/component that is scaled up by a factor of 10, set this value to 10)
---@field CompressionErrorThresholdScale number
---The bone compression settings used to compress bones in this sequence.
---@field BoneCompressionSettings AnimBoneCompressionSettings
---The curve compression settings used to compress curves in this sequence.
---@field CurveCompressionSettings AnimCurveCompressionSettings
---@field VariableFrameStrippingSettings VariableFrameStrippingSettings
---Additive animation type. *
---@field AdditiveAnimType integer
---Additive refrerence pose type. Refer above enum type
---@field RefPoseType integer
---Additve reference frame if RefPoseType == AnimFrame *
---@field RefFrameIndex integer
---Additive reference animation if it's relevant - i.e. AnimScaled or AnimFrame *
---@field RefPoseSeq AnimSequence
---Base pose to use when retargeting
---@field RetargetSource string
---@field RetargetSourceAsset any
---When using RetargetSourceAsset, use the post stored here
---@field RetargetSourceAssetReferencePose Transform[]
---This defines how values between keys are calculated *
---@field Interpolation EAnimInterpolationType
---If this is on, it will allow extracting of root motion *
---@field bEnableRootMotion boolean
---Root Bone will be locked to that position when extracting root motion.*
---@field RootMotionRootLock integer
---Force Root Bone Lock even if Root Motion is not enabled
---@field bForceRootLock boolean
---If this is on, it will use a normalized scale value for the root motion extracted: FVector(1.0, 1.0, 1.0) *
---@field bUseNormalizedRootMotionScale boolean
---Have we copied root motion settings from an owning montage
---@field bRootMotionSettingsCopiedFromMontage boolean
---Saved version number with CompressAnimations commandlet. To help with doing it in multiple passes.
---@field CompressCommandletVersion integer
---Do not attempt to override compression scheme when running CompressAnimations commandlet.
---Some high frequency animations are too sensitive and shouldn't be changed.
---@field bDoNotOverrideCompression boolean
---Importing data and options used for this mesh
---@field AssetImportData AssetImportData
---Path to the resource used to construct this skeletal mesh
---@field SourceFilePath string
---Date/Time-stamp of the file from the last import
---@field SourceFileTimestamp string
---Enum used to decide whether we should strip animation data on dedicated server
---@field StripAnimDataOnDedicatedServer EStripAnimDataOnDedicatedServerSettings
---Authored Sync markers
---@field AuthoredSyncMarkers AnimSyncMarker[]
---@field PlatformTargetFrameRate PerPlatformFrameRate
---@field TargetFrameRate FrameRate
---@field NumberOfSampledKeys integer
---@field NumberOfSampledFrames integer
---@field AttributeCurves table<AnimationAttributeIdentifier, AttributeCurve>
local AnimSequence = {}

--- Methods
---Update the retarget data pose from the source, if it exist, else clears the retarget data pose saved in RetargetSourceAssetReferencePose.
---Warning : This function calls LoadSynchronous at the retarget source asset soft object pointer, so it can not be used at PostLoad
---@return nil
function AnimSequence.UpdateRetargetSourceAssetData() end

---Assigns the passed skeletal mesh to the retarget source
---@param InRetargetSourceAsset SkeletalMesh
---@return nil
function AnimSequence.SetRetargetSourceAsset(InRetargetSourceAsset) end

---Returns the retarget source asset soft object pointer.
---@return any
function AnimSequence.GetRetargetSourceAsset() end

---Resets the retarget source asset
---@return nil
function AnimSequence.ClearRetargetSourceAsset() end

return AnimSequence
