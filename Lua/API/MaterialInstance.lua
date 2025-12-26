---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class MaterialInstance : MaterialInterface
---Material Instance
---
--- Properties
---
---Physical material to use for this graphics material. Used for sounds, effects etc.
---@field PhysMaterial PhysicalMaterial
---Physical material map used with physical material mask, when it exists.
---@field PhysicalMaterialMap PhysicalMaterial
---Parent material.
---@field Parent MaterialInterface
---An override material which will be used instead of this one when rendering with Nanite.
---@field NaniteOverrideMaterial MaterialOverrideNanite
---Defines SpecularProfile override used by this instance. If not set, it uses the parent ones.
---@field SpecularProfileOverride SpecularProfile
---Indicates whether the instance has static permutation resources (which are required when static parameters are present)
---Read directly from the rendering thread, can only be modified with the use of a FMaterialUpdateContext.
---When true, StaticPermutationMaterialResources will always be valid and non-null.
---@field bHasStaticPermutationResource boolean
---Defines if SubsurfaceProfile from this instance is used or it uses the parent one.
---@field bOverrideSubsurfaceProfile boolean
---Defines if SpecularProfile from this instance is used or it uses the parent one.
---@field bOverrideSpecularProfile boolean
---For post process materials, use BlendableLocationOverride.
---@field bOverrideBlendableLocation boolean
---For post process materials, use BlendablePriorityOverride.
---@field bOverrideBlendablePriority boolean
---@field BlendableLocationOverride integer
---@field BlendablePriorityOverride integer
---Scalar parameters.
---@field ScalarParameterValues ScalarParameterValue[]
---Vector parameters.
---@field VectorParameterValues VectorParameterValue[]
---DoubleVector parameters.
---@field DoubleVectorParameterValues DoubleVectorParameterValue[]
---Texture parameters.
---@field TextureParameterValues TextureParameterValue[]
---Texture Collection parameters.
---@field TextureCollectionParameterValues TextureCollectionParameterValue[]
---RuntimeVirtualTexture parameters.
---@field RuntimeVirtualTextureParameterValues RuntimeVirtualTextureParameterValue[]
---Sparse Volume Texture parameters.
---@field SparseVolumeTextureParameterValues SparseVolumeTextureParameterValue[]
---Font parameters.
---@field FontParameterValues FontParameterValue[]
---User scene texture overrides.  Applies to post process domain materials only.
---@field UserSceneTextureOverrides UserSceneTextureOverride[]
---@field bOverrideBaseProperties boolean
---@field BasePropertyOverrides MaterialInstanceBasePropertyOverrides
local MaterialInstance = {}

--- Methods
return MaterialInstance
