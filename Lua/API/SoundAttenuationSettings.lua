---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoundAttenuationSettings
---The settings for attenuating.
---
--- Properties
---
---Allows distance-based volume attenuation.
---@field bAttenuate boolean
---Allows the source to be 3D spatialized.
---@field bSpatialize boolean
---Allows simulation of air absorption by applying a filter with a cutoff frequency as a function of distance.
---@field bAttenuateWithLPF boolean
---Enable listener focus-based adjustments.
---@field bEnableListenerFocus boolean
---Enables focus interpolation to smooth transition in and and of focus.
---@field bEnableFocusInterpolation boolean
---Enables realtime occlusion tracing.
---@field bEnableOcclusion boolean
---Enables tracing against complex collision when doing occlusion traces.
---@field bUseComplexCollisionForOcclusion boolean
---Enables adjusting reverb sends based on distance.
---@field bEnableReverbSend boolean
---Enables attenuation of sound priority based off distance.
---@field bEnablePriorityAttenuation boolean
---Enables applying a -6 dB attenuation to stereo assets which are 3d spatialized. Avoids clipping when assets have spread of 0.0 due to channel summing.
---@field bApplyNormalizationToStereoSounds boolean
---Enables applying a log scale to frequency values (so frequency sweeping is perceptually linear).
---@field bEnableLogFrequencyScaling boolean
---Enables submix sends based on distance.
---@field bEnableSubmixSends boolean
---Enables overriding WaveInstance data using source data override plugin
---@field bEnableSourceDataOverride boolean
---Enables/Disables AudioLink on all sources using this attenuation
---@field bEnableSendToAudioLink boolean
---What method we use to spatialize the sound.
---@field SpatializationAlgorithm integer
---AudioLink Setting Overrides
---@field AudioLinkSettingsOverride AudioLinkSettingsAbstract
---What min radius to use to swap to non-binaural audio when a sound starts playing.
---@field BinauralRadius number
---The normalized custom curve to use for the air absorption lowpass frequency values. Does a mapping from defined distance values (x-axis) and defined frequency values (y-axis)
---@field CustomLowpassAirAbsorptionCurve RuntimeFloatCurve
---The normalized custom curve to use for the air absorption highpass frequency values. Does a mapping from defined distance values (x-axis) and defined frequency values (y-axis)
---@field CustomHighpassAirAbsorptionCurve RuntimeFloatCurve
---What method to use to map distance values to frequency absorption values.
---@field AbsorptionMethod EAirAbsorptionMethod
---Which trace channel to use for audio occlusion checks.
---@field OcclusionTraceChannel integer
---What method to use to control master reverb sends
---@field ReverbSendMethod EReverbSendMethod
---What method to use to control priority attenuation
---@field PriorityAttenuationMethod EPriorityAttenuationMethod
---@field DistanceType integer
---@field OmniRadius number
---The distance below which a sound begins to linearly interpolate towards being non-spatialized (2D). See "Non Spatialized Radius End" to define the end of the interpolation and the "Non Spatialized Radius Mode" for the mode of the interpolation. Note: this does not apply when using a 3rd party binaural plugin (audio will remain spatialized).
---@field NonSpatializedRadiusStart number
---The distance below which a sound is fully non-spatialized (2D). See "Non Spatialized Radius Start" to define the start of the interpolation and the "Non Spatialized Radius Mode" for the mode of the interpolation.
---@field NonSpatializedRadiusEnd number
---Defines how to interpolate a 3D sound towards a 2D sound when using the non-spatialized radius start and end properties.
---@field NonSpatializedRadiusMode ENonSpatializedRadiusSpeakerMapMode
---The world-space distance between left and right stereo channels when stereo assets are 3D spatialized.
---@field StereoSpread number
---@field SpatializationPluginSettings SpatializationPluginSourceSettingsBase
---@field RadiusMin number
---@field RadiusMax number
---The distance min range at which to apply an absorption LPF filter.
---@field LPFRadiusMin number
---The max distance range at which to apply an absorption LPF filter. Absorption freq cutoff interpolates between filter frequency ranges between these distance values.
---@field LPFRadiusMax number
---The range of the cutoff frequency (in Hz) of the lowpass absorption filter.
---@field LPFFrequencyAtMin number
---The range of the cutoff frequency (in Hz) of the lowpass absorption filter.
---@field LPFFrequencyAtMax number
---The range of the cutoff frequency (in Hz) of the highpass absorption filter.
---@field HPFFrequencyAtMin number
---The range of the cutoff frequency (in Hz) of the highpass absorption filter.
---@field HPFFrequencyAtMax number
---Azimuth angle (in degrees) relative to the listener forward vector which defines the focus region of sounds. Sounds playing at an angle less than this will be in focus.
---@field FocusAzimuth number
---Azimuth angle (in degrees) relative to the listener forward vector which defines the non-focus region of sounds. Sounds playing at an angle greater than this will be out of focus.
---@field NonFocusAzimuth number
---Amount to scale the distance calculation of sounds that are in-focus. Can be used to make in-focus sounds appear to be closer or further away than they actually are.
---@field FocusDistanceScale number
---Amount to scale the distance calculation of sounds that are not in-focus. Can be used to make in-focus sounds appear to be closer or further away than they actually are.
---@field NonFocusDistanceScale number
---Amount to scale the priority of sounds that are in focus. Can be used to boost the priority of sounds that are in focus.
---@field FocusPriorityScale number
---Amount to scale the priority of sounds that are not in-focus. Can be used to reduce the priority of sounds that are not in focus.
---@field NonFocusPriorityScale number
---Amount to attenuate sounds that are in focus. Can be overridden at the sound-level.
---@field FocusVolumeAttenuation number
---Amount to attenuate sounds that are not in focus. Can be overridden at the sound-level.
---@field NonFocusVolumeAttenuation number
---Scalar used to increase interpolation speed upwards to the target Focus value
---@field FocusAttackInterpSpeed number
---Scalar used to increase interpolation speed downwards to the target Focus value
---@field FocusReleaseInterpSpeed number
---The low pass filter frequency (in Hz) to apply if the sound playing in this audio component is occluded. This will override the frequency set in LowPassFilterFrequency. A frequency of 0.0 is the device sample rate and will bypass the filter.
---@field OcclusionLowPassFilterFrequency number
---The amount of volume attenuation to apply to sounds which are occluded.
---@field OcclusionVolumeAttenuation number
---The amount of time in seconds to interpolate to the target OcclusionLowPassFilterFrequency when a sound is occluded.
---@field OcclusionInterpolationTime number
---@field OcclusionPluginSettings OcclusionPluginSourceSettingsBase
---@field ReverbPluginSettings ReverbPluginSourceSettingsBase
---The amount to send to master reverb when sound is located at a distance equal to value specified in the reverb min send distance.
---@field ReverbWetLevelMin number
---The amount to send to master reverb when sound is located at a distance equal to value specified in the reverb max send distance.
---@field ReverbWetLevelMax number
---The min distance to send to the master reverb.
---@field ReverbDistanceMin number
---The max distance to send to the master reverb.
---@field ReverbDistanceMax number
---The manual master reverb send level to use. Doesn't change as a function of distance.
---@field ManualReverbSendLevel number
---Interpolated value to scale priority against when the sound is at the minimum priority attenuation distance from the closest listener.
---@field PriorityAttenuationMin number
---Interpolated value to scale priority against when the sound is at the maximum priority attenuation distance from the closest listener.
---@field PriorityAttenuationMax number
---The min distance to attenuate priority.
---@field PriorityAttenuationDistanceMin number
---The max distance to attenuate priority.
---@field PriorityAttenuationDistanceMax number
---Static priority scalar to use (doesn't change as a function of distance).
---@field ManualPriorityAttenuation number
---The custom reverb send curve to use for distance-based send level.
---@field CustomReverbSendCurve RuntimeFloatCurve
---Set of submix send settings to use to send audio to submixes as a function of distance.
---@field SubmixSendSettings AttenuationSubmixSendSettings[]
---The custom curve to use for distance-based priority attenuation.
---@field CustomPriorityAttenuationCurve RuntimeFloatCurve
---Sound attenuation plugin settings to use with sounds that play with this attenuation setting.
---@field PluginSettings SoundAttenuationPluginSettings
---The type of attenuation as a function of distance to use.
---@field DistanceAlgorithm EAttenuationDistanceModel
---The shape of the non-custom attenuation method.
---@field AttenuationShape integer
---Whether to continue attenuating, go silent, or hold last volume value when beyond falloff bounds and
---'Attenuation At Max (dB)' is set to a value greater than -60dB.
---(Only for 'Natural Sound' Distance Algorithm). */
---@field FalloffMode ENaturalSoundFalloffMode
---The attenuation volume at the falloff distance in decibels (Only for 'Natural Sound' Distance Algorithm).
---@field dBAttenuationAtMax number
---The dimensions to use for the attenuation shape. Interpretation of the values differ per shape.
---         Sphere  - X is Sphere Radius. Y and Z are unused
---         Capsule - X is Capsule Half Height, Y is Capsule Radius, Z is unused
---         Box     - X, Y, and Z are the Box's dimensions
---         Cone    - X is Cone Radius, Y is Cone Angle, Z is Cone Falloff Angle
---@field AttenuationShapeExtents Vector
---The distance back from the sound's origin to begin the cone when using the cone attenuation shape.
---@field ConeOffset number
---The distance over which volume attenuation occurs.
---@field FalloffDistance number
---An optional attenuation radius (sphere) that extends from the cone origin.
---@field ConeSphereRadius number
---The distance over which volume attenuation occurs for the optional sphere shape.
---@field ConeSphereFalloffDistance number
---The custom volume attenuation curve to use.
---@field CustomAttenuationCurve RuntimeFloatCurve
local SoundAttenuationSettings = {}

--- Constructor
---@return SoundAttenuationSettings
---@param bAttenuate boolean
---@param bSpatialize boolean
---@param bAttenuateWithLPF boolean
---@param bEnableListenerFocus boolean
---@param bEnableFocusInterpolation boolean
---@param bEnableOcclusion boolean
---@param bUseComplexCollisionForOcclusion boolean
---@param bEnableReverbSend boolean
---@param bEnablePriorityAttenuation boolean
---@param bApplyNormalizationToStereoSounds boolean
---@param bEnableLogFrequencyScaling boolean
---@param bEnableSubmixSends boolean
---@param bEnableSourceDataOverride boolean
---@param bEnableSendToAudioLink boolean
---@param SpatializationAlgorithm integer
---@param AudioLinkSettingsOverride AudioLinkSettingsAbstract
---@param BinauralRadius number
---@param CustomLowpassAirAbsorptionCurve RuntimeFloatCurve
---@param CustomHighpassAirAbsorptionCurve RuntimeFloatCurve
---@param AbsorptionMethod EAirAbsorptionMethod
---@param OcclusionTraceChannel integer
---@param ReverbSendMethod EReverbSendMethod
---@param PriorityAttenuationMethod EPriorityAttenuationMethod
---@param DistanceType integer
---@param OmniRadius number
---@param NonSpatializedRadiusStart number
---@param NonSpatializedRadiusEnd number
---@param NonSpatializedRadiusMode ENonSpatializedRadiusSpeakerMapMode
---@param StereoSpread number
---@param SpatializationPluginSettings SpatializationPluginSourceSettingsBase
---@param RadiusMin number
---@param RadiusMax number
---@param LPFRadiusMin number
---@param LPFRadiusMax number
---@param LPFFrequencyAtMin number
---@param LPFFrequencyAtMax number
---@param HPFFrequencyAtMin number
---@param HPFFrequencyAtMax number
---@param FocusAzimuth number
---@param NonFocusAzimuth number
---@param FocusDistanceScale number
---@param NonFocusDistanceScale number
---@param FocusPriorityScale number
---@param NonFocusPriorityScale number
---@param FocusVolumeAttenuation number
---@param NonFocusVolumeAttenuation number
---@param FocusAttackInterpSpeed number
---@param FocusReleaseInterpSpeed number
---@param OcclusionLowPassFilterFrequency number
---@param OcclusionVolumeAttenuation number
---@param OcclusionInterpolationTime number
---@param OcclusionPluginSettings OcclusionPluginSourceSettingsBase
---@param ReverbPluginSettings ReverbPluginSourceSettingsBase
---@param ReverbWetLevelMin number
---@param ReverbWetLevelMax number
---@param ReverbDistanceMin number
---@param ReverbDistanceMax number
---@param ManualReverbSendLevel number
---@param PriorityAttenuationMin number
---@param PriorityAttenuationMax number
---@param PriorityAttenuationDistanceMin number
---@param PriorityAttenuationDistanceMax number
---@param ManualPriorityAttenuation number
---@param CustomReverbSendCurve RuntimeFloatCurve
---@param SubmixSendSettings AttenuationSubmixSendSettings[]
---@param CustomPriorityAttenuationCurve RuntimeFloatCurve
---@param PluginSettings SoundAttenuationPluginSettings
---@param DistanceAlgorithm EAttenuationDistanceModel
---@param AttenuationShape integer
---@param FalloffMode ENaturalSoundFalloffMode
---@param dBAttenuationAtMax number
---@param AttenuationShapeExtents Vector
---@param ConeOffset number
---@param FalloffDistance number
---@param ConeSphereRadius number
---@param ConeSphereFalloffDistance number
---@param CustomAttenuationCurve RuntimeFloatCurve
function SoundAttenuationSettings.new(bAttenuate, bSpatialize, bAttenuateWithLPF, bEnableListenerFocus, bEnableFocusInterpolation, bEnableOcclusion, bUseComplexCollisionForOcclusion, bEnableReverbSend, bEnablePriorityAttenuation, bApplyNormalizationToStereoSounds, bEnableLogFrequencyScaling, bEnableSubmixSends, bEnableSourceDataOverride, bEnableSendToAudioLink, SpatializationAlgorithm, AudioLinkSettingsOverride, BinauralRadius, CustomLowpassAirAbsorptionCurve, CustomHighpassAirAbsorptionCurve, AbsorptionMethod, OcclusionTraceChannel, ReverbSendMethod, PriorityAttenuationMethod, DistanceType, OmniRadius, NonSpatializedRadiusStart, NonSpatializedRadiusEnd, NonSpatializedRadiusMode, StereoSpread, SpatializationPluginSettings, RadiusMin, RadiusMax, LPFRadiusMin, LPFRadiusMax, LPFFrequencyAtMin, LPFFrequencyAtMax, HPFFrequencyAtMin, HPFFrequencyAtMax, FocusAzimuth, NonFocusAzimuth, FocusDistanceScale, NonFocusDistanceScale, FocusPriorityScale, NonFocusPriorityScale, FocusVolumeAttenuation, NonFocusVolumeAttenuation, FocusAttackInterpSpeed, FocusReleaseInterpSpeed, OcclusionLowPassFilterFrequency, OcclusionVolumeAttenuation, OcclusionInterpolationTime, OcclusionPluginSettings, ReverbPluginSettings, ReverbWetLevelMin, ReverbWetLevelMax, ReverbDistanceMin, ReverbDistanceMax, ManualReverbSendLevel, PriorityAttenuationMin, PriorityAttenuationMax, PriorityAttenuationDistanceMin, PriorityAttenuationDistanceMax, ManualPriorityAttenuation, CustomReverbSendCurve, SubmixSendSettings, CustomPriorityAttenuationCurve, PluginSettings, DistanceAlgorithm, AttenuationShape, FalloffMode, dBAttenuationAtMax, AttenuationShapeExtents, ConeOffset, FalloffDistance, ConeSphereRadius, ConeSphereFalloffDistance, CustomAttenuationCurve)
    local self = {}
    self.bAttenuate = bAttenuate
    self.bSpatialize = bSpatialize
    self.bAttenuateWithLPF = bAttenuateWithLPF
    self.bEnableListenerFocus = bEnableListenerFocus
    self.bEnableFocusInterpolation = bEnableFocusInterpolation
    self.bEnableOcclusion = bEnableOcclusion
    self.bUseComplexCollisionForOcclusion = bUseComplexCollisionForOcclusion
    self.bEnableReverbSend = bEnableReverbSend
    self.bEnablePriorityAttenuation = bEnablePriorityAttenuation
    self.bApplyNormalizationToStereoSounds = bApplyNormalizationToStereoSounds
    self.bEnableLogFrequencyScaling = bEnableLogFrequencyScaling
    self.bEnableSubmixSends = bEnableSubmixSends
    self.bEnableSourceDataOverride = bEnableSourceDataOverride
    self.bEnableSendToAudioLink = bEnableSendToAudioLink
    self.SpatializationAlgorithm = SpatializationAlgorithm
    self.AudioLinkSettingsOverride = AudioLinkSettingsOverride
    self.BinauralRadius = BinauralRadius
    self.CustomLowpassAirAbsorptionCurve = CustomLowpassAirAbsorptionCurve
    self.CustomHighpassAirAbsorptionCurve = CustomHighpassAirAbsorptionCurve
    self.AbsorptionMethod = AbsorptionMethod
    self.OcclusionTraceChannel = OcclusionTraceChannel
    self.ReverbSendMethod = ReverbSendMethod
    self.PriorityAttenuationMethod = PriorityAttenuationMethod
    self.DistanceType = DistanceType
    self.OmniRadius = OmniRadius
    self.NonSpatializedRadiusStart = NonSpatializedRadiusStart
    self.NonSpatializedRadiusEnd = NonSpatializedRadiusEnd
    self.NonSpatializedRadiusMode = NonSpatializedRadiusMode
    self.StereoSpread = StereoSpread
    self.SpatializationPluginSettings = SpatializationPluginSettings
    self.RadiusMin = RadiusMin
    self.RadiusMax = RadiusMax
    self.LPFRadiusMin = LPFRadiusMin
    self.LPFRadiusMax = LPFRadiusMax
    self.LPFFrequencyAtMin = LPFFrequencyAtMin
    self.LPFFrequencyAtMax = LPFFrequencyAtMax
    self.HPFFrequencyAtMin = HPFFrequencyAtMin
    self.HPFFrequencyAtMax = HPFFrequencyAtMax
    self.FocusAzimuth = FocusAzimuth
    self.NonFocusAzimuth = NonFocusAzimuth
    self.FocusDistanceScale = FocusDistanceScale
    self.NonFocusDistanceScale = NonFocusDistanceScale
    self.FocusPriorityScale = FocusPriorityScale
    self.NonFocusPriorityScale = NonFocusPriorityScale
    self.FocusVolumeAttenuation = FocusVolumeAttenuation
    self.NonFocusVolumeAttenuation = NonFocusVolumeAttenuation
    self.FocusAttackInterpSpeed = FocusAttackInterpSpeed
    self.FocusReleaseInterpSpeed = FocusReleaseInterpSpeed
    self.OcclusionLowPassFilterFrequency = OcclusionLowPassFilterFrequency
    self.OcclusionVolumeAttenuation = OcclusionVolumeAttenuation
    self.OcclusionInterpolationTime = OcclusionInterpolationTime
    self.OcclusionPluginSettings = OcclusionPluginSettings
    self.ReverbPluginSettings = ReverbPluginSettings
    self.ReverbWetLevelMin = ReverbWetLevelMin
    self.ReverbWetLevelMax = ReverbWetLevelMax
    self.ReverbDistanceMin = ReverbDistanceMin
    self.ReverbDistanceMax = ReverbDistanceMax
    self.ManualReverbSendLevel = ManualReverbSendLevel
    self.PriorityAttenuationMin = PriorityAttenuationMin
    self.PriorityAttenuationMax = PriorityAttenuationMax
    self.PriorityAttenuationDistanceMin = PriorityAttenuationDistanceMin
    self.PriorityAttenuationDistanceMax = PriorityAttenuationDistanceMax
    self.ManualPriorityAttenuation = ManualPriorityAttenuation
    self.CustomReverbSendCurve = CustomReverbSendCurve
    self.SubmixSendSettings = SubmixSendSettings
    self.CustomPriorityAttenuationCurve = CustomPriorityAttenuationCurve
    self.PluginSettings = PluginSettings
    self.DistanceAlgorithm = DistanceAlgorithm
    self.AttenuationShape = AttenuationShape
    self.FalloffMode = FalloffMode
    self.dBAttenuationAtMax = dBAttenuationAtMax
    self.AttenuationShapeExtents = AttenuationShapeExtents
    self.ConeOffset = ConeOffset
    self.FalloffDistance = FalloffDistance
    self.ConeSphereRadius = ConeSphereRadius
    self.ConeSphereFalloffDistance = ConeSphereFalloffDistance
    self.CustomAttenuationCurve = CustomAttenuationCurve
    return self
end

return SoundAttenuationSettings
