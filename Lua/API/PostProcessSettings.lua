---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PostProcessSettings
---To be able to use struct PostProcessSettings. // Each property consists of a bool to enable it (by default off),
---// the variable declaration and further down the default value for it.
---// The comment should include the meaning and usable range.
---
--- Properties
---first all bOverride_... as they get grouped together into bitfields
---@field bOverride_TemperatureType boolean
---@field bOverride_WhiteTemp boolean
---@field bOverride_WhiteTint boolean
---Color Correction controls
---@field bOverride_ColorSaturation boolean
---@field bOverride_ColorContrast boolean
---@field bOverride_ColorGamma boolean
---@field bOverride_ColorGain boolean
---@field bOverride_ColorOffset boolean
---@field bOverride_ColorSaturationShadows boolean
---@field bOverride_ColorContrastShadows boolean
---@field bOverride_ColorGammaShadows boolean
---@field bOverride_ColorGainShadows boolean
---@field bOverride_ColorOffsetShadows boolean
---@field bOverride_ColorSaturationMidtones boolean
---@field bOverride_ColorContrastMidtones boolean
---@field bOverride_ColorGammaMidtones boolean
---@field bOverride_ColorGainMidtones boolean
---@field bOverride_ColorOffsetMidtones boolean
---@field bOverride_ColorSaturationHighlights boolean
---@field bOverride_ColorContrastHighlights boolean
---@field bOverride_ColorGammaHighlights boolean
---@field bOverride_ColorGainHighlights boolean
---@field bOverride_ColorOffsetHighlights boolean
---@field bOverride_ColorCorrectionShadowsMax boolean
---@field bOverride_ColorCorrectionHighlightsMin boolean
---@field bOverride_ColorCorrectionHighlightsMax boolean
---@field bOverride_BlueCorrection boolean
---@field bOverride_ExpandGamut boolean
---@field bOverride_ToneCurveAmount boolean
---@field bOverride_FilmSlope boolean
---@field bOverride_FilmToe boolean
---@field bOverride_FilmShoulder boolean
---@field bOverride_FilmBlackClip boolean
---@field bOverride_FilmWhiteClip boolean
---@field bOverride_SceneColorTint boolean
---@field bOverride_SceneFringeIntensity boolean
---@field bOverride_ChromaticAberrationStartOffset boolean
---@field bOverride_bMegaLights boolean
---@field bOverride_AmbientCubemapTint boolean
---@field bOverride_AmbientCubemapIntensity boolean
---@field bOverride_BloomMethod boolean
---@field bOverride_BloomIntensity boolean
---@field bOverride_BloomThreshold boolean
---@field bOverride_Bloom1Tint boolean
---@field bOverride_Bloom1Size boolean
---@field bOverride_Bloom2Size boolean
---@field bOverride_Bloom2Tint boolean
---@field bOverride_Bloom3Tint boolean
---@field bOverride_Bloom3Size boolean
---@field bOverride_Bloom4Tint boolean
---@field bOverride_Bloom4Size boolean
---@field bOverride_Bloom5Tint boolean
---@field bOverride_Bloom5Size boolean
---@field bOverride_Bloom6Tint boolean
---@field bOverride_Bloom6Size boolean
---@field bOverride_BloomSizeScale boolean
---@field bOverride_BloomConvolutionTexture boolean
---@field bOverride_BloomConvolutionScatterDispersion boolean
---@field bOverride_BloomConvolutionSize boolean
---@field bOverride_BloomConvolutionCenterUV boolean
---@field bOverride_BloomConvolutionPreFilter boolean
---@field bOverride_BloomConvolutionPreFilterMin boolean
---@field bOverride_BloomConvolutionPreFilterMax boolean
---@field bOverride_BloomConvolutionPreFilterMult boolean
---@field bOverride_BloomConvolutionBufferScale boolean
---@field bOverride_BloomDirtMaskIntensity boolean
---@field bOverride_BloomDirtMaskTint boolean
---@field bOverride_BloomDirtMask boolean
---@field bOverride_CameraShutterSpeed boolean
---@field bOverride_CameraISO boolean
---@field bOverride_AutoExposureMethod boolean
---@field bOverride_AutoExposureLowPercent boolean
---@field bOverride_AutoExposureHighPercent boolean
---@field bOverride_AutoExposureMinBrightness boolean
---@field bOverride_AutoExposureMaxBrightness boolean
---@field bOverride_AutoExposureCalibrationConstant boolean
---@field bOverride_AutoExposureSpeedUp boolean
---@field bOverride_AutoExposureSpeedDown boolean
---@field bOverride_AutoExposureBias boolean
---@field bOverride_AutoExposureBiasCurve boolean
---@field bOverride_AutoExposureMeterMask boolean
---@field bOverride_AutoExposureApplyPhysicalCameraExposure boolean
---@field bOverride_HistogramLogMin boolean
---@field bOverride_HistogramLogMax boolean
---@field bOverride_LocalExposureMethod boolean
---@field bOverride_LocalExposureContrastScale boolean
---@field bOverride_LocalExposureHighlightContrastScale boolean
---@field bOverride_LocalExposureShadowContrastScale boolean
---@field bOverride_LocalExposureHighlightContrastCurve boolean
---@field bOverride_LocalExposureShadowContrastCurve boolean
---@field bOverride_LocalExposureHighlightThreshold boolean
---@field bOverride_LocalExposureShadowThreshold boolean
---@field bOverride_LocalExposureDetailStrength boolean
---@field bOverride_LocalExposureBlurredLuminanceBlend boolean
---@field bOverride_LocalExposureBlurredLuminanceKernelSizePercent boolean
---@field bOverride_LocalExposureHighlightThresholdStrength boolean
---@field bOverride_LocalExposureShadowThresholdStrength boolean
---@field bOverride_LocalExposureMiddleGreyBias boolean
---@field bOverride_LensFlareIntensity boolean
---@field bOverride_LensFlareTint boolean
---@field bOverride_LensFlareTints boolean
---@field bOverride_LensFlareBokehSize boolean
---@field bOverride_LensFlareBokehShape boolean
---@field bOverride_LensFlareThreshold boolean
---@field bOverride_VignetteIntensity boolean
---@field bOverride_Sharpen boolean
---@field bOverride_GrainIntensity boolean
---@field bOverride_GrainJitter boolean
---@field bOverride_FilmGrainIntensity boolean
---@field bOverride_FilmGrainIntensityShadows boolean
---@field bOverride_FilmGrainIntensityMidtones boolean
---@field bOverride_FilmGrainIntensityHighlights boolean
---@field bOverride_FilmGrainShadowsMax boolean
---@field bOverride_FilmGrainHighlightsMin boolean
---@field bOverride_FilmGrainHighlightsMax boolean
---@field bOverride_FilmGrainTexelSize boolean
---@field bOverride_FilmGrainTexture boolean
---@field bOverride_AmbientOcclusionIntensity boolean
---@field bOverride_AmbientOcclusionStaticFraction boolean
---@field bOverride_AmbientOcclusionRadius boolean
---@field bOverride_AmbientOcclusionFadeDistance boolean
---@field bOverride_AmbientOcclusionFadeRadius boolean
---@field bOverride_AmbientOcclusionDistance boolean
---@field bOverride_AmbientOcclusionRadiusInWS boolean
---@field bOverride_AmbientOcclusionPower boolean
---@field bOverride_AmbientOcclusionBias boolean
---@field bOverride_AmbientOcclusionQuality boolean
---@field bOverride_AmbientOcclusionMipBlend boolean
---@field bOverride_AmbientOcclusionMipScale boolean
---@field bOverride_AmbientOcclusionMipThreshold boolean
---@field bOverride_AmbientOcclusionTemporalBlendWeight boolean
---@field bOverride_RayTracingAO boolean
---@field bOverride_RayTracingAOSamplesPerPixel boolean
---@field bOverride_RayTracingAOIntensity boolean
---@field bOverride_RayTracingAORadius boolean
---@field bOverride_LPVIntensity boolean
---@field bOverride_LPVDirectionalOcclusionIntensity boolean
---@field bOverride_LPVDirectionalOcclusionRadius boolean
---@field bOverride_LPVDiffuseOcclusionExponent boolean
---@field bOverride_LPVSpecularOcclusionExponent boolean
---@field bOverride_LPVDiffuseOcclusionIntensity boolean
---@field bOverride_LPVSpecularOcclusionIntensity boolean
---@field bOverride_LPVSize boolean
---@field bOverride_LPVSecondaryOcclusionIntensity boolean
---@field bOverride_LPVSecondaryBounceIntensity boolean
---@field bOverride_LPVGeometryVolumeBias boolean
---@field bOverride_LPVVplInjectionBias boolean
---@field bOverride_LPVEmissiveInjectionIntensity boolean
---@field bOverride_LPVFadeRange boolean
---@field bOverride_LPVDirectionalOcclusionFadeRange boolean
---@field bOverride_IndirectLightingColor boolean
---@field bOverride_IndirectLightingIntensity boolean
---@field bOverride_ColorGradingIntensity boolean
---@field bOverride_ColorGradingLUT boolean
---@field bOverride_DepthOfFieldFocalDistance boolean
---@field bOverride_DepthOfFieldFstop boolean
---@field bOverride_DepthOfFieldMinFstop boolean
---@field bOverride_DepthOfFieldBladeCount boolean
---@field bOverride_DepthOfFieldSensorWidth boolean
---@field bOverride_DepthOfFieldSqueezeFactor boolean
---@field bOverride_DepthOfFieldDepthBlurRadius boolean
---@field bOverride_DepthOfFieldUseHairDepth boolean
---@field bOverride_DepthOfFieldPetzvalBokeh boolean
---@field bOverride_DepthOfFieldPetzvalBokehFalloff boolean
---@field bOverride_DepthOfFieldPetzvalExclusionBoxExtents boolean
---@field bOverride_DepthOfFieldPetzvalExclusionBoxRadius boolean
---@field bOverride_DepthOfFieldAspectRatioScalar boolean
---@field bOverride_DepthOfFieldMatteBoxFlags boolean
---@field bOverride_DepthOfFieldBarrelRadius boolean
---@field bOverride_DepthOfFieldBarrelLength boolean
---@field bOverride_DepthOfFieldDepthBlurAmount boolean
---@field bOverride_DepthOfFieldFocalRegion boolean
---@field bOverride_DepthOfFieldNearTransitionRegion boolean
---@field bOverride_DepthOfFieldFarTransitionRegion boolean
---@field bOverride_DepthOfFieldScale boolean
---@field bOverride_DepthOfFieldNearBlurSize boolean
---@field bOverride_DepthOfFieldFarBlurSize boolean
---@field bOverride_MobileHQGaussian boolean
---@field bOverride_DepthOfFieldOcclusion boolean
---@field bOverride_DepthOfFieldSkyFocusDistance boolean
---@field bOverride_DepthOfFieldVignetteSize boolean
---@field bOverride_MotionBlurAmount boolean
---@field bOverride_MotionBlurMax boolean
---@field bOverride_MotionBlurTargetFPS boolean
---@field bOverride_MotionBlurPerObjectSize boolean
---@field bOverride_ScreenPercentage boolean
---@field bOverride_ReflectionMethod boolean
---@field bOverride_LumenReflectionQuality boolean
---@field bOverride_ScreenSpaceReflectionIntensity boolean
---@field bOverride_ScreenSpaceReflectionQuality boolean
---@field bOverride_ScreenSpaceReflectionMaxRoughness boolean
---@field bOverride_ScreenSpaceReflectionRoughnessScale boolean
---TODO: look useless...
---@field bOverride_UserFlags boolean
---Ray Tracing
---@field bOverride_ReflectionsType boolean
---@field bOverride_RayTracingReflectionsMaxRoughness boolean
---@field bOverride_RayTracingReflectionsMaxBounces boolean
---@field bOverride_RayTracingReflectionsSamplesPerPixel boolean
---@field bOverride_RayTracingReflectionsShadows boolean
---@field bOverride_RayTracingReflectionsTranslucency boolean
---@field bOverride_TranslucencyType boolean
---@field bOverride_RayTracingTranslucencyMaxRoughness boolean
---@field bOverride_RayTracingTranslucencyRefractionRays boolean
---@field bOverride_RayTracingTranslucencySamplesPerPixel boolean
---@field bOverride_RayTracingTranslucencyShadows boolean
---@field bOverride_RayTracingTranslucencyRefraction boolean
---@field bOverride_RayTracingTranslucencyMaxPrimaryHitEvents boolean
---@field bOverride_RayTracingTranslucencyMaxSecondaryHitEvents boolean
---@field bOverride_RayTracingTranslucencyUseRayTracedRefraction boolean
---@field bOverride_DynamicGlobalIlluminationMethod boolean
---@field bOverride_LumenSceneLightingQuality boolean
---@field bOverride_LumenSceneDetail boolean
---@field bOverride_LumenSceneViewDistance boolean
---@field bOverride_LumenSceneLightingUpdateSpeed boolean
---@field bOverride_LumenFinalGatherQuality boolean
---@field bOverride_LumenFinalGatherLightingUpdateSpeed boolean
---@field bOverride_LumenFinalGatherScreenTraces boolean
---@field bOverride_LumenMaxTraceDistance boolean
---@field bOverride_LumenDiffuseColorBoost boolean
---@field bOverride_LumenSkylightLeaking boolean
---@field bOverride_LumenSkylightLeakingTint boolean
---@field bOverride_LumenFullSkylightLeakingDistance boolean
---@field bOverride_LumenRayLightingMode boolean
---@field bOverride_LumenReflectionsScreenTraces boolean
---@field bOverride_LumenFrontLayerTranslucencyReflections boolean
---@field bOverride_LumenMaxRoughnessToTraceReflections boolean
---@field bOverride_LumenMaxReflectionBounces boolean
---@field bOverride_LumenMaxRefractionBounces boolean
---@field bOverride_LumenSurfaceCacheResolution boolean
---@field bOverride_RayTracingGI boolean
---@field bOverride_RayTracingGIMaxBounces boolean
---@field bOverride_RayTracingGISamplesPerPixel boolean
---@field bOverride_PathTracingMaxBounces boolean
---@field bOverride_PathTracingSamplesPerPixel boolean
---@field bOverride_PathTracingMaxPathIntensity boolean
---@field bOverride_PathTracingEnableEmissiveMaterials boolean
---@field bOverride_PathTracingEnableReferenceDOF boolean
---@field bOverride_PathTracingEnableReferenceAtmosphere boolean
---@field bOverride_PathTracingEnableDenoiser boolean
---@field bOverride_PathTracingIncludeEmissive boolean
---@field bOverride_PathTracingIncludeDiffuse boolean
---@field bOverride_PathTracingIncludeIndirectDiffuse boolean
---@field bOverride_PathTracingIncludeSpecular boolean
---@field bOverride_PathTracingIncludeIndirectSpecular boolean
---@field bOverride_PathTracingIncludeVolume boolean
---@field bOverride_PathTracingIncludeIndirectVolume boolean
---Enable HQ Gaussian on high end mobile platforms. (ES3_1)
---@field bMobileHQGaussian boolean
---Bloom algorithm
---@field BloomMethod integer
---Luminance computation method
---@field AutoExposureMethod integer
---@field DepthOfFieldMethod integer
---Selects the type of temperature calculation.
---White Balance uses the Temperature value to control the virtual camera's White Balance. This is the default selection.
---Color Temperature uses the Temperature value to adjust the color temperature of the scene, which is the inverse of the White Balance operation.
---@field TemperatureType integer
---Controls the color temperature or white balance in degrees Kelvin which the scene considers as white light.
---@field WhiteTemp number
---Controls the color of the scene along the magenta - green axis (orthogonal to the color temperature).  This feature is equivalent to color tint in digital cameras.
---@field WhiteTint number
---Control the intensity of the color(hue) for the entire image.Higher values will result in more vibrant colors.
---@field ColorSaturation Vector4
---Control the range of light and dark values in your scene. Lower values will reduce the difference between bright and dark areas while higher values will increase the difference between the bright and dark areas.
---@field ColorContrast Vector4
---Control the luminance curve of the scene. Raising or lowering this value will result brightening or darkening the mid-tones of the entire image.
---@field ColorGamma Vector4
---This value multiplies the colors of the image.  Raising or lowering this value will result in brightening or darkening the entire scene.
---@field ColorGain Vector4
---This value is added to the colors of the scene.  Raising or lowering this value will result in the image being more or less washed-out.
---@field ColorOffset Vector4
---Control the intensity of the colors (hue) in the shadow region of the image.  Higher values will result in more vibrant colors.
---@field ColorSaturationShadows Vector4
---Control the range of light and dark values in your scene. Lower values will reduce the difference between bright and dark areas while higher values will increase the difference between the bright and dark areas.
---@field ColorContrastShadows Vector4
---Control the luminance curve of the shadow region. Raising or lowering this value will result brightening or darkening the mid-tones of the shadow region.
---@field ColorGammaShadows Vector4
---This value multiplies the colors in the shadow region.  Raising or lowering this value will result in brightening or darkening the affected region.
---@field ColorGainShadows Vector4
---This value is added to the colors in the shadow region.  Raising or lowering this value will result in the shadows being more or less washed-out.
---@field ColorOffsetShadows Vector4
---Control the intensity of the colors (hue) in the mid-tone region of the image.  Higher values will result in more vibrant colors.
---@field ColorSaturationMidtones Vector4
---Control the range of light and dark values in the mid-tone region. Lower values will reduce the difference between bright and dark areas while higher values will increase the difference between the bright and dark areas.
---@field ColorContrastMidtones Vector4
---Control the luminance curve of the mid-tone region of the image. Raising or lowering this value will result brightening or darkening the mid-tones of the image.
---@field ColorGammaMidtones Vector4
---This value multiplies the colors in the mid-tone region of the image.  Raising or lowering this value will result in brightening or darkening the affected region.
---@field ColorGainMidtones Vector4
---This value is added to the colors in the mid-tone region of the image.  Raising or lowering this value will result in the mid-tones being more or less washed-out.
---@field ColorOffsetMidtones Vector4
---Control the intensity of the color (hue) for the highlights region of the image.  Higher values will result in more vibrant colors.
---@field ColorSaturationHighlights Vector4
---Control the range of light and dark values in the highlights region. Lower values will reduce the difference between bright and dark areas while higher values will increase the difference between the bright and dark areas.
---@field ColorContrastHighlights Vector4
---Control the luminance curve of the highlight region. Raising or lowering this value will result brightening or darkening the mid-tones of the highlight region.
---@field ColorGammaHighlights Vector4
---This value multiplies the colors in the highlight region.  Raising or lowering this value will result in brightening or darkening the affected region.
---@field ColorGainHighlights Vector4
---This value is added to the colors in the highlight region.  Raising or lowering this value will result in the highlights being more or less washed-out.
---@field ColorOffsetHighlights Vector4
---This value sets the lower threshold for what is considered to be the highlight region of the image.
---@field ColorCorrectionHighlightsMin number
---This value sets the upper threshold for what is considered to be the highlight region of the image.  This value should be larger than HighlightsMin. Default is 1.0, for backwards compatibility
---@field ColorCorrectionHighlightsMax number
---This value sets the threshold for what is considered to be the shadow region of the image.
---@field ColorCorrectionShadowsMax number
---Correct for artifacts with "electric" blues due to the ACEScg color space. Bright blue desaturates instead of going to violet.
---@field BlueCorrection number
---Expand bright saturated colors outside the sRGB gamut to fake wide gamut rendering.
---@field ExpandGamut number
---Allow effect of Tone Curve to be reduced (Set ToneCurveAmount and ExpandGamut to 0.0 to fully disable tone curve)
---@field ToneCurveAmount number
---Controls the overall steepness of the tonemapper curve.  Larger values increase scene contrast and smaller values reduce contrast.
---@field FilmSlope number
---Controls the contrast of the dark end of the tonemapper curve. Larger values increase contrast and smaller values decrease contrast.
---@field FilmToe number
---Sometimes referred to as highlight rolloff.  Controls the contrast of the bright end of the tonemapper curve. Larger values increase contrast and smaller values decrease contrast.
---@field FilmShoulder number
---Lowers the toe of the tonemapper curve by this amount. Increasing this value causes more of the scene to clip to black.  For most purposes, this property should remain 0
---@field FilmBlackClip number
---Controls the height of the tonemapper curve.  Raising this value can cause bright values to more quickly approach fully-saturated white.
---@field FilmWhiteClip number
---Scene tint color
---@field SceneColorTint LinearColor
---in percent, Scene chromatic aberration / color fringe (camera imperfection) to simulate an artifact that happens in real-world lens, mostly visible in the image corners.
---@field SceneFringeIntensity number
---A normalized distance to the center of the framebuffer where the effect takes place.
---@field ChromaticAberrationStartOffset number
---Multiplier for all bloom contributions >=0: off, 1(default), >1 brighter
---@field BloomIntensity number
---minimum brightness the bloom starts having effect
----1:all pixels affect bloom equally (physically correct, faster as a threshold pass is omitted), 0:all pixels affect bloom brights more, 1(default), >1 brighter
---@field BloomThreshold number
---Scale for all bloom sizes
---@field BloomSizeScale number
---Diameter size for the Bloom1 in percent of the screen width
---(is done in 1/2 resolution, larger values cost more performance, good for high frequency details)
--->=0: can be clamped because of shader limitations
---@field Bloom1Size number
---Diameter size for Bloom2 in percent of the screen width
---(is done in 1/4 resolution, larger values cost more performance)
--->=0: can be clamped because of shader limitations
---@field Bloom2Size number
---Diameter size for Bloom3 in percent of the screen width
---(is done in 1/8 resolution, larger values cost more performance)
--->=0: can be clamped because of shader limitations
---@field Bloom3Size number
---Diameter size for Bloom4 in percent of the screen width
---(is done in 1/16 resolution, larger values cost more performance, best for wide contributions)
--->=0: can be clamped because of shader limitations
---@field Bloom4Size number
---Diameter size for Bloom5 in percent of the screen width
---(is done in 1/32 resolution, larger values cost more performance, best for wide contributions)
--->=0: can be clamped because of shader limitations
---@field Bloom5Size number
---Diameter size for Bloom6 in percent of the screen width
---(is done in 1/64 resolution, larger values cost more performance, best for wide contributions)
--->=0: can be clamped because of shader limitations
---@field Bloom6Size number
---Bloom1 tint color
---@field Bloom1Tint LinearColor
---Bloom2 tint color
---@field Bloom2Tint LinearColor
---Bloom3 tint color
---@field Bloom3Tint LinearColor
---Bloom4 tint color
---@field Bloom4Tint LinearColor
---Bloom5 tint color
---@field Bloom5Tint LinearColor
---Bloom6 tint color
---@field Bloom6Tint LinearColor
---Intensity multiplier on the scatter dispersion energy of the kernel. 1.0 means exactly use the same energy as the kernel scatter dispersion.
---@field BloomConvolutionScatterDispersion number
---Relative size of the convolution kernel image compared to the minor axis of the viewport
---@field BloomConvolutionSize number
---Texture to replace default convolution bloom kernel
---@field BloomConvolutionTexture Texture2D
---The UV location of the center of the kernel.  Should be very close to (.5,.5)
---@field BloomConvolutionCenterUV Vector2D
---@field BloomConvolutionPreFilter Vector3f
---Boost intensity of select pixels  prior to computing bloom convolution (Min, Max, Multiplier).  Max < Min disables
---@field BloomConvolutionPreFilterMin number
---Boost intensity of select pixels  prior to computing bloom convolution (Min, Max, Multiplier).  Max < Min disables
---@field BloomConvolutionPreFilterMax number
---Boost intensity of select pixels  prior to computing bloom convolution (Min, Max, Multiplier).  Max < Min disables
---@field BloomConvolutionPreFilterMult number
---Implicit buffer region as a fraction of the screen size to insure the bloom does not wrap across the screen.  Larger sizes have perf impact.
---@field BloomConvolutionBufferScale number
---Texture that defines the dirt on the camera lens where the light of very bright objects is scattered.
---@field BloomDirtMask Texture
---BloomDirtMask intensity
---@field BloomDirtMaskIntensity number
---BloomDirtMask tint color
---@field BloomDirtMaskTint LinearColor
---Chooses the Dynamic Global Illumination method.  Not compatible with Forward Shading.
---@field DynamicGlobalIlluminationMethod integer
---Adjusts indirect lighting color. (1,1,1) is default. (0,0,0) to disable GI. The show flag 'Global Illumination' must be enabled to use this property.
---@field IndirectLightingColor LinearColor
---Scales the indirect lighting contribution. A value of 0 disables GI. Default is 1. The show flag 'Global Illumination' must be enabled to use this property.
---@field IndirectLightingIntensity number
---Controls how Lumen rays are lit when Lumen is using Hardware Ray Tracing.  By default, Lumen uses the Surface Cache for best performance, but can be set to 'Hit Lighting' for higher quality.
---@field LumenRayLightingMode ELumenRayLightingModeOverride
---Scales Lumen Scene's quality.  Larger scales cause Lumen Scene to be calculated with a higher fidelity, which can be visible in reflections, but increase GPU cost.
---@field LumenSceneLightingQuality number
---Controls the size of instances that can be represented in Lumen Scene.  Larger values will ensure small objects are represented, but increase GPU cost.
---@field LumenSceneDetail number
---Sets the maximum view distance of the scene that Lumen maintains for ray tracing against.  Larger values will increase the effective range of sky shadowing and Global Illumination, but increase GPU cost.
---@field LumenSceneViewDistance number
---Controls how much Lumen Scene is allowed to cache lighting results to improve performance.  Larger scales cause lighting changes to propagate faster, but increase GPU cost.
---@field LumenSceneLightingUpdateSpeed number
---Scales Lumen's Final Gather quality.  Larger scales reduce noise, but greatly increase GPU cost.
---@field LumenFinalGatherQuality number
---Controls how much Lumen Final Gather is allowed to cache lighting results to improve performance.  Larger scales cause lighting changes to propagate faster, but increase GPU cost and noise.
---@field LumenFinalGatherLightingUpdateSpeed number
---Whether to use screen space traces for Lumen Global Illumination. Screen space traces bypass Lumen Scene and instead sample Scene Depth and Scene Color. This improves quality, as it bypasses Lumen Scene, but causes view dependent lighting.
---@field LumenFinalGatherScreenTraces boolean
---Controls the maximum distance that Lumen should trace while solving lighting.  Values that are too small will cause lighting to leak into large caves, while values that are large will increase GPU cost.
---@field LumenMaxTraceDistance number
---Allows brightening indirect lighting by calculating material diffuse color for indirect lighting. Values above 1 (original diffuse color) aren't physically correct, but they can be useful as an art direction knob to increase the amount of bounced light in the scene. Best to keep below 2 as it also causes reflections to be brighter than the scene.
---@field LumenDiffuseColorBoost number
---Controls what fraction of the skylight intensity should be allowed to leak.  This can be useful as an art direction knob (non-physically based) to keep indoor areas from going fully black.
---@field LumenSkylightLeaking number
---Color tint for Lumen Skylight Leaking.
---@field LumenSkylightLeakingTint LinearColor
---Controls the distance from a receiving surface where skylight leaking reaches its full intensity.  Smaller values make the skylight leaking flatter, while larger values create an Ambient Occlusion effect.
---@field LumenFullSkylightLeakingDistance number
---Scale factor for Lumen Surface Cache resolution, for Scene Capture.  Smaller values save GPU memory, at a cost in quality.  Defaults to 0.5 if not overridden.
---@field LumenSurfaceCacheResolution number
---Chooses the Reflection method. Not compatible with Forward Shading.
---@field ReflectionMethod integer
---@field ReflectionsType EReflectionsType
---Scales the Reflection quality.  Larger scales reduce noise in reflections, but increase GPU cost.
---@field LumenReflectionQuality number
---Whether to use screen space traces for Lumen Reflections. Screen space traces bypass Lumen Scene and instead sample Scene Depth and Scene Color. This improves quality, as it bypasses Lumen Scene, but causes view dependent lighting.
---@field LumenReflectionsScreenTraces boolean
---Whether to use high quality mirror reflections on the front layer of translucent surfaces.  Other layers will use the lower quality Radiance Cache method that can only produce glossy reflections.  Increases GPU cost when enabled.
---@field LumenFrontLayerTranslucencyReflections boolean
---Sets the maximum roughness value for which Lumen still traces dedicated reflection rays. Higher values improve reflection quality, but greatly increase GPU cost.
---@field LumenMaxRoughnessToTraceReflections number
---Sets the maximum number of recursive reflection bounces. 1 means a single reflection ray (no secondary reflections in mirrors). Currently only supported by Hardware Ray Tracing with Hit Lighting.
---@field LumenMaxReflectionBounces integer
---The maximum count of refraction event to trace. When hit lighting is used, Translucent meshes will be traced when LumenMaxRefractionBounces > 0, making the reflection tracing more expenssive.
---@field LumenMaxRefractionBounces integer
---Enable/Fade/disable the Screen Space Reflection feature, in percent, avoid numbers between 0 and 1 fo consistency
---@field ScreenSpaceReflectionIntensity number
---0=lowest quality..100=maximum quality, only a few quality levels are implemented, no soft transition, 50 is the default for better performance.
---@field ScreenSpaceReflectionQuality number
---Until what roughness we fade the screen space reflections, 0.8 works well, smaller can run faster
---@field ScreenSpaceReflectionMaxRoughness number
---Allows forcing MegaLights on or off for this volume, regardless of the project setting for MegaLights.
---MegaLights will stochastically sample lights, which allows many shadow casting lights to be rendered efficiently, with a consistent and low GPU cost.
---When MegaLights is enabled, other direct lighting algorithms like Deferred Shading will no longer be used, and other shadowing methods like Ray Traced Shadows, Distance Field Shadows and Shadow Maps will no longer be used.
---MegaLights requires Hardware Ray Tracing and Shader Model 6.
---@field bMegaLights boolean
---AmbientCubemap tint color
---@field AmbientCubemapTint LinearColor
---To scale the Ambient cubemap brightness
--->=0: off, 1(default), >1 brighter
---@field AmbientCubemapIntensity number
---The Ambient cubemap (Affects diffuse and specular shading), blends additively which if different from all other settings here
---@field AmbientCubemap TextureCube
---The camera shutter in 1/seconds.
---@field CameraShutterSpeed number
---The camera sensor sensitivity
---@field CameraISO number
---Defines the opening of the camera lens, Aperture is 1/fstop, typical lens go down to f/1.2 (large opening), larger numbers reduce the DOF effect
---@field DepthOfFieldFstop number
---Defines the maximum opening of the camera lens to control the curvature of blades of the diaphragm. Set it to 0 to get straight blades.
---@field DepthOfFieldMinFstop number
---Defines the number of blades of the diaphragm within the lens (between 4 and 16).
---@field DepthOfFieldBladeCount integer
---Logarithmic adjustment for the exposure. Only used if a tonemapper is specified.
---0: no adjustment, -1:2x darker, -2:4x darker, 1:2x brighter, 2:4x brighter, ...
---@field AutoExposureBias number
---With the auto exposure changes, we are changing the AutoExposureBias inside the serialization code. We are
---storing that value before conversion here as a backup. Hopefully it will not be needed, and removed in the next engine revision.
---@field AutoExposureBiasBackup number
---With the auto exposure changes, we are also changing the auto exposure override value, so we are storing
---that backup as well.
---@field bOverride_AutoExposureBiasBackup boolean
---Only affects Manual exposure mode.
---@field AutoExposureApplyPhysicalCameraExposure boolean
---Exposure compensation based on the scene EV100.
---Used to calibrate the final exposure differently depending on the average scene luminance.
---0: no adjustment, -1:2x darker, -2:4x darker, 1:2x brighter, 2:4x brighter, ...
---@field AutoExposureBiasCurve CurveFloat
---Exposure metering mask. Bright spots on the mask will have high influence on auto-exposure metering
---and dark spots will have low influence.
---@field AutoExposureMeterMask Texture
---The eye adaptation will adapt to a value extracted from the luminance histogram of the scene color.
---The value is defined as having x percent below this brightness. Higher values give bright spots on the screen more priority
---but can lead to less stable results. Lower values give the medium and darker values more priority but might cause burn out of
---bright spots.
--->0, <100, good values are in the range 70 .. 80
---@field AutoExposureLowPercent number
---The eye adaptation will adapt to a value extracted from the luminance histogram of the scene color.
---The value is defined as having x percent below this brightness. Higher values give bright spots on the screen more priority
---but can lead to less stable results. Lower values give the medium and darker values more priority but might cause burn out of
---bright spots.
--->0, <100, good values are in the range 80 .. 95
---@field AutoExposureHighPercent number
---Auto-Exposure minimum adaptation. Eye Adaptation is disabled if Min = Max.
---Auto-exposure is implemented by choosing an exposure value for which the average luminance generates a pixel brightness equal to the Constant Calibration value.
---The Min/Max are expressed in pixel luminance (cd/m2) or in EV100 when using ExtendDefaultLuminanceRange (see project settings).
---@field AutoExposureMinBrightness number
---Auto-Exposure maximum adaptation. Eye Adaptation is disabled if Min = Max.
---Auto-exposure is implemented by choosing an exposure value for which the average luminance generates a pixel brightness equal to the Constant Calibration value.
---The Min/Max are expressed in pixel luminance (cd/m2) or in EV100 when using ExtendDefaultLuminanceRange (see project settings).
---@field AutoExposureMaxBrightness number
---In F-stops per second, should be >0
---@field AutoExposureSpeedUp number
---In F-stops per second, should be >0
---@field AutoExposureSpeedDown number
---Histogram Min value. Expressed in Log2(Luminance) or in EV100 when using ExtendDefaultLuminanceRange (see project settings)
---@field HistogramLogMin number
---Histogram Max value. Expressed in Log2(Luminance) or in EV100 when using ExtendDefaultLuminanceRange (see project settings)
---@field HistogramLogMax number
---Calibration constant for 18% albedo, deprecating this value.
---@field AutoExposureCalibrationConstant number
---Local Exposure algorithm
---@field LocalExposureMethod ELocalExposureMethod
---@field LocalExposureContrastScale number
---Local Exposure decomposes luminance of the frame into a base layer and a detail layer.
---Contrast of the base layer is reduced based on this value.
---Value less than 1 will enable local exposure.
---Good values are usually in the range 0.6 .. 1.0.
---@field LocalExposureHighlightContrastScale number
---Local Exposure decomposes luminance of the frame into a base layer and a detail layer.
---Contrast of the base layer is reduced based on this value.
---Value less than 1 will enable local exposure.
---Good values are usually in the range 0.6 .. 1.0.
---@field LocalExposureShadowContrastScale number
---Local Exposure Highlight Contrast based on the scene EV100.
---Used to calibrate Local Exposure differently depending on the average scene luminance.
---@field LocalExposureHighlightContrastCurve CurveFloat
---Local Exposure Shadow Contrast based on the scene EV100.
---Used to calibrate Local Exposure differently depending on the average scene luminance.
---@field LocalExposureShadowContrastCurve CurveFloat
---Threshold used to determine which regions of the screen are considered highlights.
---@field LocalExposureHighlightThreshold number
---Threshold used to determine which regions of the screen are considered shadows.
---@field LocalExposureShadowThreshold number
---Local Exposure decomposes luminance of the frame into a base layer and a detail layer.
---Value different than 1 will enable local exposure.
---This value should be set to 1 in most cases.
---@field LocalExposureDetailStrength number
---Local Exposure decomposes luminance of the frame into a base layer and a detail layer.
---Blend between bilateral filtered and blurred luminance as the base layer.
---Blurred luminance helps preserve image appearance and specular highlights, and reduce ringing.
---Good values are usually in the range 0.4 .. 0.6
---@field LocalExposureBlurredLuminanceBlend number
---Kernel size (percentage of screen) used to blur frame luminance.
---@field LocalExposureBlurredLuminanceKernelSizePercent number
---Strength of the highlight threshold.
---@field LocalExposureHighlightThresholdStrength number
---Strength of the shadow threshold.
---@field LocalExposureShadowThresholdStrength number
---Logarithmic adjustment for the local exposure middle grey.
---0: no adjustment, -1:2x darker, -2:4x darker, 1:2x brighter, 2:4x brighter, ...
---@field LocalExposureMiddleGreyBias number
---Brightness scale of the image cased lens flares (linear)
---@field LensFlareIntensity number
---Tint color for the image based lens flares.
---@field LensFlareTint LinearColor
---Size of the Lens Blur (in percent of the view width) that is done with the Bokeh texture (note: performance cost is radius*radius)
---@field LensFlareBokehSize number
---Minimum brightness the lens flare starts having effect (this should be as high as possible to avoid the performance cost of blurring content that is too dark too see)
---@field LensFlareThreshold number
---Defines the shape of the Bokeh when the image base lens flares are blurred, cannot be blended
---@field LensFlareBokehShape Texture
---RGB defines the lens flare color, A it's position. This is a temporary solution.
---@field LensFlareTints LinearColor
---0..1 0=off/no vignette .. 1=strong vignette
---@field VignetteIntensity number
---Controls the strength of image sharpening applied during tonemapping.
---@field Sharpen number
---@field GrainJitter number
---@field GrainIntensity number
---0..1 Film grain intensity to apply. LinearSceneColor *= lerp(1.0, DecodedFilmGrainTexture, FilmGrainIntensity)
---@field FilmGrainIntensity number
---Control over the grain intensity in the regions of the image considered shadow areas.
---@field FilmGrainIntensityShadows number
---Control over the grain intensity in the mid-tone region of the image.
---@field FilmGrainIntensityMidtones number
---Control over the grain intensity in the regions of the image considered highlight areas.
---@field FilmGrainIntensityHighlights number
---Sets the upper bound used for Film Grain Shadow Intensity.
---@field FilmGrainShadowsMax number
---Sets the lower bound used for Film Grain Highlight Intensity.
---@field FilmGrainHighlightsMin number
---Sets the upper bound used for Film Grain Highlight Intensity. This value should be larger than HighlightsMin.. Default is 1.0, for backwards compatibility
---@field FilmGrainHighlightsMax number
---Controls the size of the film grain. Size of texel of FilmGrainTexture on screen.
---@field FilmGrainTexelSize number
---Defines film grain texture to use.
---@field FilmGrainTexture Texture2D
---0..1 0=off/no ambient occlusion .. 1=strong ambient occlusion, defines how much it affects the non direct lighting after base pass
---@field AmbientOcclusionIntensity number
---0..1 0=no effect on static lighting .. 1=AO affects the stat lighting, 0 is free meaning no extra rendering pass
---@field AmbientOcclusionStaticFraction number
--->0, in unreal units, bigger values means even distant surfaces affect the ambient occlusion
---@field AmbientOcclusionRadius number
---true: AO radius is in world space units, false: AO radius is locked the view space in 400 units
---@field AmbientOcclusionRadiusInWS boolean
--->0, in unreal units, at what distance the AO effect disppears in the distance (avoding artifacts and AO effects on huge object)
---@field AmbientOcclusionFadeDistance number
--->0, in unreal units, how many units before AmbientOcclusionFadeOutDistance it starts fading out
---@field AmbientOcclusionFadeRadius number
--->0, in unreal units, how wide the ambient occlusion effect should affect the geometry (in depth), will be removed - only used for non normal method which is not exposed
---@field AmbientOcclusionDistance number
--->0, in unreal units, bigger values means even distant surfaces affect the ambient occlusion
---@field AmbientOcclusionPower number
--->0, in unreal units, default (3.0) works well for flat surfaces but can reduce details
---@field AmbientOcclusionBias number
---0=lowest quality..100=maximum quality, only a few quality levels are implemented, no soft transition
---@field AmbientOcclusionQuality number
---Affects the blend over the multiple mips (lower resolution versions) , 0:fully use full resolution, 1::fully use low resolution, around 0.6 seems to be a good value
---@field AmbientOcclusionMipBlend number
---Affects the radius AO radius scale over the multiple mips (lower resolution versions)
---@field AmbientOcclusionMipScale number
---to tweak the bilateral upsampling when using multiple mips (lower resolution versions)
---@field AmbientOcclusionMipThreshold number
---How much to blend the current frame with previous frames when using GTAO with temporal accumulation
---@field AmbientOcclusionTemporalBlendWeight number
---Enables ray tracing ambient occlusion.
---@field RayTracingAO boolean
---Sets the samples per pixel for ray tracing ambient occlusion.
---@field RayTracingAOSamplesPerPixel integer
---Scalar factor on the ray-tracing ambient occlusion score.
---@field RayTracingAOIntensity number
---Defines the world-space search radius for occlusion rays.
---@field RayTracingAORadius number
---Color grading lookup table intensity. 0 = no intensity, 1=full intensity
---@field ColorGradingIntensity number
---Look up table texture to use or none of not used
---@field ColorGradingLUT Texture
---Width of the camera sensor to assume, in mm.
---@field DepthOfFieldSensorWidth number
---This is the squeeze factor for the DOF, which emulates the properties of anamorphic lenses.
---@field DepthOfFieldSqueezeFactor number
---Distance in which the Depth of Field effect should be sharp, in unreal units (cm)
---@field DepthOfFieldFocalDistance number
---CircleDOF only: Depth blur km for 50%
---@field DepthOfFieldDepthBlurAmount number
---CircleDOF only: Depth blur radius in pixels at 1920x
---@field DepthOfFieldDepthBlurRadius number
---For depth of field to use the hair depth for computing circle of confusion size. Otherwise use an interpolated distance between the hair depth and the scene depth based on the hair coverage (default).
---@field DepthOfFieldUseHairDepth boolean
---Simulate stretching in blur and bokeh. Positive values for sagittal (swirly bokeh), negative values for tangential.
---@field DepthOfFieldPetzvalBokeh number
---How quickly does the Petzval bokeh effect increase towards the edge of the image
---@field DepthOfFieldPetzvalBokehFalloff number
---Box, centered on screen, around which the Petzval effect is applied.
---@field DepthOfFieldPetzvalExclusionBoxExtents Vector2f
---Corner radius
---@field DepthOfFieldPetzvalExclusionBoxRadius number
---Amount to scale the output viewport's aspect ratio by when computing depth of field properties.
---@field DepthOfFieldAspectRatioScalar number
---The lens barrel creates vignetting and occludes bokeh, i.e. cat's eye bokeh
---@field DepthOfFieldBarrelRadius number
---The lens barrel creates vignetting and occludes bokeh, i.e. cat's eye bokeh
---@field DepthOfFieldBarrelLength number
---Panels around the front of the lens barrel that occlude bokeh
---@field DepthOfFieldMatteBoxFlags MatteBoxFlag
---Artificial region where all content is in focus, starting after DepthOfFieldFocalDistance, in unreal units  (cm)
---@field DepthOfFieldFocalRegion number
---To define the width of the transition region next to the focal region on the near side (cm)
---@field DepthOfFieldNearTransitionRegion number
---To define the width of the transition region next to the focal region on the near side (cm)
---@field DepthOfFieldFarTransitionRegion number
---SM5: BokehDOF only: To amplify the depth of field effect (like aperture)  0=off
---          ES3_1: Used to blend DoF. 0=off
---@field DepthOfFieldScale number
---Gaussian only: Maximum size of the Depth of Field blur (in percent of the view width) (note: performance cost scales with size)
---@field DepthOfFieldNearBlurSize number
---Gaussian only: Maximum size of the Depth of Field blur (in percent of the view width) (note: performance cost scales with size)
---@field DepthOfFieldFarBlurSize number
---Occlusion tweak factor 1 (0.18 to get natural occlusion, 0.4 to solve layer color leaking issues)
---@field DepthOfFieldOcclusion number
---Artificial distance to allow the skybox to be in focus (e.g. 200000), <=0 to switch the feature off, only for GaussianDOF, can cost performance
---@field DepthOfFieldSkyFocusDistance number
---Artificial circular mask to (near) blur content outside the radius, only for GaussianDOF, diameter in percent of screen width, costs performance if the mask is used, keep Feather can Radius on default to keep it off
---@field DepthOfFieldVignetteSize number
---Strength of motion blur, 0:off
---@field MotionBlurAmount number
---max distortion caused by motion blur, in percent of the screen width, 0:off
---@field MotionBlurMax number
---Defines the target FPS for motion blur. Makes motion blur independent of actual frame rate and relative
---to the specified target FPS instead. Higher target FPS results in shorter frames, which means shorter
---shutter times and less motion blur. Lower FPS means more motion blur. A value of zero makes the motion
---blur dependent on the actual frame rate.
---@field MotionBlurTargetFPS integer
---The minimum projected screen radius for a primitive to be drawn in the velocity pass, percentage of screen width. smaller numbers cause more draw calls, default: 4%
---@field MotionBlurPerObjectSize number
---@field LPVIntensity number
---@field LPVVplInjectionBias number
---@field LPVSize number
---@field LPVSecondaryOcclusionIntensity number
---@field LPVSecondaryBounceIntensity number
---@field LPVGeometryVolumeBias number
---@field LPVEmissiveInjectionIntensity number
---@field LPVDirectionalOcclusionIntensity number
---@field LPVDirectionalOcclusionRadius number
---@field LPVDiffuseOcclusionExponent number
---@field LPVSpecularOcclusionExponent number
---@field LPVDiffuseOcclusionIntensity number
---@field LPVSpecularOcclusionIntensity number
---Sets the translucency type
---@field TranslucencyType ETranslucencyType
---Sets the maximum roughness until which ray tracing translucency will be visible (lower value is faster). Translucency contribution is smoothly faded when close to roughness threshold. This parameter behaves similarly to ScreenSpaceReflectionMaxRoughness.
---@field RayTracingTranslucencyMaxRoughness number
---Sets the maximum number of ray tracing refraction rays.
---@field RayTracingTranslucencyRefractionRays integer
---Sets the samples per pixel for ray traced translucency.
---@field RayTracingTranslucencySamplesPerPixel integer
---Maximum number of hit events allowed on primary ray paths
---@field RayTracingTranslucencyMaxPrimaryHitEvents integer
---Maximum number of hit events allowed on secondary ray paths
---@field RayTracingTranslucencyMaxSecondaryHitEvents integer
---Sets the translucency shadows type.
---@field RayTracingTranslucencyShadows EReflectedAndRefractedRayTracedShadows
---Sets whether refraction should be enabled or not (if not rays will not scatter and only travel in the same direction as before the intersection event).
---@field RayTracingTranslucencyRefraction boolean
---Whether to use ray traced refraction which currently doesn't work well with rough refraction or simulate it using a screen space effect
---@field RayTracingTranslucencyUseRayTracedRefraction boolean
---Sets the path tracing maximum bounces
---@field PathTracingMaxBounces integer
---Sets the samples per pixel for the path tracer.
---@field PathTracingSamplesPerPixel integer
---Sets the maximum intensity of indirect samples to reduce fireflies. Lowering this value reduces noise at the expense of accuracy. Increasing it is more accurate but may lead to more noise.
---@field PathTracingMaxPathIntensity number
---Should emissive materials contribute to scene lighting?
---@field PathTracingEnableEmissiveMaterials boolean
---Enables a reference quality depth-of-field which replaces the post-process effect.
---@field PathTracingEnableReferenceDOF boolean
---Enables path tracing in the atmosphere instead of baking the sky atmosphere contribution into a skylight. Any skylight present in the scene will be automatically ignored when this is enabled.
---@field PathTracingEnableReferenceAtmosphere boolean
---Run the currently loaded denoiser plugin on the last sample to remove noise from the output. Has no effect if a plug-in is not loaded.
---@field PathTracingEnableDenoiser boolean
---Should the render include directly visible emissive elements?
---@field PathTracingIncludeEmissive boolean
---Should the render include diffuse lighting contributions?
---@field PathTracingIncludeDiffuse boolean
---Should the render include indirect diffuse lighting contributions?
---@field PathTracingIncludeIndirectDiffuse boolean
---Should the render include specular lighting contributions?
---@field PathTracingIncludeSpecular boolean
---Should the render include indirect specular lighting contributions?
---@field PathTracingIncludeIndirectSpecular boolean
---Should the render include volume lighting contributions?
---@field PathTracingIncludeVolume boolean
---Should the render include volume lighting contributions?
---@field PathTracingIncludeIndirectVolume boolean
---@field LPVFadeRange number
---@field LPVDirectionalOcclusionFadeRange number
---@field ScreenPercentage number
---Per-view user flags accessible in materials via TestPostVolumeUserFlag node, allowing per-view overrides of material behavior.
---@field UserFlags integer
---Allows custom post process materials to be defined, using a MaterialInstance with the same Material as its parent to allow blending.
---For materials this needs to be the "PostProcess" domain type. This can be used for any UObject object implementing the IBlendableInterface (e.g. could be used to fade weather settings).
---@field WeightedBlendables WeightedBlendables
---For editor material preview windows, we need to support visualizing the output of a blendable that writes to a UserSceneTexture.  Stores
---a pointer to a blendable that's being previewed, forcing its output to write to SceneColor instead of the UserSceneTexture, making it visible.
---@field PreviewBlendable Object
---for backwards compatibility
---@field Blendables Object[]
local PostProcessSettings = {}

--- Constructor
---@return PostProcessSettings
---@param bOverride_TemperatureType boolean
---@param bOverride_WhiteTemp boolean
---@param bOverride_WhiteTint boolean
---@param bOverride_ColorSaturation boolean
---@param bOverride_ColorContrast boolean
---@param bOverride_ColorGamma boolean
---@param bOverride_ColorGain boolean
---@param bOverride_ColorOffset boolean
---@param bOverride_ColorSaturationShadows boolean
---@param bOverride_ColorContrastShadows boolean
---@param bOverride_ColorGammaShadows boolean
---@param bOverride_ColorGainShadows boolean
---@param bOverride_ColorOffsetShadows boolean
---@param bOverride_ColorSaturationMidtones boolean
---@param bOverride_ColorContrastMidtones boolean
---@param bOverride_ColorGammaMidtones boolean
---@param bOverride_ColorGainMidtones boolean
---@param bOverride_ColorOffsetMidtones boolean
---@param bOverride_ColorSaturationHighlights boolean
---@param bOverride_ColorContrastHighlights boolean
---@param bOverride_ColorGammaHighlights boolean
---@param bOverride_ColorGainHighlights boolean
---@param bOverride_ColorOffsetHighlights boolean
---@param bOverride_ColorCorrectionShadowsMax boolean
---@param bOverride_ColorCorrectionHighlightsMin boolean
---@param bOverride_ColorCorrectionHighlightsMax boolean
---@param bOverride_BlueCorrection boolean
---@param bOverride_ExpandGamut boolean
---@param bOverride_ToneCurveAmount boolean
---@param bOverride_FilmSlope boolean
---@param bOverride_FilmToe boolean
---@param bOverride_FilmShoulder boolean
---@param bOverride_FilmBlackClip boolean
---@param bOverride_FilmWhiteClip boolean
---@param bOverride_SceneColorTint boolean
---@param bOverride_SceneFringeIntensity boolean
---@param bOverride_ChromaticAberrationStartOffset boolean
---@param bOverride_bMegaLights boolean
---@param bOverride_AmbientCubemapTint boolean
---@param bOverride_AmbientCubemapIntensity boolean
---@param bOverride_BloomMethod boolean
---@param bOverride_BloomIntensity boolean
---@param bOverride_BloomThreshold boolean
---@param bOverride_Bloom1Tint boolean
---@param bOverride_Bloom1Size boolean
---@param bOverride_Bloom2Size boolean
---@param bOverride_Bloom2Tint boolean
---@param bOverride_Bloom3Tint boolean
---@param bOverride_Bloom3Size boolean
---@param bOverride_Bloom4Tint boolean
---@param bOverride_Bloom4Size boolean
---@param bOverride_Bloom5Tint boolean
---@param bOverride_Bloom5Size boolean
---@param bOverride_Bloom6Tint boolean
---@param bOverride_Bloom6Size boolean
---@param bOverride_BloomSizeScale boolean
---@param bOverride_BloomConvolutionTexture boolean
---@param bOverride_BloomConvolutionScatterDispersion boolean
---@param bOverride_BloomConvolutionSize boolean
---@param bOverride_BloomConvolutionCenterUV boolean
---@param bOverride_BloomConvolutionPreFilter boolean
---@param bOverride_BloomConvolutionPreFilterMin boolean
---@param bOverride_BloomConvolutionPreFilterMax boolean
---@param bOverride_BloomConvolutionPreFilterMult boolean
---@param bOverride_BloomConvolutionBufferScale boolean
---@param bOverride_BloomDirtMaskIntensity boolean
---@param bOverride_BloomDirtMaskTint boolean
---@param bOverride_BloomDirtMask boolean
---@param bOverride_CameraShutterSpeed boolean
---@param bOverride_CameraISO boolean
---@param bOverride_AutoExposureMethod boolean
---@param bOverride_AutoExposureLowPercent boolean
---@param bOverride_AutoExposureHighPercent boolean
---@param bOverride_AutoExposureMinBrightness boolean
---@param bOverride_AutoExposureMaxBrightness boolean
---@param bOverride_AutoExposureCalibrationConstant boolean
---@param bOverride_AutoExposureSpeedUp boolean
---@param bOverride_AutoExposureSpeedDown boolean
---@param bOverride_AutoExposureBias boolean
---@param bOverride_AutoExposureBiasCurve boolean
---@param bOverride_AutoExposureMeterMask boolean
---@param bOverride_AutoExposureApplyPhysicalCameraExposure boolean
---@param bOverride_HistogramLogMin boolean
---@param bOverride_HistogramLogMax boolean
---@param bOverride_LocalExposureMethod boolean
---@param bOverride_LocalExposureContrastScale boolean
---@param bOverride_LocalExposureHighlightContrastScale boolean
---@param bOverride_LocalExposureShadowContrastScale boolean
---@param bOverride_LocalExposureHighlightContrastCurve boolean
---@param bOverride_LocalExposureShadowContrastCurve boolean
---@param bOverride_LocalExposureHighlightThreshold boolean
---@param bOverride_LocalExposureShadowThreshold boolean
---@param bOverride_LocalExposureDetailStrength boolean
---@param bOverride_LocalExposureBlurredLuminanceBlend boolean
---@param bOverride_LocalExposureBlurredLuminanceKernelSizePercent boolean
---@param bOverride_LocalExposureHighlightThresholdStrength boolean
---@param bOverride_LocalExposureShadowThresholdStrength boolean
---@param bOverride_LocalExposureMiddleGreyBias boolean
---@param bOverride_LensFlareIntensity boolean
---@param bOverride_LensFlareTint boolean
---@param bOverride_LensFlareTints boolean
---@param bOverride_LensFlareBokehSize boolean
---@param bOverride_LensFlareBokehShape boolean
---@param bOverride_LensFlareThreshold boolean
---@param bOverride_VignetteIntensity boolean
---@param bOverride_Sharpen boolean
---@param bOverride_GrainIntensity boolean
---@param bOverride_GrainJitter boolean
---@param bOverride_FilmGrainIntensity boolean
---@param bOverride_FilmGrainIntensityShadows boolean
---@param bOverride_FilmGrainIntensityMidtones boolean
---@param bOverride_FilmGrainIntensityHighlights boolean
---@param bOverride_FilmGrainShadowsMax boolean
---@param bOverride_FilmGrainHighlightsMin boolean
---@param bOverride_FilmGrainHighlightsMax boolean
---@param bOverride_FilmGrainTexelSize boolean
---@param bOverride_FilmGrainTexture boolean
---@param bOverride_AmbientOcclusionIntensity boolean
---@param bOverride_AmbientOcclusionStaticFraction boolean
---@param bOverride_AmbientOcclusionRadius boolean
---@param bOverride_AmbientOcclusionFadeDistance boolean
---@param bOverride_AmbientOcclusionFadeRadius boolean
---@param bOverride_AmbientOcclusionDistance boolean
---@param bOverride_AmbientOcclusionRadiusInWS boolean
---@param bOverride_AmbientOcclusionPower boolean
---@param bOverride_AmbientOcclusionBias boolean
---@param bOverride_AmbientOcclusionQuality boolean
---@param bOverride_AmbientOcclusionMipBlend boolean
---@param bOverride_AmbientOcclusionMipScale boolean
---@param bOverride_AmbientOcclusionMipThreshold boolean
---@param bOverride_AmbientOcclusionTemporalBlendWeight boolean
---@param bOverride_RayTracingAO boolean
---@param bOverride_RayTracingAOSamplesPerPixel boolean
---@param bOverride_RayTracingAOIntensity boolean
---@param bOverride_RayTracingAORadius boolean
---@param bOverride_LPVIntensity boolean
---@param bOverride_LPVDirectionalOcclusionIntensity boolean
---@param bOverride_LPVDirectionalOcclusionRadius boolean
---@param bOverride_LPVDiffuseOcclusionExponent boolean
---@param bOverride_LPVSpecularOcclusionExponent boolean
---@param bOverride_LPVDiffuseOcclusionIntensity boolean
---@param bOverride_LPVSpecularOcclusionIntensity boolean
---@param bOverride_LPVSize boolean
---@param bOverride_LPVSecondaryOcclusionIntensity boolean
---@param bOverride_LPVSecondaryBounceIntensity boolean
---@param bOverride_LPVGeometryVolumeBias boolean
---@param bOverride_LPVVplInjectionBias boolean
---@param bOverride_LPVEmissiveInjectionIntensity boolean
---@param bOverride_LPVFadeRange boolean
---@param bOverride_LPVDirectionalOcclusionFadeRange boolean
---@param bOverride_IndirectLightingColor boolean
---@param bOverride_IndirectLightingIntensity boolean
---@param bOverride_ColorGradingIntensity boolean
---@param bOverride_ColorGradingLUT boolean
---@param bOverride_DepthOfFieldFocalDistance boolean
---@param bOverride_DepthOfFieldFstop boolean
---@param bOverride_DepthOfFieldMinFstop boolean
---@param bOverride_DepthOfFieldBladeCount boolean
---@param bOverride_DepthOfFieldSensorWidth boolean
---@param bOverride_DepthOfFieldSqueezeFactor boolean
---@param bOverride_DepthOfFieldDepthBlurRadius boolean
---@param bOverride_DepthOfFieldUseHairDepth boolean
---@param bOverride_DepthOfFieldPetzvalBokeh boolean
---@param bOverride_DepthOfFieldPetzvalBokehFalloff boolean
---@param bOverride_DepthOfFieldPetzvalExclusionBoxExtents boolean
---@param bOverride_DepthOfFieldPetzvalExclusionBoxRadius boolean
---@param bOverride_DepthOfFieldAspectRatioScalar boolean
---@param bOverride_DepthOfFieldMatteBoxFlags boolean
---@param bOverride_DepthOfFieldBarrelRadius boolean
---@param bOverride_DepthOfFieldBarrelLength boolean
---@param bOverride_DepthOfFieldDepthBlurAmount boolean
---@param bOverride_DepthOfFieldFocalRegion boolean
---@param bOverride_DepthOfFieldNearTransitionRegion boolean
---@param bOverride_DepthOfFieldFarTransitionRegion boolean
---@param bOverride_DepthOfFieldScale boolean
---@param bOverride_DepthOfFieldNearBlurSize boolean
---@param bOverride_DepthOfFieldFarBlurSize boolean
---@param bOverride_MobileHQGaussian boolean
---@param bOverride_DepthOfFieldOcclusion boolean
---@param bOverride_DepthOfFieldSkyFocusDistance boolean
---@param bOverride_DepthOfFieldVignetteSize boolean
---@param bOverride_MotionBlurAmount boolean
---@param bOverride_MotionBlurMax boolean
---@param bOverride_MotionBlurTargetFPS boolean
---@param bOverride_MotionBlurPerObjectSize boolean
---@param bOverride_ScreenPercentage boolean
---@param bOverride_ReflectionMethod boolean
---@param bOverride_LumenReflectionQuality boolean
---@param bOverride_ScreenSpaceReflectionIntensity boolean
---@param bOverride_ScreenSpaceReflectionQuality boolean
---@param bOverride_ScreenSpaceReflectionMaxRoughness boolean
---@param bOverride_ScreenSpaceReflectionRoughnessScale boolean
---@param bOverride_UserFlags boolean
---@param bOverride_ReflectionsType boolean
---@param bOverride_RayTracingReflectionsMaxRoughness boolean
---@param bOverride_RayTracingReflectionsMaxBounces boolean
---@param bOverride_RayTracingReflectionsSamplesPerPixel boolean
---@param bOverride_RayTracingReflectionsShadows boolean
---@param bOverride_RayTracingReflectionsTranslucency boolean
---@param bOverride_TranslucencyType boolean
---@param bOverride_RayTracingTranslucencyMaxRoughness boolean
---@param bOverride_RayTracingTranslucencyRefractionRays boolean
---@param bOverride_RayTracingTranslucencySamplesPerPixel boolean
---@param bOverride_RayTracingTranslucencyShadows boolean
---@param bOverride_RayTracingTranslucencyRefraction boolean
---@param bOverride_RayTracingTranslucencyMaxPrimaryHitEvents boolean
---@param bOverride_RayTracingTranslucencyMaxSecondaryHitEvents boolean
---@param bOverride_RayTracingTranslucencyUseRayTracedRefraction boolean
---@param bOverride_DynamicGlobalIlluminationMethod boolean
---@param bOverride_LumenSceneLightingQuality boolean
---@param bOverride_LumenSceneDetail boolean
---@param bOverride_LumenSceneViewDistance boolean
---@param bOverride_LumenSceneLightingUpdateSpeed boolean
---@param bOverride_LumenFinalGatherQuality boolean
---@param bOverride_LumenFinalGatherLightingUpdateSpeed boolean
---@param bOverride_LumenFinalGatherScreenTraces boolean
---@param bOverride_LumenMaxTraceDistance boolean
---@param bOverride_LumenDiffuseColorBoost boolean
---@param bOverride_LumenSkylightLeaking boolean
---@param bOverride_LumenSkylightLeakingTint boolean
---@param bOverride_LumenFullSkylightLeakingDistance boolean
---@param bOverride_LumenRayLightingMode boolean
---@param bOverride_LumenReflectionsScreenTraces boolean
---@param bOverride_LumenFrontLayerTranslucencyReflections boolean
---@param bOverride_LumenMaxRoughnessToTraceReflections boolean
---@param bOverride_LumenMaxReflectionBounces boolean
---@param bOverride_LumenMaxRefractionBounces boolean
---@param bOverride_LumenSurfaceCacheResolution boolean
---@param bOverride_RayTracingGI boolean
---@param bOverride_RayTracingGIMaxBounces boolean
---@param bOverride_RayTracingGISamplesPerPixel boolean
---@param bOverride_PathTracingMaxBounces boolean
---@param bOverride_PathTracingSamplesPerPixel boolean
---@param bOverride_PathTracingMaxPathIntensity boolean
---@param bOverride_PathTracingEnableEmissiveMaterials boolean
---@param bOverride_PathTracingEnableReferenceDOF boolean
---@param bOverride_PathTracingEnableReferenceAtmosphere boolean
---@param bOverride_PathTracingEnableDenoiser boolean
---@param bOverride_PathTracingIncludeEmissive boolean
---@param bOverride_PathTracingIncludeDiffuse boolean
---@param bOverride_PathTracingIncludeIndirectDiffuse boolean
---@param bOverride_PathTracingIncludeSpecular boolean
---@param bOverride_PathTracingIncludeIndirectSpecular boolean
---@param bOverride_PathTracingIncludeVolume boolean
---@param bOverride_PathTracingIncludeIndirectVolume boolean
---@param bMobileHQGaussian boolean
---@param BloomMethod integer
---@param AutoExposureMethod integer
---@param DepthOfFieldMethod integer
---@param TemperatureType integer
---@param WhiteTemp number
---@param WhiteTint number
---@param ColorSaturation Vector4
---@param ColorContrast Vector4
---@param ColorGamma Vector4
---@param ColorGain Vector4
---@param ColorOffset Vector4
---@param ColorSaturationShadows Vector4
---@param ColorContrastShadows Vector4
---@param ColorGammaShadows Vector4
---@param ColorGainShadows Vector4
---@param ColorOffsetShadows Vector4
---@param ColorSaturationMidtones Vector4
---@param ColorContrastMidtones Vector4
---@param ColorGammaMidtones Vector4
---@param ColorGainMidtones Vector4
---@param ColorOffsetMidtones Vector4
---@param ColorSaturationHighlights Vector4
---@param ColorContrastHighlights Vector4
---@param ColorGammaHighlights Vector4
---@param ColorGainHighlights Vector4
---@param ColorOffsetHighlights Vector4
---@param ColorCorrectionHighlightsMin number
---@param ColorCorrectionHighlightsMax number
---@param ColorCorrectionShadowsMax number
---@param BlueCorrection number
---@param ExpandGamut number
---@param ToneCurveAmount number
---@param FilmSlope number
---@param FilmToe number
---@param FilmShoulder number
---@param FilmBlackClip number
---@param FilmWhiteClip number
---@param SceneColorTint LinearColor
---@param SceneFringeIntensity number
---@param ChromaticAberrationStartOffset number
---@param BloomIntensity number
---@param BloomThreshold number
---@param BloomSizeScale number
---@param Bloom1Size number
---@param Bloom2Size number
---@param Bloom3Size number
---@param Bloom4Size number
---@param Bloom5Size number
---@param Bloom6Size number
---@param Bloom1Tint LinearColor
---@param Bloom2Tint LinearColor
---@param Bloom3Tint LinearColor
---@param Bloom4Tint LinearColor
---@param Bloom5Tint LinearColor
---@param Bloom6Tint LinearColor
---@param BloomConvolutionScatterDispersion number
---@param BloomConvolutionSize number
---@param BloomConvolutionTexture Texture2D
---@param BloomConvolutionCenterUV Vector2D
---@param BloomConvolutionPreFilter Vector3f
---@param BloomConvolutionPreFilterMin number
---@param BloomConvolutionPreFilterMax number
---@param BloomConvolutionPreFilterMult number
---@param BloomConvolutionBufferScale number
---@param BloomDirtMask Texture
---@param BloomDirtMaskIntensity number
---@param BloomDirtMaskTint LinearColor
---@param DynamicGlobalIlluminationMethod integer
---@param IndirectLightingColor LinearColor
---@param IndirectLightingIntensity number
---@param LumenRayLightingMode ELumenRayLightingModeOverride
---@param LumenSceneLightingQuality number
---@param LumenSceneDetail number
---@param LumenSceneViewDistance number
---@param LumenSceneLightingUpdateSpeed number
---@param LumenFinalGatherQuality number
---@param LumenFinalGatherLightingUpdateSpeed number
---@param LumenFinalGatherScreenTraces boolean
---@param LumenMaxTraceDistance number
---@param LumenDiffuseColorBoost number
---@param LumenSkylightLeaking number
---@param LumenSkylightLeakingTint LinearColor
---@param LumenFullSkylightLeakingDistance number
---@param LumenSurfaceCacheResolution number
---@param ReflectionMethod integer
---@param ReflectionsType EReflectionsType
---@param LumenReflectionQuality number
---@param LumenReflectionsScreenTraces boolean
---@param LumenFrontLayerTranslucencyReflections boolean
---@param LumenMaxRoughnessToTraceReflections number
---@param LumenMaxReflectionBounces integer
---@param LumenMaxRefractionBounces integer
---@param ScreenSpaceReflectionIntensity number
---@param ScreenSpaceReflectionQuality number
---@param ScreenSpaceReflectionMaxRoughness number
---@param bMegaLights boolean
---@param AmbientCubemapTint LinearColor
---@param AmbientCubemapIntensity number
---@param AmbientCubemap TextureCube
---@param CameraShutterSpeed number
---@param CameraISO number
---@param DepthOfFieldFstop number
---@param DepthOfFieldMinFstop number
---@param DepthOfFieldBladeCount integer
---@param AutoExposureBias number
---@param AutoExposureBiasBackup number
---@param bOverride_AutoExposureBiasBackup boolean
---@param AutoExposureApplyPhysicalCameraExposure boolean
---@param AutoExposureBiasCurve CurveFloat
---@param AutoExposureMeterMask Texture
---@param AutoExposureLowPercent number
---@param AutoExposureHighPercent number
---@param AutoExposureMinBrightness number
---@param AutoExposureMaxBrightness number
---@param AutoExposureSpeedUp number
---@param AutoExposureSpeedDown number
---@param HistogramLogMin number
---@param HistogramLogMax number
---@param AutoExposureCalibrationConstant number
---@param LocalExposureMethod ELocalExposureMethod
---@param LocalExposureContrastScale number
---@param LocalExposureHighlightContrastScale number
---@param LocalExposureShadowContrastScale number
---@param LocalExposureHighlightContrastCurve CurveFloat
---@param LocalExposureShadowContrastCurve CurveFloat
---@param LocalExposureHighlightThreshold number
---@param LocalExposureShadowThreshold number
---@param LocalExposureDetailStrength number
---@param LocalExposureBlurredLuminanceBlend number
---@param LocalExposureBlurredLuminanceKernelSizePercent number
---@param LocalExposureHighlightThresholdStrength number
---@param LocalExposureShadowThresholdStrength number
---@param LocalExposureMiddleGreyBias number
---@param LensFlareIntensity number
---@param LensFlareTint LinearColor
---@param LensFlareBokehSize number
---@param LensFlareThreshold number
---@param LensFlareBokehShape Texture
---@param LensFlareTints LinearColor
---@param VignetteIntensity number
---@param Sharpen number
---@param GrainJitter number
---@param GrainIntensity number
---@param FilmGrainIntensity number
---@param FilmGrainIntensityShadows number
---@param FilmGrainIntensityMidtones number
---@param FilmGrainIntensityHighlights number
---@param FilmGrainShadowsMax number
---@param FilmGrainHighlightsMin number
---@param FilmGrainHighlightsMax number
---@param FilmGrainTexelSize number
---@param FilmGrainTexture Texture2D
---@param AmbientOcclusionIntensity number
---@param AmbientOcclusionStaticFraction number
---@param AmbientOcclusionRadius number
---@param AmbientOcclusionRadiusInWS boolean
---@param AmbientOcclusionFadeDistance number
---@param AmbientOcclusionFadeRadius number
---@param AmbientOcclusionDistance number
---@param AmbientOcclusionPower number
---@param AmbientOcclusionBias number
---@param AmbientOcclusionQuality number
---@param AmbientOcclusionMipBlend number
---@param AmbientOcclusionMipScale number
---@param AmbientOcclusionMipThreshold number
---@param AmbientOcclusionTemporalBlendWeight number
---@param RayTracingAO boolean
---@param RayTracingAOSamplesPerPixel integer
---@param RayTracingAOIntensity number
---@param RayTracingAORadius number
---@param ColorGradingIntensity number
---@param ColorGradingLUT Texture
---@param DepthOfFieldSensorWidth number
---@param DepthOfFieldSqueezeFactor number
---@param DepthOfFieldFocalDistance number
---@param DepthOfFieldDepthBlurAmount number
---@param DepthOfFieldDepthBlurRadius number
---@param DepthOfFieldUseHairDepth boolean
---@param DepthOfFieldPetzvalBokeh number
---@param DepthOfFieldPetzvalBokehFalloff number
---@param DepthOfFieldPetzvalExclusionBoxExtents Vector2f
---@param DepthOfFieldPetzvalExclusionBoxRadius number
---@param DepthOfFieldAspectRatioScalar number
---@param DepthOfFieldBarrelRadius number
---@param DepthOfFieldBarrelLength number
---@param DepthOfFieldMatteBoxFlags MatteBoxFlag
---@param DepthOfFieldFocalRegion number
---@param DepthOfFieldNearTransitionRegion number
---@param DepthOfFieldFarTransitionRegion number
---@param DepthOfFieldScale number
---@param DepthOfFieldNearBlurSize number
---@param DepthOfFieldFarBlurSize number
---@param DepthOfFieldOcclusion number
---@param DepthOfFieldSkyFocusDistance number
---@param DepthOfFieldVignetteSize number
---@param MotionBlurAmount number
---@param MotionBlurMax number
---@param MotionBlurTargetFPS integer
---@param MotionBlurPerObjectSize number
---@param LPVIntensity number
---@param LPVVplInjectionBias number
---@param LPVSize number
---@param LPVSecondaryOcclusionIntensity number
---@param LPVSecondaryBounceIntensity number
---@param LPVGeometryVolumeBias number
---@param LPVEmissiveInjectionIntensity number
---@param LPVDirectionalOcclusionIntensity number
---@param LPVDirectionalOcclusionRadius number
---@param LPVDiffuseOcclusionExponent number
---@param LPVSpecularOcclusionExponent number
---@param LPVDiffuseOcclusionIntensity number
---@param LPVSpecularOcclusionIntensity number
---@param TranslucencyType ETranslucencyType
---@param RayTracingTranslucencyMaxRoughness number
---@param RayTracingTranslucencyRefractionRays integer
---@param RayTracingTranslucencySamplesPerPixel integer
---@param RayTracingTranslucencyMaxPrimaryHitEvents integer
---@param RayTracingTranslucencyMaxSecondaryHitEvents integer
---@param RayTracingTranslucencyShadows EReflectedAndRefractedRayTracedShadows
---@param RayTracingTranslucencyRefraction boolean
---@param RayTracingTranslucencyUseRayTracedRefraction boolean
---@param PathTracingMaxBounces integer
---@param PathTracingSamplesPerPixel integer
---@param PathTracingMaxPathIntensity number
---@param PathTracingEnableEmissiveMaterials boolean
---@param PathTracingEnableReferenceDOF boolean
---@param PathTracingEnableReferenceAtmosphere boolean
---@param PathTracingEnableDenoiser boolean
---@param PathTracingIncludeEmissive boolean
---@param PathTracingIncludeDiffuse boolean
---@param PathTracingIncludeIndirectDiffuse boolean
---@param PathTracingIncludeSpecular boolean
---@param PathTracingIncludeIndirectSpecular boolean
---@param PathTracingIncludeVolume boolean
---@param PathTracingIncludeIndirectVolume boolean
---@param LPVFadeRange number
---@param LPVDirectionalOcclusionFadeRange number
---@param ScreenPercentage number
---@param UserFlags integer
---@param WeightedBlendables WeightedBlendables
---@param PreviewBlendable Object
---@param Blendables Object[]
function PostProcessSettings.new(bOverride_TemperatureType, bOverride_WhiteTemp, bOverride_WhiteTint, bOverride_ColorSaturation, bOverride_ColorContrast, bOverride_ColorGamma, bOverride_ColorGain, bOverride_ColorOffset, bOverride_ColorSaturationShadows, bOverride_ColorContrastShadows, bOverride_ColorGammaShadows, bOverride_ColorGainShadows, bOverride_ColorOffsetShadows, bOverride_ColorSaturationMidtones, bOverride_ColorContrastMidtones, bOverride_ColorGammaMidtones, bOverride_ColorGainMidtones, bOverride_ColorOffsetMidtones, bOverride_ColorSaturationHighlights, bOverride_ColorContrastHighlights, bOverride_ColorGammaHighlights, bOverride_ColorGainHighlights, bOverride_ColorOffsetHighlights, bOverride_ColorCorrectionShadowsMax, bOverride_ColorCorrectionHighlightsMin, bOverride_ColorCorrectionHighlightsMax, bOverride_BlueCorrection, bOverride_ExpandGamut, bOverride_ToneCurveAmount, bOverride_FilmSlope, bOverride_FilmToe, bOverride_FilmShoulder, bOverride_FilmBlackClip, bOverride_FilmWhiteClip, bOverride_SceneColorTint, bOverride_SceneFringeIntensity, bOverride_ChromaticAberrationStartOffset, bOverride_bMegaLights, bOverride_AmbientCubemapTint, bOverride_AmbientCubemapIntensity, bOverride_BloomMethod, bOverride_BloomIntensity, bOverride_BloomThreshold, bOverride_Bloom1Tint, bOverride_Bloom1Size, bOverride_Bloom2Size, bOverride_Bloom2Tint, bOverride_Bloom3Tint, bOverride_Bloom3Size, bOverride_Bloom4Tint, bOverride_Bloom4Size, bOverride_Bloom5Tint, bOverride_Bloom5Size, bOverride_Bloom6Tint, bOverride_Bloom6Size, bOverride_BloomSizeScale, bOverride_BloomConvolutionTexture, bOverride_BloomConvolutionScatterDispersion, bOverride_BloomConvolutionSize, bOverride_BloomConvolutionCenterUV, bOverride_BloomConvolutionPreFilter, bOverride_BloomConvolutionPreFilterMin, bOverride_BloomConvolutionPreFilterMax, bOverride_BloomConvolutionPreFilterMult, bOverride_BloomConvolutionBufferScale, bOverride_BloomDirtMaskIntensity, bOverride_BloomDirtMaskTint, bOverride_BloomDirtMask, bOverride_CameraShutterSpeed, bOverride_CameraISO, bOverride_AutoExposureMethod, bOverride_AutoExposureLowPercent, bOverride_AutoExposureHighPercent, bOverride_AutoExposureMinBrightness, bOverride_AutoExposureMaxBrightness, bOverride_AutoExposureCalibrationConstant, bOverride_AutoExposureSpeedUp, bOverride_AutoExposureSpeedDown, bOverride_AutoExposureBias, bOverride_AutoExposureBiasCurve, bOverride_AutoExposureMeterMask, bOverride_AutoExposureApplyPhysicalCameraExposure, bOverride_HistogramLogMin, bOverride_HistogramLogMax, bOverride_LocalExposureMethod, bOverride_LocalExposureContrastScale, bOverride_LocalExposureHighlightContrastScale, bOverride_LocalExposureShadowContrastScale, bOverride_LocalExposureHighlightContrastCurve, bOverride_LocalExposureShadowContrastCurve, bOverride_LocalExposureHighlightThreshold, bOverride_LocalExposureShadowThreshold, bOverride_LocalExposureDetailStrength, bOverride_LocalExposureBlurredLuminanceBlend, bOverride_LocalExposureBlurredLuminanceKernelSizePercent, bOverride_LocalExposureHighlightThresholdStrength, bOverride_LocalExposureShadowThresholdStrength, bOverride_LocalExposureMiddleGreyBias, bOverride_LensFlareIntensity, bOverride_LensFlareTint, bOverride_LensFlareTints, bOverride_LensFlareBokehSize, bOverride_LensFlareBokehShape, bOverride_LensFlareThreshold, bOverride_VignetteIntensity, bOverride_Sharpen, bOverride_GrainIntensity, bOverride_GrainJitter, bOverride_FilmGrainIntensity, bOverride_FilmGrainIntensityShadows, bOverride_FilmGrainIntensityMidtones, bOverride_FilmGrainIntensityHighlights, bOverride_FilmGrainShadowsMax, bOverride_FilmGrainHighlightsMin, bOverride_FilmGrainHighlightsMax, bOverride_FilmGrainTexelSize, bOverride_FilmGrainTexture, bOverride_AmbientOcclusionIntensity, bOverride_AmbientOcclusionStaticFraction, bOverride_AmbientOcclusionRadius, bOverride_AmbientOcclusionFadeDistance, bOverride_AmbientOcclusionFadeRadius, bOverride_AmbientOcclusionDistance, bOverride_AmbientOcclusionRadiusInWS, bOverride_AmbientOcclusionPower, bOverride_AmbientOcclusionBias, bOverride_AmbientOcclusionQuality, bOverride_AmbientOcclusionMipBlend, bOverride_AmbientOcclusionMipScale, bOverride_AmbientOcclusionMipThreshold, bOverride_AmbientOcclusionTemporalBlendWeight, bOverride_RayTracingAO, bOverride_RayTracingAOSamplesPerPixel, bOverride_RayTracingAOIntensity, bOverride_RayTracingAORadius, bOverride_LPVIntensity, bOverride_LPVDirectionalOcclusionIntensity, bOverride_LPVDirectionalOcclusionRadius, bOverride_LPVDiffuseOcclusionExponent, bOverride_LPVSpecularOcclusionExponent, bOverride_LPVDiffuseOcclusionIntensity, bOverride_LPVSpecularOcclusionIntensity, bOverride_LPVSize, bOverride_LPVSecondaryOcclusionIntensity, bOverride_LPVSecondaryBounceIntensity, bOverride_LPVGeometryVolumeBias, bOverride_LPVVplInjectionBias, bOverride_LPVEmissiveInjectionIntensity, bOverride_LPVFadeRange, bOverride_LPVDirectionalOcclusionFadeRange, bOverride_IndirectLightingColor, bOverride_IndirectLightingIntensity, bOverride_ColorGradingIntensity, bOverride_ColorGradingLUT, bOverride_DepthOfFieldFocalDistance, bOverride_DepthOfFieldFstop, bOverride_DepthOfFieldMinFstop, bOverride_DepthOfFieldBladeCount, bOverride_DepthOfFieldSensorWidth, bOverride_DepthOfFieldSqueezeFactor, bOverride_DepthOfFieldDepthBlurRadius, bOverride_DepthOfFieldUseHairDepth, bOverride_DepthOfFieldPetzvalBokeh, bOverride_DepthOfFieldPetzvalBokehFalloff, bOverride_DepthOfFieldPetzvalExclusionBoxExtents, bOverride_DepthOfFieldPetzvalExclusionBoxRadius, bOverride_DepthOfFieldAspectRatioScalar, bOverride_DepthOfFieldMatteBoxFlags, bOverride_DepthOfFieldBarrelRadius, bOverride_DepthOfFieldBarrelLength, bOverride_DepthOfFieldDepthBlurAmount, bOverride_DepthOfFieldFocalRegion, bOverride_DepthOfFieldNearTransitionRegion, bOverride_DepthOfFieldFarTransitionRegion, bOverride_DepthOfFieldScale, bOverride_DepthOfFieldNearBlurSize, bOverride_DepthOfFieldFarBlurSize, bOverride_MobileHQGaussian, bOverride_DepthOfFieldOcclusion, bOverride_DepthOfFieldSkyFocusDistance, bOverride_DepthOfFieldVignetteSize, bOverride_MotionBlurAmount, bOverride_MotionBlurMax, bOverride_MotionBlurTargetFPS, bOverride_MotionBlurPerObjectSize, bOverride_ScreenPercentage, bOverride_ReflectionMethod, bOverride_LumenReflectionQuality, bOverride_ScreenSpaceReflectionIntensity, bOverride_ScreenSpaceReflectionQuality, bOverride_ScreenSpaceReflectionMaxRoughness, bOverride_ScreenSpaceReflectionRoughnessScale, bOverride_UserFlags, bOverride_ReflectionsType, bOverride_RayTracingReflectionsMaxRoughness, bOverride_RayTracingReflectionsMaxBounces, bOverride_RayTracingReflectionsSamplesPerPixel, bOverride_RayTracingReflectionsShadows, bOverride_RayTracingReflectionsTranslucency, bOverride_TranslucencyType, bOverride_RayTracingTranslucencyMaxRoughness, bOverride_RayTracingTranslucencyRefractionRays, bOverride_RayTracingTranslucencySamplesPerPixel, bOverride_RayTracingTranslucencyShadows, bOverride_RayTracingTranslucencyRefraction, bOverride_RayTracingTranslucencyMaxPrimaryHitEvents, bOverride_RayTracingTranslucencyMaxSecondaryHitEvents, bOverride_RayTracingTranslucencyUseRayTracedRefraction, bOverride_DynamicGlobalIlluminationMethod, bOverride_LumenSceneLightingQuality, bOverride_LumenSceneDetail, bOverride_LumenSceneViewDistance, bOverride_LumenSceneLightingUpdateSpeed, bOverride_LumenFinalGatherQuality, bOverride_LumenFinalGatherLightingUpdateSpeed, bOverride_LumenFinalGatherScreenTraces, bOverride_LumenMaxTraceDistance, bOverride_LumenDiffuseColorBoost, bOverride_LumenSkylightLeaking, bOverride_LumenSkylightLeakingTint, bOverride_LumenFullSkylightLeakingDistance, bOverride_LumenRayLightingMode, bOverride_LumenReflectionsScreenTraces, bOverride_LumenFrontLayerTranslucencyReflections, bOverride_LumenMaxRoughnessToTraceReflections, bOverride_LumenMaxReflectionBounces, bOverride_LumenMaxRefractionBounces, bOverride_LumenSurfaceCacheResolution, bOverride_RayTracingGI, bOverride_RayTracingGIMaxBounces, bOverride_RayTracingGISamplesPerPixel, bOverride_PathTracingMaxBounces, bOverride_PathTracingSamplesPerPixel, bOverride_PathTracingMaxPathIntensity, bOverride_PathTracingEnableEmissiveMaterials, bOverride_PathTracingEnableReferenceDOF, bOverride_PathTracingEnableReferenceAtmosphere, bOverride_PathTracingEnableDenoiser, bOverride_PathTracingIncludeEmissive, bOverride_PathTracingIncludeDiffuse, bOverride_PathTracingIncludeIndirectDiffuse, bOverride_PathTracingIncludeSpecular, bOverride_PathTracingIncludeIndirectSpecular, bOverride_PathTracingIncludeVolume, bOverride_PathTracingIncludeIndirectVolume, bMobileHQGaussian, BloomMethod, AutoExposureMethod, DepthOfFieldMethod, TemperatureType, WhiteTemp, WhiteTint, ColorSaturation, ColorContrast, ColorGamma, ColorGain, ColorOffset, ColorSaturationShadows, ColorContrastShadows, ColorGammaShadows, ColorGainShadows, ColorOffsetShadows, ColorSaturationMidtones, ColorContrastMidtones, ColorGammaMidtones, ColorGainMidtones, ColorOffsetMidtones, ColorSaturationHighlights, ColorContrastHighlights, ColorGammaHighlights, ColorGainHighlights, ColorOffsetHighlights, ColorCorrectionHighlightsMin, ColorCorrectionHighlightsMax, ColorCorrectionShadowsMax, BlueCorrection, ExpandGamut, ToneCurveAmount, FilmSlope, FilmToe, FilmShoulder, FilmBlackClip, FilmWhiteClip, SceneColorTint, SceneFringeIntensity, ChromaticAberrationStartOffset, BloomIntensity, BloomThreshold, BloomSizeScale, Bloom1Size, Bloom2Size, Bloom3Size, Bloom4Size, Bloom5Size, Bloom6Size, Bloom1Tint, Bloom2Tint, Bloom3Tint, Bloom4Tint, Bloom5Tint, Bloom6Tint, BloomConvolutionScatterDispersion, BloomConvolutionSize, BloomConvolutionTexture, BloomConvolutionCenterUV, BloomConvolutionPreFilter, BloomConvolutionPreFilterMin, BloomConvolutionPreFilterMax, BloomConvolutionPreFilterMult, BloomConvolutionBufferScale, BloomDirtMask, BloomDirtMaskIntensity, BloomDirtMaskTint, DynamicGlobalIlluminationMethod, IndirectLightingColor, IndirectLightingIntensity, LumenRayLightingMode, LumenSceneLightingQuality, LumenSceneDetail, LumenSceneViewDistance, LumenSceneLightingUpdateSpeed, LumenFinalGatherQuality, LumenFinalGatherLightingUpdateSpeed, LumenFinalGatherScreenTraces, LumenMaxTraceDistance, LumenDiffuseColorBoost, LumenSkylightLeaking, LumenSkylightLeakingTint, LumenFullSkylightLeakingDistance, LumenSurfaceCacheResolution, ReflectionMethod, ReflectionsType, LumenReflectionQuality, LumenReflectionsScreenTraces, LumenFrontLayerTranslucencyReflections, LumenMaxRoughnessToTraceReflections, LumenMaxReflectionBounces, LumenMaxRefractionBounces, ScreenSpaceReflectionIntensity, ScreenSpaceReflectionQuality, ScreenSpaceReflectionMaxRoughness, bMegaLights, AmbientCubemapTint, AmbientCubemapIntensity, AmbientCubemap, CameraShutterSpeed, CameraISO, DepthOfFieldFstop, DepthOfFieldMinFstop, DepthOfFieldBladeCount, AutoExposureBias, AutoExposureBiasBackup, bOverride_AutoExposureBiasBackup, AutoExposureApplyPhysicalCameraExposure, AutoExposureBiasCurve, AutoExposureMeterMask, AutoExposureLowPercent, AutoExposureHighPercent, AutoExposureMinBrightness, AutoExposureMaxBrightness, AutoExposureSpeedUp, AutoExposureSpeedDown, HistogramLogMin, HistogramLogMax, AutoExposureCalibrationConstant, LocalExposureMethod, LocalExposureContrastScale, LocalExposureHighlightContrastScale, LocalExposureShadowContrastScale, LocalExposureHighlightContrastCurve, LocalExposureShadowContrastCurve, LocalExposureHighlightThreshold, LocalExposureShadowThreshold, LocalExposureDetailStrength, LocalExposureBlurredLuminanceBlend, LocalExposureBlurredLuminanceKernelSizePercent, LocalExposureHighlightThresholdStrength, LocalExposureShadowThresholdStrength, LocalExposureMiddleGreyBias, LensFlareIntensity, LensFlareTint, LensFlareBokehSize, LensFlareThreshold, LensFlareBokehShape, LensFlareTints, VignetteIntensity, Sharpen, GrainJitter, GrainIntensity, FilmGrainIntensity, FilmGrainIntensityShadows, FilmGrainIntensityMidtones, FilmGrainIntensityHighlights, FilmGrainShadowsMax, FilmGrainHighlightsMin, FilmGrainHighlightsMax, FilmGrainTexelSize, FilmGrainTexture, AmbientOcclusionIntensity, AmbientOcclusionStaticFraction, AmbientOcclusionRadius, AmbientOcclusionRadiusInWS, AmbientOcclusionFadeDistance, AmbientOcclusionFadeRadius, AmbientOcclusionDistance, AmbientOcclusionPower, AmbientOcclusionBias, AmbientOcclusionQuality, AmbientOcclusionMipBlend, AmbientOcclusionMipScale, AmbientOcclusionMipThreshold, AmbientOcclusionTemporalBlendWeight, RayTracingAO, RayTracingAOSamplesPerPixel, RayTracingAOIntensity, RayTracingAORadius, ColorGradingIntensity, ColorGradingLUT, DepthOfFieldSensorWidth, DepthOfFieldSqueezeFactor, DepthOfFieldFocalDistance, DepthOfFieldDepthBlurAmount, DepthOfFieldDepthBlurRadius, DepthOfFieldUseHairDepth, DepthOfFieldPetzvalBokeh, DepthOfFieldPetzvalBokehFalloff, DepthOfFieldPetzvalExclusionBoxExtents, DepthOfFieldPetzvalExclusionBoxRadius, DepthOfFieldAspectRatioScalar, DepthOfFieldBarrelRadius, DepthOfFieldBarrelLength, DepthOfFieldMatteBoxFlags, DepthOfFieldFocalRegion, DepthOfFieldNearTransitionRegion, DepthOfFieldFarTransitionRegion, DepthOfFieldScale, DepthOfFieldNearBlurSize, DepthOfFieldFarBlurSize, DepthOfFieldOcclusion, DepthOfFieldSkyFocusDistance, DepthOfFieldVignetteSize, MotionBlurAmount, MotionBlurMax, MotionBlurTargetFPS, MotionBlurPerObjectSize, LPVIntensity, LPVVplInjectionBias, LPVSize, LPVSecondaryOcclusionIntensity, LPVSecondaryBounceIntensity, LPVGeometryVolumeBias, LPVEmissiveInjectionIntensity, LPVDirectionalOcclusionIntensity, LPVDirectionalOcclusionRadius, LPVDiffuseOcclusionExponent, LPVSpecularOcclusionExponent, LPVDiffuseOcclusionIntensity, LPVSpecularOcclusionIntensity, TranslucencyType, RayTracingTranslucencyMaxRoughness, RayTracingTranslucencyRefractionRays, RayTracingTranslucencySamplesPerPixel, RayTracingTranslucencyMaxPrimaryHitEvents, RayTracingTranslucencyMaxSecondaryHitEvents, RayTracingTranslucencyShadows, RayTracingTranslucencyRefraction, RayTracingTranslucencyUseRayTracedRefraction, PathTracingMaxBounces, PathTracingSamplesPerPixel, PathTracingMaxPathIntensity, PathTracingEnableEmissiveMaterials, PathTracingEnableReferenceDOF, PathTracingEnableReferenceAtmosphere, PathTracingEnableDenoiser, PathTracingIncludeEmissive, PathTracingIncludeDiffuse, PathTracingIncludeIndirectDiffuse, PathTracingIncludeSpecular, PathTracingIncludeIndirectSpecular, PathTracingIncludeVolume, PathTracingIncludeIndirectVolume, LPVFadeRange, LPVDirectionalOcclusionFadeRange, ScreenPercentage, UserFlags, WeightedBlendables, PreviewBlendable, Blendables)
    local self = {}
    self.bOverride_TemperatureType = bOverride_TemperatureType
    self.bOverride_WhiteTemp = bOverride_WhiteTemp
    self.bOverride_WhiteTint = bOverride_WhiteTint
    self.bOverride_ColorSaturation = bOverride_ColorSaturation
    self.bOverride_ColorContrast = bOverride_ColorContrast
    self.bOverride_ColorGamma = bOverride_ColorGamma
    self.bOverride_ColorGain = bOverride_ColorGain
    self.bOverride_ColorOffset = bOverride_ColorOffset
    self.bOverride_ColorSaturationShadows = bOverride_ColorSaturationShadows
    self.bOverride_ColorContrastShadows = bOverride_ColorContrastShadows
    self.bOverride_ColorGammaShadows = bOverride_ColorGammaShadows
    self.bOverride_ColorGainShadows = bOverride_ColorGainShadows
    self.bOverride_ColorOffsetShadows = bOverride_ColorOffsetShadows
    self.bOverride_ColorSaturationMidtones = bOverride_ColorSaturationMidtones
    self.bOverride_ColorContrastMidtones = bOverride_ColorContrastMidtones
    self.bOverride_ColorGammaMidtones = bOverride_ColorGammaMidtones
    self.bOverride_ColorGainMidtones = bOverride_ColorGainMidtones
    self.bOverride_ColorOffsetMidtones = bOverride_ColorOffsetMidtones
    self.bOverride_ColorSaturationHighlights = bOverride_ColorSaturationHighlights
    self.bOverride_ColorContrastHighlights = bOverride_ColorContrastHighlights
    self.bOverride_ColorGammaHighlights = bOverride_ColorGammaHighlights
    self.bOverride_ColorGainHighlights = bOverride_ColorGainHighlights
    self.bOverride_ColorOffsetHighlights = bOverride_ColorOffsetHighlights
    self.bOverride_ColorCorrectionShadowsMax = bOverride_ColorCorrectionShadowsMax
    self.bOverride_ColorCorrectionHighlightsMin = bOverride_ColorCorrectionHighlightsMin
    self.bOverride_ColorCorrectionHighlightsMax = bOverride_ColorCorrectionHighlightsMax
    self.bOverride_BlueCorrection = bOverride_BlueCorrection
    self.bOverride_ExpandGamut = bOverride_ExpandGamut
    self.bOverride_ToneCurveAmount = bOverride_ToneCurveAmount
    self.bOverride_FilmSlope = bOverride_FilmSlope
    self.bOverride_FilmToe = bOverride_FilmToe
    self.bOverride_FilmShoulder = bOverride_FilmShoulder
    self.bOverride_FilmBlackClip = bOverride_FilmBlackClip
    self.bOverride_FilmWhiteClip = bOverride_FilmWhiteClip
    self.bOverride_SceneColorTint = bOverride_SceneColorTint
    self.bOverride_SceneFringeIntensity = bOverride_SceneFringeIntensity
    self.bOverride_ChromaticAberrationStartOffset = bOverride_ChromaticAberrationStartOffset
    self.bOverride_bMegaLights = bOverride_bMegaLights
    self.bOverride_AmbientCubemapTint = bOverride_AmbientCubemapTint
    self.bOverride_AmbientCubemapIntensity = bOverride_AmbientCubemapIntensity
    self.bOverride_BloomMethod = bOverride_BloomMethod
    self.bOverride_BloomIntensity = bOverride_BloomIntensity
    self.bOverride_BloomThreshold = bOverride_BloomThreshold
    self.bOverride_Bloom1Tint = bOverride_Bloom1Tint
    self.bOverride_Bloom1Size = bOverride_Bloom1Size
    self.bOverride_Bloom2Size = bOverride_Bloom2Size
    self.bOverride_Bloom2Tint = bOverride_Bloom2Tint
    self.bOverride_Bloom3Tint = bOverride_Bloom3Tint
    self.bOverride_Bloom3Size = bOverride_Bloom3Size
    self.bOverride_Bloom4Tint = bOverride_Bloom4Tint
    self.bOverride_Bloom4Size = bOverride_Bloom4Size
    self.bOverride_Bloom5Tint = bOverride_Bloom5Tint
    self.bOverride_Bloom5Size = bOverride_Bloom5Size
    self.bOverride_Bloom6Tint = bOverride_Bloom6Tint
    self.bOverride_Bloom6Size = bOverride_Bloom6Size
    self.bOverride_BloomSizeScale = bOverride_BloomSizeScale
    self.bOverride_BloomConvolutionTexture = bOverride_BloomConvolutionTexture
    self.bOverride_BloomConvolutionScatterDispersion = bOverride_BloomConvolutionScatterDispersion
    self.bOverride_BloomConvolutionSize = bOverride_BloomConvolutionSize
    self.bOverride_BloomConvolutionCenterUV = bOverride_BloomConvolutionCenterUV
    self.bOverride_BloomConvolutionPreFilter = bOverride_BloomConvolutionPreFilter
    self.bOverride_BloomConvolutionPreFilterMin = bOverride_BloomConvolutionPreFilterMin
    self.bOverride_BloomConvolutionPreFilterMax = bOverride_BloomConvolutionPreFilterMax
    self.bOverride_BloomConvolutionPreFilterMult = bOverride_BloomConvolutionPreFilterMult
    self.bOverride_BloomConvolutionBufferScale = bOverride_BloomConvolutionBufferScale
    self.bOverride_BloomDirtMaskIntensity = bOverride_BloomDirtMaskIntensity
    self.bOverride_BloomDirtMaskTint = bOverride_BloomDirtMaskTint
    self.bOverride_BloomDirtMask = bOverride_BloomDirtMask
    self.bOverride_CameraShutterSpeed = bOverride_CameraShutterSpeed
    self.bOverride_CameraISO = bOverride_CameraISO
    self.bOverride_AutoExposureMethod = bOverride_AutoExposureMethod
    self.bOverride_AutoExposureLowPercent = bOverride_AutoExposureLowPercent
    self.bOverride_AutoExposureHighPercent = bOverride_AutoExposureHighPercent
    self.bOverride_AutoExposureMinBrightness = bOverride_AutoExposureMinBrightness
    self.bOverride_AutoExposureMaxBrightness = bOverride_AutoExposureMaxBrightness
    self.bOverride_AutoExposureCalibrationConstant = bOverride_AutoExposureCalibrationConstant
    self.bOverride_AutoExposureSpeedUp = bOverride_AutoExposureSpeedUp
    self.bOverride_AutoExposureSpeedDown = bOverride_AutoExposureSpeedDown
    self.bOverride_AutoExposureBias = bOverride_AutoExposureBias
    self.bOverride_AutoExposureBiasCurve = bOverride_AutoExposureBiasCurve
    self.bOverride_AutoExposureMeterMask = bOverride_AutoExposureMeterMask
    self.bOverride_AutoExposureApplyPhysicalCameraExposure = bOverride_AutoExposureApplyPhysicalCameraExposure
    self.bOverride_HistogramLogMin = bOverride_HistogramLogMin
    self.bOverride_HistogramLogMax = bOverride_HistogramLogMax
    self.bOverride_LocalExposureMethod = bOverride_LocalExposureMethod
    self.bOverride_LocalExposureContrastScale = bOverride_LocalExposureContrastScale
    self.bOverride_LocalExposureHighlightContrastScale = bOverride_LocalExposureHighlightContrastScale
    self.bOverride_LocalExposureShadowContrastScale = bOverride_LocalExposureShadowContrastScale
    self.bOverride_LocalExposureHighlightContrastCurve = bOverride_LocalExposureHighlightContrastCurve
    self.bOverride_LocalExposureShadowContrastCurve = bOverride_LocalExposureShadowContrastCurve
    self.bOverride_LocalExposureHighlightThreshold = bOverride_LocalExposureHighlightThreshold
    self.bOverride_LocalExposureShadowThreshold = bOverride_LocalExposureShadowThreshold
    self.bOverride_LocalExposureDetailStrength = bOverride_LocalExposureDetailStrength
    self.bOverride_LocalExposureBlurredLuminanceBlend = bOverride_LocalExposureBlurredLuminanceBlend
    self.bOverride_LocalExposureBlurredLuminanceKernelSizePercent = bOverride_LocalExposureBlurredLuminanceKernelSizePercent
    self.bOverride_LocalExposureHighlightThresholdStrength = bOverride_LocalExposureHighlightThresholdStrength
    self.bOverride_LocalExposureShadowThresholdStrength = bOverride_LocalExposureShadowThresholdStrength
    self.bOverride_LocalExposureMiddleGreyBias = bOverride_LocalExposureMiddleGreyBias
    self.bOverride_LensFlareIntensity = bOverride_LensFlareIntensity
    self.bOverride_LensFlareTint = bOverride_LensFlareTint
    self.bOverride_LensFlareTints = bOverride_LensFlareTints
    self.bOverride_LensFlareBokehSize = bOverride_LensFlareBokehSize
    self.bOverride_LensFlareBokehShape = bOverride_LensFlareBokehShape
    self.bOverride_LensFlareThreshold = bOverride_LensFlareThreshold
    self.bOverride_VignetteIntensity = bOverride_VignetteIntensity
    self.bOverride_Sharpen = bOverride_Sharpen
    self.bOverride_GrainIntensity = bOverride_GrainIntensity
    self.bOverride_GrainJitter = bOverride_GrainJitter
    self.bOverride_FilmGrainIntensity = bOverride_FilmGrainIntensity
    self.bOverride_FilmGrainIntensityShadows = bOverride_FilmGrainIntensityShadows
    self.bOverride_FilmGrainIntensityMidtones = bOverride_FilmGrainIntensityMidtones
    self.bOverride_FilmGrainIntensityHighlights = bOverride_FilmGrainIntensityHighlights
    self.bOverride_FilmGrainShadowsMax = bOverride_FilmGrainShadowsMax
    self.bOverride_FilmGrainHighlightsMin = bOverride_FilmGrainHighlightsMin
    self.bOverride_FilmGrainHighlightsMax = bOverride_FilmGrainHighlightsMax
    self.bOverride_FilmGrainTexelSize = bOverride_FilmGrainTexelSize
    self.bOverride_FilmGrainTexture = bOverride_FilmGrainTexture
    self.bOverride_AmbientOcclusionIntensity = bOverride_AmbientOcclusionIntensity
    self.bOverride_AmbientOcclusionStaticFraction = bOverride_AmbientOcclusionStaticFraction
    self.bOverride_AmbientOcclusionRadius = bOverride_AmbientOcclusionRadius
    self.bOverride_AmbientOcclusionFadeDistance = bOverride_AmbientOcclusionFadeDistance
    self.bOverride_AmbientOcclusionFadeRadius = bOverride_AmbientOcclusionFadeRadius
    self.bOverride_AmbientOcclusionDistance = bOverride_AmbientOcclusionDistance
    self.bOverride_AmbientOcclusionRadiusInWS = bOverride_AmbientOcclusionRadiusInWS
    self.bOverride_AmbientOcclusionPower = bOverride_AmbientOcclusionPower
    self.bOverride_AmbientOcclusionBias = bOverride_AmbientOcclusionBias
    self.bOverride_AmbientOcclusionQuality = bOverride_AmbientOcclusionQuality
    self.bOverride_AmbientOcclusionMipBlend = bOverride_AmbientOcclusionMipBlend
    self.bOverride_AmbientOcclusionMipScale = bOverride_AmbientOcclusionMipScale
    self.bOverride_AmbientOcclusionMipThreshold = bOverride_AmbientOcclusionMipThreshold
    self.bOverride_AmbientOcclusionTemporalBlendWeight = bOverride_AmbientOcclusionTemporalBlendWeight
    self.bOverride_RayTracingAO = bOverride_RayTracingAO
    self.bOverride_RayTracingAOSamplesPerPixel = bOverride_RayTracingAOSamplesPerPixel
    self.bOverride_RayTracingAOIntensity = bOverride_RayTracingAOIntensity
    self.bOverride_RayTracingAORadius = bOverride_RayTracingAORadius
    self.bOverride_LPVIntensity = bOverride_LPVIntensity
    self.bOverride_LPVDirectionalOcclusionIntensity = bOverride_LPVDirectionalOcclusionIntensity
    self.bOverride_LPVDirectionalOcclusionRadius = bOverride_LPVDirectionalOcclusionRadius
    self.bOverride_LPVDiffuseOcclusionExponent = bOverride_LPVDiffuseOcclusionExponent
    self.bOverride_LPVSpecularOcclusionExponent = bOverride_LPVSpecularOcclusionExponent
    self.bOverride_LPVDiffuseOcclusionIntensity = bOverride_LPVDiffuseOcclusionIntensity
    self.bOverride_LPVSpecularOcclusionIntensity = bOverride_LPVSpecularOcclusionIntensity
    self.bOverride_LPVSize = bOverride_LPVSize
    self.bOverride_LPVSecondaryOcclusionIntensity = bOverride_LPVSecondaryOcclusionIntensity
    self.bOverride_LPVSecondaryBounceIntensity = bOverride_LPVSecondaryBounceIntensity
    self.bOverride_LPVGeometryVolumeBias = bOverride_LPVGeometryVolumeBias
    self.bOverride_LPVVplInjectionBias = bOverride_LPVVplInjectionBias
    self.bOverride_LPVEmissiveInjectionIntensity = bOverride_LPVEmissiveInjectionIntensity
    self.bOverride_LPVFadeRange = bOverride_LPVFadeRange
    self.bOverride_LPVDirectionalOcclusionFadeRange = bOverride_LPVDirectionalOcclusionFadeRange
    self.bOverride_IndirectLightingColor = bOverride_IndirectLightingColor
    self.bOverride_IndirectLightingIntensity = bOverride_IndirectLightingIntensity
    self.bOverride_ColorGradingIntensity = bOverride_ColorGradingIntensity
    self.bOverride_ColorGradingLUT = bOverride_ColorGradingLUT
    self.bOverride_DepthOfFieldFocalDistance = bOverride_DepthOfFieldFocalDistance
    self.bOverride_DepthOfFieldFstop = bOverride_DepthOfFieldFstop
    self.bOverride_DepthOfFieldMinFstop = bOverride_DepthOfFieldMinFstop
    self.bOverride_DepthOfFieldBladeCount = bOverride_DepthOfFieldBladeCount
    self.bOverride_DepthOfFieldSensorWidth = bOverride_DepthOfFieldSensorWidth
    self.bOverride_DepthOfFieldSqueezeFactor = bOverride_DepthOfFieldSqueezeFactor
    self.bOverride_DepthOfFieldDepthBlurRadius = bOverride_DepthOfFieldDepthBlurRadius
    self.bOverride_DepthOfFieldUseHairDepth = bOverride_DepthOfFieldUseHairDepth
    self.bOverride_DepthOfFieldPetzvalBokeh = bOverride_DepthOfFieldPetzvalBokeh
    self.bOverride_DepthOfFieldPetzvalBokehFalloff = bOverride_DepthOfFieldPetzvalBokehFalloff
    self.bOverride_DepthOfFieldPetzvalExclusionBoxExtents = bOverride_DepthOfFieldPetzvalExclusionBoxExtents
    self.bOverride_DepthOfFieldPetzvalExclusionBoxRadius = bOverride_DepthOfFieldPetzvalExclusionBoxRadius
    self.bOverride_DepthOfFieldAspectRatioScalar = bOverride_DepthOfFieldAspectRatioScalar
    self.bOverride_DepthOfFieldMatteBoxFlags = bOverride_DepthOfFieldMatteBoxFlags
    self.bOverride_DepthOfFieldBarrelRadius = bOverride_DepthOfFieldBarrelRadius
    self.bOverride_DepthOfFieldBarrelLength = bOverride_DepthOfFieldBarrelLength
    self.bOverride_DepthOfFieldDepthBlurAmount = bOverride_DepthOfFieldDepthBlurAmount
    self.bOverride_DepthOfFieldFocalRegion = bOverride_DepthOfFieldFocalRegion
    self.bOverride_DepthOfFieldNearTransitionRegion = bOverride_DepthOfFieldNearTransitionRegion
    self.bOverride_DepthOfFieldFarTransitionRegion = bOverride_DepthOfFieldFarTransitionRegion
    self.bOverride_DepthOfFieldScale = bOverride_DepthOfFieldScale
    self.bOverride_DepthOfFieldNearBlurSize = bOverride_DepthOfFieldNearBlurSize
    self.bOverride_DepthOfFieldFarBlurSize = bOverride_DepthOfFieldFarBlurSize
    self.bOverride_MobileHQGaussian = bOverride_MobileHQGaussian
    self.bOverride_DepthOfFieldOcclusion = bOverride_DepthOfFieldOcclusion
    self.bOverride_DepthOfFieldSkyFocusDistance = bOverride_DepthOfFieldSkyFocusDistance
    self.bOverride_DepthOfFieldVignetteSize = bOverride_DepthOfFieldVignetteSize
    self.bOverride_MotionBlurAmount = bOverride_MotionBlurAmount
    self.bOverride_MotionBlurMax = bOverride_MotionBlurMax
    self.bOverride_MotionBlurTargetFPS = bOverride_MotionBlurTargetFPS
    self.bOverride_MotionBlurPerObjectSize = bOverride_MotionBlurPerObjectSize
    self.bOverride_ScreenPercentage = bOverride_ScreenPercentage
    self.bOverride_ReflectionMethod = bOverride_ReflectionMethod
    self.bOverride_LumenReflectionQuality = bOverride_LumenReflectionQuality
    self.bOverride_ScreenSpaceReflectionIntensity = bOverride_ScreenSpaceReflectionIntensity
    self.bOverride_ScreenSpaceReflectionQuality = bOverride_ScreenSpaceReflectionQuality
    self.bOverride_ScreenSpaceReflectionMaxRoughness = bOverride_ScreenSpaceReflectionMaxRoughness
    self.bOverride_ScreenSpaceReflectionRoughnessScale = bOverride_ScreenSpaceReflectionRoughnessScale
    self.bOverride_UserFlags = bOverride_UserFlags
    self.bOverride_ReflectionsType = bOverride_ReflectionsType
    self.bOverride_RayTracingReflectionsMaxRoughness = bOverride_RayTracingReflectionsMaxRoughness
    self.bOverride_RayTracingReflectionsMaxBounces = bOverride_RayTracingReflectionsMaxBounces
    self.bOverride_RayTracingReflectionsSamplesPerPixel = bOverride_RayTracingReflectionsSamplesPerPixel
    self.bOverride_RayTracingReflectionsShadows = bOverride_RayTracingReflectionsShadows
    self.bOverride_RayTracingReflectionsTranslucency = bOverride_RayTracingReflectionsTranslucency
    self.bOverride_TranslucencyType = bOverride_TranslucencyType
    self.bOverride_RayTracingTranslucencyMaxRoughness = bOverride_RayTracingTranslucencyMaxRoughness
    self.bOverride_RayTracingTranslucencyRefractionRays = bOverride_RayTracingTranslucencyRefractionRays
    self.bOverride_RayTracingTranslucencySamplesPerPixel = bOverride_RayTracingTranslucencySamplesPerPixel
    self.bOverride_RayTracingTranslucencyShadows = bOverride_RayTracingTranslucencyShadows
    self.bOverride_RayTracingTranslucencyRefraction = bOverride_RayTracingTranslucencyRefraction
    self.bOverride_RayTracingTranslucencyMaxPrimaryHitEvents = bOverride_RayTracingTranslucencyMaxPrimaryHitEvents
    self.bOverride_RayTracingTranslucencyMaxSecondaryHitEvents = bOverride_RayTracingTranslucencyMaxSecondaryHitEvents
    self.bOverride_RayTracingTranslucencyUseRayTracedRefraction = bOverride_RayTracingTranslucencyUseRayTracedRefraction
    self.bOverride_DynamicGlobalIlluminationMethod = bOverride_DynamicGlobalIlluminationMethod
    self.bOverride_LumenSceneLightingQuality = bOverride_LumenSceneLightingQuality
    self.bOverride_LumenSceneDetail = bOverride_LumenSceneDetail
    self.bOverride_LumenSceneViewDistance = bOverride_LumenSceneViewDistance
    self.bOverride_LumenSceneLightingUpdateSpeed = bOverride_LumenSceneLightingUpdateSpeed
    self.bOverride_LumenFinalGatherQuality = bOverride_LumenFinalGatherQuality
    self.bOverride_LumenFinalGatherLightingUpdateSpeed = bOverride_LumenFinalGatherLightingUpdateSpeed
    self.bOverride_LumenFinalGatherScreenTraces = bOverride_LumenFinalGatherScreenTraces
    self.bOverride_LumenMaxTraceDistance = bOverride_LumenMaxTraceDistance
    self.bOverride_LumenDiffuseColorBoost = bOverride_LumenDiffuseColorBoost
    self.bOverride_LumenSkylightLeaking = bOverride_LumenSkylightLeaking
    self.bOverride_LumenSkylightLeakingTint = bOverride_LumenSkylightLeakingTint
    self.bOverride_LumenFullSkylightLeakingDistance = bOverride_LumenFullSkylightLeakingDistance
    self.bOverride_LumenRayLightingMode = bOverride_LumenRayLightingMode
    self.bOverride_LumenReflectionsScreenTraces = bOverride_LumenReflectionsScreenTraces
    self.bOverride_LumenFrontLayerTranslucencyReflections = bOverride_LumenFrontLayerTranslucencyReflections
    self.bOverride_LumenMaxRoughnessToTraceReflections = bOverride_LumenMaxRoughnessToTraceReflections
    self.bOverride_LumenMaxReflectionBounces = bOverride_LumenMaxReflectionBounces
    self.bOverride_LumenMaxRefractionBounces = bOverride_LumenMaxRefractionBounces
    self.bOverride_LumenSurfaceCacheResolution = bOverride_LumenSurfaceCacheResolution
    self.bOverride_RayTracingGI = bOverride_RayTracingGI
    self.bOverride_RayTracingGIMaxBounces = bOverride_RayTracingGIMaxBounces
    self.bOverride_RayTracingGISamplesPerPixel = bOverride_RayTracingGISamplesPerPixel
    self.bOverride_PathTracingMaxBounces = bOverride_PathTracingMaxBounces
    self.bOverride_PathTracingSamplesPerPixel = bOverride_PathTracingSamplesPerPixel
    self.bOverride_PathTracingMaxPathIntensity = bOverride_PathTracingMaxPathIntensity
    self.bOverride_PathTracingEnableEmissiveMaterials = bOverride_PathTracingEnableEmissiveMaterials
    self.bOverride_PathTracingEnableReferenceDOF = bOverride_PathTracingEnableReferenceDOF
    self.bOverride_PathTracingEnableReferenceAtmosphere = bOverride_PathTracingEnableReferenceAtmosphere
    self.bOverride_PathTracingEnableDenoiser = bOverride_PathTracingEnableDenoiser
    self.bOverride_PathTracingIncludeEmissive = bOverride_PathTracingIncludeEmissive
    self.bOverride_PathTracingIncludeDiffuse = bOverride_PathTracingIncludeDiffuse
    self.bOverride_PathTracingIncludeIndirectDiffuse = bOverride_PathTracingIncludeIndirectDiffuse
    self.bOverride_PathTracingIncludeSpecular = bOverride_PathTracingIncludeSpecular
    self.bOverride_PathTracingIncludeIndirectSpecular = bOverride_PathTracingIncludeIndirectSpecular
    self.bOverride_PathTracingIncludeVolume = bOverride_PathTracingIncludeVolume
    self.bOverride_PathTracingIncludeIndirectVolume = bOverride_PathTracingIncludeIndirectVolume
    self.bMobileHQGaussian = bMobileHQGaussian
    self.BloomMethod = BloomMethod
    self.AutoExposureMethod = AutoExposureMethod
    self.DepthOfFieldMethod = DepthOfFieldMethod
    self.TemperatureType = TemperatureType
    self.WhiteTemp = WhiteTemp
    self.WhiteTint = WhiteTint
    self.ColorSaturation = ColorSaturation
    self.ColorContrast = ColorContrast
    self.ColorGamma = ColorGamma
    self.ColorGain = ColorGain
    self.ColorOffset = ColorOffset
    self.ColorSaturationShadows = ColorSaturationShadows
    self.ColorContrastShadows = ColorContrastShadows
    self.ColorGammaShadows = ColorGammaShadows
    self.ColorGainShadows = ColorGainShadows
    self.ColorOffsetShadows = ColorOffsetShadows
    self.ColorSaturationMidtones = ColorSaturationMidtones
    self.ColorContrastMidtones = ColorContrastMidtones
    self.ColorGammaMidtones = ColorGammaMidtones
    self.ColorGainMidtones = ColorGainMidtones
    self.ColorOffsetMidtones = ColorOffsetMidtones
    self.ColorSaturationHighlights = ColorSaturationHighlights
    self.ColorContrastHighlights = ColorContrastHighlights
    self.ColorGammaHighlights = ColorGammaHighlights
    self.ColorGainHighlights = ColorGainHighlights
    self.ColorOffsetHighlights = ColorOffsetHighlights
    self.ColorCorrectionHighlightsMin = ColorCorrectionHighlightsMin
    self.ColorCorrectionHighlightsMax = ColorCorrectionHighlightsMax
    self.ColorCorrectionShadowsMax = ColorCorrectionShadowsMax
    self.BlueCorrection = BlueCorrection
    self.ExpandGamut = ExpandGamut
    self.ToneCurveAmount = ToneCurveAmount
    self.FilmSlope = FilmSlope
    self.FilmToe = FilmToe
    self.FilmShoulder = FilmShoulder
    self.FilmBlackClip = FilmBlackClip
    self.FilmWhiteClip = FilmWhiteClip
    self.SceneColorTint = SceneColorTint
    self.SceneFringeIntensity = SceneFringeIntensity
    self.ChromaticAberrationStartOffset = ChromaticAberrationStartOffset
    self.BloomIntensity = BloomIntensity
    self.BloomThreshold = BloomThreshold
    self.BloomSizeScale = BloomSizeScale
    self.Bloom1Size = Bloom1Size
    self.Bloom2Size = Bloom2Size
    self.Bloom3Size = Bloom3Size
    self.Bloom4Size = Bloom4Size
    self.Bloom5Size = Bloom5Size
    self.Bloom6Size = Bloom6Size
    self.Bloom1Tint = Bloom1Tint
    self.Bloom2Tint = Bloom2Tint
    self.Bloom3Tint = Bloom3Tint
    self.Bloom4Tint = Bloom4Tint
    self.Bloom5Tint = Bloom5Tint
    self.Bloom6Tint = Bloom6Tint
    self.BloomConvolutionScatterDispersion = BloomConvolutionScatterDispersion
    self.BloomConvolutionSize = BloomConvolutionSize
    self.BloomConvolutionTexture = BloomConvolutionTexture
    self.BloomConvolutionCenterUV = BloomConvolutionCenterUV
    self.BloomConvolutionPreFilter = BloomConvolutionPreFilter
    self.BloomConvolutionPreFilterMin = BloomConvolutionPreFilterMin
    self.BloomConvolutionPreFilterMax = BloomConvolutionPreFilterMax
    self.BloomConvolutionPreFilterMult = BloomConvolutionPreFilterMult
    self.BloomConvolutionBufferScale = BloomConvolutionBufferScale
    self.BloomDirtMask = BloomDirtMask
    self.BloomDirtMaskIntensity = BloomDirtMaskIntensity
    self.BloomDirtMaskTint = BloomDirtMaskTint
    self.DynamicGlobalIlluminationMethod = DynamicGlobalIlluminationMethod
    self.IndirectLightingColor = IndirectLightingColor
    self.IndirectLightingIntensity = IndirectLightingIntensity
    self.LumenRayLightingMode = LumenRayLightingMode
    self.LumenSceneLightingQuality = LumenSceneLightingQuality
    self.LumenSceneDetail = LumenSceneDetail
    self.LumenSceneViewDistance = LumenSceneViewDistance
    self.LumenSceneLightingUpdateSpeed = LumenSceneLightingUpdateSpeed
    self.LumenFinalGatherQuality = LumenFinalGatherQuality
    self.LumenFinalGatherLightingUpdateSpeed = LumenFinalGatherLightingUpdateSpeed
    self.LumenFinalGatherScreenTraces = LumenFinalGatherScreenTraces
    self.LumenMaxTraceDistance = LumenMaxTraceDistance
    self.LumenDiffuseColorBoost = LumenDiffuseColorBoost
    self.LumenSkylightLeaking = LumenSkylightLeaking
    self.LumenSkylightLeakingTint = LumenSkylightLeakingTint
    self.LumenFullSkylightLeakingDistance = LumenFullSkylightLeakingDistance
    self.LumenSurfaceCacheResolution = LumenSurfaceCacheResolution
    self.ReflectionMethod = ReflectionMethod
    self.ReflectionsType = ReflectionsType
    self.LumenReflectionQuality = LumenReflectionQuality
    self.LumenReflectionsScreenTraces = LumenReflectionsScreenTraces
    self.LumenFrontLayerTranslucencyReflections = LumenFrontLayerTranslucencyReflections
    self.LumenMaxRoughnessToTraceReflections = LumenMaxRoughnessToTraceReflections
    self.LumenMaxReflectionBounces = LumenMaxReflectionBounces
    self.LumenMaxRefractionBounces = LumenMaxRefractionBounces
    self.ScreenSpaceReflectionIntensity = ScreenSpaceReflectionIntensity
    self.ScreenSpaceReflectionQuality = ScreenSpaceReflectionQuality
    self.ScreenSpaceReflectionMaxRoughness = ScreenSpaceReflectionMaxRoughness
    self.bMegaLights = bMegaLights
    self.AmbientCubemapTint = AmbientCubemapTint
    self.AmbientCubemapIntensity = AmbientCubemapIntensity
    self.AmbientCubemap = AmbientCubemap
    self.CameraShutterSpeed = CameraShutterSpeed
    self.CameraISO = CameraISO
    self.DepthOfFieldFstop = DepthOfFieldFstop
    self.DepthOfFieldMinFstop = DepthOfFieldMinFstop
    self.DepthOfFieldBladeCount = DepthOfFieldBladeCount
    self.AutoExposureBias = AutoExposureBias
    self.AutoExposureBiasBackup = AutoExposureBiasBackup
    self.bOverride_AutoExposureBiasBackup = bOverride_AutoExposureBiasBackup
    self.AutoExposureApplyPhysicalCameraExposure = AutoExposureApplyPhysicalCameraExposure
    self.AutoExposureBiasCurve = AutoExposureBiasCurve
    self.AutoExposureMeterMask = AutoExposureMeterMask
    self.AutoExposureLowPercent = AutoExposureLowPercent
    self.AutoExposureHighPercent = AutoExposureHighPercent
    self.AutoExposureMinBrightness = AutoExposureMinBrightness
    self.AutoExposureMaxBrightness = AutoExposureMaxBrightness
    self.AutoExposureSpeedUp = AutoExposureSpeedUp
    self.AutoExposureSpeedDown = AutoExposureSpeedDown
    self.HistogramLogMin = HistogramLogMin
    self.HistogramLogMax = HistogramLogMax
    self.AutoExposureCalibrationConstant = AutoExposureCalibrationConstant
    self.LocalExposureMethod = LocalExposureMethod
    self.LocalExposureContrastScale = LocalExposureContrastScale
    self.LocalExposureHighlightContrastScale = LocalExposureHighlightContrastScale
    self.LocalExposureShadowContrastScale = LocalExposureShadowContrastScale
    self.LocalExposureHighlightContrastCurve = LocalExposureHighlightContrastCurve
    self.LocalExposureShadowContrastCurve = LocalExposureShadowContrastCurve
    self.LocalExposureHighlightThreshold = LocalExposureHighlightThreshold
    self.LocalExposureShadowThreshold = LocalExposureShadowThreshold
    self.LocalExposureDetailStrength = LocalExposureDetailStrength
    self.LocalExposureBlurredLuminanceBlend = LocalExposureBlurredLuminanceBlend
    self.LocalExposureBlurredLuminanceKernelSizePercent = LocalExposureBlurredLuminanceKernelSizePercent
    self.LocalExposureHighlightThresholdStrength = LocalExposureHighlightThresholdStrength
    self.LocalExposureShadowThresholdStrength = LocalExposureShadowThresholdStrength
    self.LocalExposureMiddleGreyBias = LocalExposureMiddleGreyBias
    self.LensFlareIntensity = LensFlareIntensity
    self.LensFlareTint = LensFlareTint
    self.LensFlareBokehSize = LensFlareBokehSize
    self.LensFlareThreshold = LensFlareThreshold
    self.LensFlareBokehShape = LensFlareBokehShape
    self.LensFlareTints = LensFlareTints
    self.VignetteIntensity = VignetteIntensity
    self.Sharpen = Sharpen
    self.GrainJitter = GrainJitter
    self.GrainIntensity = GrainIntensity
    self.FilmGrainIntensity = FilmGrainIntensity
    self.FilmGrainIntensityShadows = FilmGrainIntensityShadows
    self.FilmGrainIntensityMidtones = FilmGrainIntensityMidtones
    self.FilmGrainIntensityHighlights = FilmGrainIntensityHighlights
    self.FilmGrainShadowsMax = FilmGrainShadowsMax
    self.FilmGrainHighlightsMin = FilmGrainHighlightsMin
    self.FilmGrainHighlightsMax = FilmGrainHighlightsMax
    self.FilmGrainTexelSize = FilmGrainTexelSize
    self.FilmGrainTexture = FilmGrainTexture
    self.AmbientOcclusionIntensity = AmbientOcclusionIntensity
    self.AmbientOcclusionStaticFraction = AmbientOcclusionStaticFraction
    self.AmbientOcclusionRadius = AmbientOcclusionRadius
    self.AmbientOcclusionRadiusInWS = AmbientOcclusionRadiusInWS
    self.AmbientOcclusionFadeDistance = AmbientOcclusionFadeDistance
    self.AmbientOcclusionFadeRadius = AmbientOcclusionFadeRadius
    self.AmbientOcclusionDistance = AmbientOcclusionDistance
    self.AmbientOcclusionPower = AmbientOcclusionPower
    self.AmbientOcclusionBias = AmbientOcclusionBias
    self.AmbientOcclusionQuality = AmbientOcclusionQuality
    self.AmbientOcclusionMipBlend = AmbientOcclusionMipBlend
    self.AmbientOcclusionMipScale = AmbientOcclusionMipScale
    self.AmbientOcclusionMipThreshold = AmbientOcclusionMipThreshold
    self.AmbientOcclusionTemporalBlendWeight = AmbientOcclusionTemporalBlendWeight
    self.RayTracingAO = RayTracingAO
    self.RayTracingAOSamplesPerPixel = RayTracingAOSamplesPerPixel
    self.RayTracingAOIntensity = RayTracingAOIntensity
    self.RayTracingAORadius = RayTracingAORadius
    self.ColorGradingIntensity = ColorGradingIntensity
    self.ColorGradingLUT = ColorGradingLUT
    self.DepthOfFieldSensorWidth = DepthOfFieldSensorWidth
    self.DepthOfFieldSqueezeFactor = DepthOfFieldSqueezeFactor
    self.DepthOfFieldFocalDistance = DepthOfFieldFocalDistance
    self.DepthOfFieldDepthBlurAmount = DepthOfFieldDepthBlurAmount
    self.DepthOfFieldDepthBlurRadius = DepthOfFieldDepthBlurRadius
    self.DepthOfFieldUseHairDepth = DepthOfFieldUseHairDepth
    self.DepthOfFieldPetzvalBokeh = DepthOfFieldPetzvalBokeh
    self.DepthOfFieldPetzvalBokehFalloff = DepthOfFieldPetzvalBokehFalloff
    self.DepthOfFieldPetzvalExclusionBoxExtents = DepthOfFieldPetzvalExclusionBoxExtents
    self.DepthOfFieldPetzvalExclusionBoxRadius = DepthOfFieldPetzvalExclusionBoxRadius
    self.DepthOfFieldAspectRatioScalar = DepthOfFieldAspectRatioScalar
    self.DepthOfFieldBarrelRadius = DepthOfFieldBarrelRadius
    self.DepthOfFieldBarrelLength = DepthOfFieldBarrelLength
    self.DepthOfFieldMatteBoxFlags = DepthOfFieldMatteBoxFlags
    self.DepthOfFieldFocalRegion = DepthOfFieldFocalRegion
    self.DepthOfFieldNearTransitionRegion = DepthOfFieldNearTransitionRegion
    self.DepthOfFieldFarTransitionRegion = DepthOfFieldFarTransitionRegion
    self.DepthOfFieldScale = DepthOfFieldScale
    self.DepthOfFieldNearBlurSize = DepthOfFieldNearBlurSize
    self.DepthOfFieldFarBlurSize = DepthOfFieldFarBlurSize
    self.DepthOfFieldOcclusion = DepthOfFieldOcclusion
    self.DepthOfFieldSkyFocusDistance = DepthOfFieldSkyFocusDistance
    self.DepthOfFieldVignetteSize = DepthOfFieldVignetteSize
    self.MotionBlurAmount = MotionBlurAmount
    self.MotionBlurMax = MotionBlurMax
    self.MotionBlurTargetFPS = MotionBlurTargetFPS
    self.MotionBlurPerObjectSize = MotionBlurPerObjectSize
    self.LPVIntensity = LPVIntensity
    self.LPVVplInjectionBias = LPVVplInjectionBias
    self.LPVSize = LPVSize
    self.LPVSecondaryOcclusionIntensity = LPVSecondaryOcclusionIntensity
    self.LPVSecondaryBounceIntensity = LPVSecondaryBounceIntensity
    self.LPVGeometryVolumeBias = LPVGeometryVolumeBias
    self.LPVEmissiveInjectionIntensity = LPVEmissiveInjectionIntensity
    self.LPVDirectionalOcclusionIntensity = LPVDirectionalOcclusionIntensity
    self.LPVDirectionalOcclusionRadius = LPVDirectionalOcclusionRadius
    self.LPVDiffuseOcclusionExponent = LPVDiffuseOcclusionExponent
    self.LPVSpecularOcclusionExponent = LPVSpecularOcclusionExponent
    self.LPVDiffuseOcclusionIntensity = LPVDiffuseOcclusionIntensity
    self.LPVSpecularOcclusionIntensity = LPVSpecularOcclusionIntensity
    self.TranslucencyType = TranslucencyType
    self.RayTracingTranslucencyMaxRoughness = RayTracingTranslucencyMaxRoughness
    self.RayTracingTranslucencyRefractionRays = RayTracingTranslucencyRefractionRays
    self.RayTracingTranslucencySamplesPerPixel = RayTracingTranslucencySamplesPerPixel
    self.RayTracingTranslucencyMaxPrimaryHitEvents = RayTracingTranslucencyMaxPrimaryHitEvents
    self.RayTracingTranslucencyMaxSecondaryHitEvents = RayTracingTranslucencyMaxSecondaryHitEvents
    self.RayTracingTranslucencyShadows = RayTracingTranslucencyShadows
    self.RayTracingTranslucencyRefraction = RayTracingTranslucencyRefraction
    self.RayTracingTranslucencyUseRayTracedRefraction = RayTracingTranslucencyUseRayTracedRefraction
    self.PathTracingMaxBounces = PathTracingMaxBounces
    self.PathTracingSamplesPerPixel = PathTracingSamplesPerPixel
    self.PathTracingMaxPathIntensity = PathTracingMaxPathIntensity
    self.PathTracingEnableEmissiveMaterials = PathTracingEnableEmissiveMaterials
    self.PathTracingEnableReferenceDOF = PathTracingEnableReferenceDOF
    self.PathTracingEnableReferenceAtmosphere = PathTracingEnableReferenceAtmosphere
    self.PathTracingEnableDenoiser = PathTracingEnableDenoiser
    self.PathTracingIncludeEmissive = PathTracingIncludeEmissive
    self.PathTracingIncludeDiffuse = PathTracingIncludeDiffuse
    self.PathTracingIncludeIndirectDiffuse = PathTracingIncludeIndirectDiffuse
    self.PathTracingIncludeSpecular = PathTracingIncludeSpecular
    self.PathTracingIncludeIndirectSpecular = PathTracingIncludeIndirectSpecular
    self.PathTracingIncludeVolume = PathTracingIncludeVolume
    self.PathTracingIncludeIndirectVolume = PathTracingIncludeIndirectVolume
    self.LPVFadeRange = LPVFadeRange
    self.LPVDirectionalOcclusionFadeRange = LPVDirectionalOcclusionFadeRange
    self.ScreenPercentage = ScreenPercentage
    self.UserFlags = UserFlags
    self.WeightedBlendables = WeightedBlendables
    self.PreviewBlendable = PreviewBlendable
    self.Blendables = Blendables
    return self
end

return PostProcessSettings
