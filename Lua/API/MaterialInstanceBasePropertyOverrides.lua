---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MaterialInstanceBasePropertyOverrides
---Properties from the base material that can be overridden in material instances.
---
--- Properties
---Enables override of the opacity mask clip value.
---@field bOverride_OpacityMaskClipValue boolean
---Enables override of the blend mode.
---@field bOverride_BlendMode boolean
---Enables override of the shading model.
---@field bOverride_ShadingModel boolean
---Enables override of the dithered LOD transition property.
---@field bOverride_DitheredLODTransition boolean
---Enables override of whether to shadow using masked opacity on translucent materials.
---@field bOverride_CastDynamicShadowAsMasked boolean
---Enables override of the two sided property.
---@field bOverride_TwoSided boolean
---Enables override of the IsThinSurface property.
---@field bOverride_bIsThinSurface boolean
---Enables override of the output velocity property.
---@field bOverride_OutputTranslucentVelocity boolean
---Enables override of the has pixel animation property.
---@field bOverride_bHasPixelAnimation boolean
---Enables override of the enable tessellation property.
---@field bOverride_bEnableTessellation boolean
---Enables override of the displacement magnitude and center property.
---@field bOverride_DisplacementScaling boolean
---Enables override of the eanble displacement fade property.
---@field bOverride_bEnableDisplacementFade boolean
---Enables override of the displacement fading range.
---@field bOverride_DisplacementFadeRange boolean
---Enables override of the max world position offset property.
---@field bOverride_MaxWorldPositionOffsetDisplacement boolean
---Enables override of the bCompatibleWithLumenCardSharing property.
---@field bOverride_CompatibleWithLumenCardSharing boolean
---Indicates that the material should be rendered without backface culling and the normal should be flipped for backfaces.
---@field TwoSided boolean
---Indicates that the material should be rendered as.
---@field bIsThinSurface boolean
---Whether the material should support a dithered LOD transition when used with the foliage system.
---@field DitheredLODTransition boolean
---Whether the material should cast shadows as masked even though it has a translucent blend mode.
---@field bCastDynamicShadowAsMasked boolean
---Whether the material should output velocity even though it has a translucent blend mode.
---@field bOutputTranslucentVelocity boolean
---Whether the opaque material has any pixel animations happening, that isn't included in the geometric velocities.
---This allows to disable renderer's heuristics that assumes animation is fully described with motion vector, such as TSR's anti-flickering heuristic.
---@field bHasPixelAnimation boolean
---Whether or not tessellation is enabled. Required for displacement to work.
---@field bEnableTessellation boolean
---Whether or not displacement fade is enabled.
---@field bEnableDisplacementFade boolean
---When true, allows to share Lumen Cards between different instances even when material uses world position or per instance data, which may change material look per instance. All materials on a component needs this flag set for sharing to work.
---@field bCompatibleWithLumenCardSharing boolean
---The blend mode
---@field BlendMode integer
---The shading model
---@field ShadingModel integer
---If BlendMode is BLEND_Masked, the surface is not rendered where OpacityMask < OpacityMaskClipValue.
---@field OpacityMaskClipValue number
---@field DisplacementScaling DisplacementScaling
---@field DisplacementFadeRange DisplacementFadeRange
---The maximum World Position Offset distance. Zero means no maximum.
---@field MaxWorldPositionOffsetDisplacement number
local MaterialInstanceBasePropertyOverrides = {}

--- Constructor
---@return MaterialInstanceBasePropertyOverrides
---@param bOverride_OpacityMaskClipValue boolean
---@param bOverride_BlendMode boolean
---@param bOverride_ShadingModel boolean
---@param bOverride_DitheredLODTransition boolean
---@param bOverride_CastDynamicShadowAsMasked boolean
---@param bOverride_TwoSided boolean
---@param bOverride_bIsThinSurface boolean
---@param bOverride_OutputTranslucentVelocity boolean
---@param bOverride_bHasPixelAnimation boolean
---@param bOverride_bEnableTessellation boolean
---@param bOverride_DisplacementScaling boolean
---@param bOverride_bEnableDisplacementFade boolean
---@param bOverride_DisplacementFadeRange boolean
---@param bOverride_MaxWorldPositionOffsetDisplacement boolean
---@param bOverride_CompatibleWithLumenCardSharing boolean
---@param TwoSided boolean
---@param bIsThinSurface boolean
---@param DitheredLODTransition boolean
---@param bCastDynamicShadowAsMasked boolean
---@param bOutputTranslucentVelocity boolean
---@param bHasPixelAnimation boolean
---@param bEnableTessellation boolean
---@param bEnableDisplacementFade boolean
---@param bCompatibleWithLumenCardSharing boolean
---@param BlendMode integer
---@param ShadingModel integer
---@param OpacityMaskClipValue number
---@param DisplacementScaling DisplacementScaling
---@param DisplacementFadeRange DisplacementFadeRange
---@param MaxWorldPositionOffsetDisplacement number
function MaterialInstanceBasePropertyOverrides.new(bOverride_OpacityMaskClipValue, bOverride_BlendMode, bOverride_ShadingModel, bOverride_DitheredLODTransition, bOverride_CastDynamicShadowAsMasked, bOverride_TwoSided, bOverride_bIsThinSurface, bOverride_OutputTranslucentVelocity, bOverride_bHasPixelAnimation, bOverride_bEnableTessellation, bOverride_DisplacementScaling, bOverride_bEnableDisplacementFade, bOverride_DisplacementFadeRange, bOverride_MaxWorldPositionOffsetDisplacement, bOverride_CompatibleWithLumenCardSharing, TwoSided, bIsThinSurface, DitheredLODTransition, bCastDynamicShadowAsMasked, bOutputTranslucentVelocity, bHasPixelAnimation, bEnableTessellation, bEnableDisplacementFade, bCompatibleWithLumenCardSharing, BlendMode, ShadingModel, OpacityMaskClipValue, DisplacementScaling, DisplacementFadeRange, MaxWorldPositionOffsetDisplacement)
    local self = {}
    self.bOverride_OpacityMaskClipValue = bOverride_OpacityMaskClipValue
    self.bOverride_BlendMode = bOverride_BlendMode
    self.bOverride_ShadingModel = bOverride_ShadingModel
    self.bOverride_DitheredLODTransition = bOverride_DitheredLODTransition
    self.bOverride_CastDynamicShadowAsMasked = bOverride_CastDynamicShadowAsMasked
    self.bOverride_TwoSided = bOverride_TwoSided
    self.bOverride_bIsThinSurface = bOverride_bIsThinSurface
    self.bOverride_OutputTranslucentVelocity = bOverride_OutputTranslucentVelocity
    self.bOverride_bHasPixelAnimation = bOverride_bHasPixelAnimation
    self.bOverride_bEnableTessellation = bOverride_bEnableTessellation
    self.bOverride_DisplacementScaling = bOverride_DisplacementScaling
    self.bOverride_bEnableDisplacementFade = bOverride_bEnableDisplacementFade
    self.bOverride_DisplacementFadeRange = bOverride_DisplacementFadeRange
    self.bOverride_MaxWorldPositionOffsetDisplacement = bOverride_MaxWorldPositionOffsetDisplacement
    self.bOverride_CompatibleWithLumenCardSharing = bOverride_CompatibleWithLumenCardSharing
    self.TwoSided = TwoSided
    self.bIsThinSurface = bIsThinSurface
    self.DitheredLODTransition = DitheredLODTransition
    self.bCastDynamicShadowAsMasked = bCastDynamicShadowAsMasked
    self.bOutputTranslucentVelocity = bOutputTranslucentVelocity
    self.bHasPixelAnimation = bHasPixelAnimation
    self.bEnableTessellation = bEnableTessellation
    self.bEnableDisplacementFade = bEnableDisplacementFade
    self.bCompatibleWithLumenCardSharing = bCompatibleWithLumenCardSharing
    self.BlendMode = BlendMode
    self.ShadingModel = ShadingModel
    self.OpacityMaskClipValue = OpacityMaskClipValue
    self.DisplacementScaling = DisplacementScaling
    self.DisplacementFadeRange = DisplacementFadeRange
    self.MaxWorldPositionOffsetDisplacement = MaxWorldPositionOffsetDisplacement
    return self
end

return MaterialInstanceBasePropertyOverrides
