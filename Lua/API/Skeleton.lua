---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class Skeleton
---USkeleton : that links between mesh and animation
---        - Bone hierarchy for animations
---        - Bone/track linkup between mesh and animation
---        - Retargetting related
---
--- Properties
---Skeleton bone tree - each contains name and parent index*
---@field BoneTree BoneNode[]
---Reference skeleton poses in local space
---@field RefLocalPoses Transform[]
---Preview axis to consider as "forward" for the skeleton. Only used for preview purposes.
---@field PreviewForwardAxis integer
---Guid for virtual bones.
---Separate so that we don't have to dirty the original guid when only changing virtual bones
---@field VirtualBoneGuid Guid
---Array of this skeletons virtual bones. These are new bones are links between two existing bones
---and are baked into all the skeletons animations
---@field VirtualBones VirtualBone[]
---The list of compatible skeletons. This skeleton will be able to use animation data originating from skeletons within this array, such as animation sequences.
---This property is not bi-directional.
---This is an array of TSoftObjectPtr in order to prevent all skeletons to be loaded, as we only want to load things on demand.
---As this is EditAnywhere and an array of TSoftObjectPtr, checking validity of pointers is needed.
---@field CompatibleSkeletons any[]
---Should we use the per bone translational retarget mode from the source (compatible) skeleton's instead of from this skeleton? On default this is disabled.
---Enabling this would allow you to have one shared set of animations. You would configure the retarget settings on the animation skeleton.
---Then every character that plays animations from this source skeleton will use the translational retarget settings from the source skeleton, which saves you from
---having to configure the retarget modes for every bone in every character as they can be setup just once now on the animation skeleton.
---@field bUseRetargetModesFromCompatibleSkeleton boolean
---Array of named socket locations, set up in editor and used as a shortcut instead of specifying
---everything explicitly to AttachComponent in the SkeletalMeshComponent.
---@field Sockets SkeletalMeshSocket[]
---DEPRECATED - moved to CurveMetaData
---@field SmartNames SmartNameContainer
---List of blend profiles available in this skeleton
---@field BlendProfiles BlendProfile[]
---AnimNotifiers that has been created. Right now there is no delete step for this, but in the future we'll supply delete*
---@field AnimationNotifies string[]
---Attached assets component for this skeleton
---@field PreviewAttachedAssetContainer PreviewAssetAttachContainer
---Array of user data stored with the asset
---@field AssetUserData AssetUserData[]
---Array of user data stored with the asset
---@field AssetUserDataEditorOnly AssetUserData[]
local Skeleton = {}

--- Methods
---Get the specified blend profile by name
---@return BlendProfile
function Skeleton.GetBlendProfile() end

---Add Compatible Skeleton Soft
---@return nil
function Skeleton.AddCompatibleSkeletonSoft() end

---Add Compatible Skeleton
---@param SourceSkeleton Skeleton
---@return nil
function Skeleton.AddCompatibleSkeleton(SourceSkeleton) end

return Skeleton
