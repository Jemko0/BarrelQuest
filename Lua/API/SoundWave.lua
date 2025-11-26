---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoundWave : SoundBase
---Sound Wave
---
--- Properties
---
---@field StreamingPriority integer
---Determines the max sample rate to use if the platform enables "Resampling For Device" in project settings.
---     For example, if the platform enables Resampling For Device and specifies 32000 for High, then setting High here will
---     force the sound wave to be _at most_ 32000. Does nothing if Resampling For Device is disabled.
---@field SampleRateQuality ESoundwaveSampleRateSettings
---@field SoundGroup integer
---If set, when played directly (not through a sound cue) the wave will be played looping.
---@field bLooping boolean
---Here for legacy code.
---@field bStreaming boolean
---Specify a sound to use for the baked analysis. Will default to this USoundWave if not set.
---@field OverrideSoundToUseForAnalysis SoundWave
---Whether or not we should treat the sound wave used for analysis (this or the override) as looping while performing analysis.
---A looping sound may include the end of the file for inclusion in analysis for envelope and FFT analysis.
---@field TreatFileAsLoopingForAnalysis boolean
---Whether or not to enable cook-time baked FFT analysis.
---@field bEnableBakedFFTAnalysis boolean
---Whether or not to enable cook-time amplitude envelope analysis.
---@field bEnableAmplitudeEnvelopeAnalysis boolean
---The FFT window size to use for fft analysis.
---@field FFTSize ESoundWaveFFTSize
---How many audio frames analyze at a time.
---@field FFTAnalysisFrameSize integer
---Attack time in milliseconds of the spectral envelope follower.
---@field FFTAnalysisAttackTime integer
---Release time in milliseconds of the spectral envelope follower.
---@field FFTAnalysisReleaseTime integer
---How many audio frames to average a new envelope value. Larger values use less memory for audio envelope data but will result in lower envelope accuracy.
---@field EnvelopeFollowerFrameSize integer
---The attack time in milliseconds. Describes how quickly the envelope analyzer responds to increasing amplitudes.
---@field EnvelopeFollowerAttackTime integer
---The release time in milliseconds. Describes how quickly the envelope analyzer responds to decreasing amplitudes.
---@field EnvelopeFollowerReleaseTime integer
---Modulation Settings
---@field ModulationSettings SoundModulationDefaultRoutingSettings
---The frequencies (in hz) to analyze when doing baked FFT analysis.
---@field FrequenciesToAnalyze number[]
---The cooked spectral time data.
---@field CookedSpectralTimeData SoundWaveSpectralTimeData[]
---The cooked cooked envelope data.
---@field CookedEnvelopeTimeData SoundWaveEnvelopeTimeData[]
---Please use size of First Chunk in Seconds.
---@field InitialChunkSize integer
---If set to true if this sound is considered to contain mature/adult content.
---@field bMature boolean
---If set to true will disable automatic generation of line breaks - use if the subtitles have been split manually.
---@field bManualWordWrap boolean
---If set to true the subtitles display as a sequence of single lines as opposed to multiline.
---@field bSingleLine boolean
---@field bVirtualizeWhenSilent boolean
---Whether or not this source is ambisonics file format. If set, sound always uses the
---'Master Ambisonics Submix' as set in the 'Audio' category of Project Settings'
---and ignores submix if provided locally or in the referenced SoundClass.
---@field bIsAmbisonics boolean
---Specifies how and when compressed audio data is loaded for asset if stream caching is enabled.
---@field LoadingBehavior ESoundWaveLoadingBehavior
---How much audio to add to First Audio Chunk (in seconds)
---@field SizeOfFirstAudioChunkInSeconds PerPlatformFloat
---A localized version of the text that is actually spoken phonetically in the audio.
---@field SpokenText string
---The priority of the subtitle.
---@field SubtitlePriority number
---Playback volume of sound 0 to 1 - Default is 1.0.
---@field Volume number
---Playback pitch for sound.
---@field Pitch number
---Number of channels of multichannel data; 1 or 2 for regular mono and stereo files
---@field NumChannels integer
---Offsets into the bulk data for the source wav data
---@field ChannelOffsets integer[]
---Sizes of the bulk data for the source wav data
---@field ChannelSizes integer[]
---Cooked sample rate of the asset. Can be modified by sample rate override.
---@field SampleRate integer
---Sample rate of the imported sound wave.
---@field ImportedSampleRate integer
---Cue point data parsed from the .wav file. Contains "Loop Regions" as cue points as well!
---@field CuePoints SoundWaveCuePoint[]
---Dictates whether to use the CuePoints and Loop Regions from the .wav file or from the waveform editor
---    Marker transformations during playback.
---@field CuePointOrigin ESoundWaveCuePointOrigin
---Subtitle cues.
---@field Subtitles SubtitleCue[]
---Provides contextual information for the sound to the translator.
---@field Comment string
---Information about the time-code from import, if available.
---@field TimecodeInfo SoundWaveTimecodeInfo
---@field SourceFilePath string
---@field SourceFileTimestamp string
---@field AssetImportData AssetImportData
---Curves associated with this sound wave
---@field Curves CurveTable
---Hold a reference to our internal curve so we can switch back to it if we want to
---@field InternalCurves CurveTable
---If enabled, this wave may be streamed from the cloud using the Opus format. Loading behavior must NOT be `Force Inline`. Requires a suitable support plugin to be installed.
---@field bEnableCloudStreaming boolean
---Optionally disables cloud streaming per platform
---@field PlatformSettings table<Guid, SoundWaveCloudStreamingPlatformSettings>
---Waveform edits to be applied to this SoundWave on cook (editing transformations will trigger a cook)
---Transformations is a TArray because changing it to TSet will delete user data
---@field Transformations WaveformTransformationBase[]
local SoundWave = {}

--- Methods
---Procedurally set the compression type.
---@param InSoundAssetCompressionType ESoundAssetCompressionType
---@param bMarkDirty boolean
---@return nil
function SoundWave.SetSoundAssetCompressionType(InSoundAssetCompressionType, bMarkDirty) end

---Returns the sound's asset compression type.
---@return ESoundAssetCompressionType
function SoundWave.GetSoundAssetCompressionType() end

---Filters for the cue points that _are_ loop regions and returns those as a new array
---@return SoundWaveCuePoint[]
function SoundWave.GetLoopRegions() end

---Filters for the cue points that are _not_ loop regions and returns those as a new array
---@return SoundWaveCuePoint[]
function SoundWave.GetCuePoints() end

return SoundWave
