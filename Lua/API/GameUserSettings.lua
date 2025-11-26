---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class GameUserSettings
---Stores user settings for a game (for example graphics and sound settings), with the ability to save and load to and from a file.
---
--- Properties
---
---Whether to use VSync or not. (public to allow UI to connect to it)
---@field bUseVSync boolean
---Whether to use dynamic resolution or not. (public to allow UI to connect to it)
---@field bUseDynamicResolution boolean
---Game screen resolution width, in pixels.
---@field ResolutionSizeX integer
---Game screen resolution height, in pixels.
---@field ResolutionSizeY integer
---Game screen resolution width, in pixels.
---@field LastUserConfirmedResolutionSizeX integer
---Game screen resolution height, in pixels.
---@field LastUserConfirmedResolutionSizeY integer
---@field WindowPosX integer
---@field WindowPosY integer
---Saved window positions. Multiple instances running simultaneously can use different ones.
---@field WindowPositions IntPoint[]
---Game window fullscreen mode
---     0 = Fullscreen
---     1 = Windowed fullscreen
---     2 = Windowed
---@field FullscreenMode integer
---Last user confirmed fullscreen mode setting.
---@field LastConfirmedFullscreenMode integer
---Fullscreen mode to use when toggling between windowed and fullscreen. Same values as r.FullScreenMode.
---@field PreferredFullscreenMode integer
---All settings will be wiped and set to default if the serialized version differs from UE_GAMEUSERSETTINGS_VERSION.
---@field Version integer
---@field AudioQualityLevel integer
---@field LastConfirmedAudioQualityLevel integer
---Frame rate cap
---@field FrameRateLimit number
---Desired screen width used to calculate the resolution scale when user changes display mode
---@field DesiredScreenWidth integer
---If true, the desired screen height will be used to scale the render resolution automatically.
---@field bUseDesiredScreenHeight boolean
---Desired screen height used to calculate the resolution scale when user changes display mode
---@field DesiredScreenHeight integer
---Desired screen width used to calculate the resolution scale when user changes display mode
---@field LastUserConfirmedDesiredScreenWidth integer
---Desired screen height used to calculate the resolution scale when user changes display mode
---@field LastUserConfirmedDesiredScreenHeight integer
---Result of the last benchmark; calculated resolution to use.
---@field LastRecommendedScreenWidth number
---Result of the last benchmark; calculated resolution to use.
---@field LastRecommendedScreenHeight number
---Result of the last benchmark (CPU); -1 if there has not been a benchmark run
---@field LastCPUBenchmarkResult number
---Result of the last benchmark (GPU); -1 if there has not been a benchmark run
---@field LastGPUBenchmarkResult number
---Result of each individual sub-section of the last CPU benchmark; empty if there has not been a benchmark run
---@field LastCPUBenchmarkSteps number[]
---Result of each individual sub-section of the last GPU benchmark; empty if there has not been a benchmark run
---@field LastGPUBenchmarkSteps number[]
---Multiplier used against the last GPU benchmark
---@field LastGPUBenchmarkMultiplier number
---HDR
---@field bUseHDRDisplayOutput boolean
---HDR
---@field HDRDisplayOutputNits integer
local GameUserSettings = {}

--- Methods
---Validates and resets bad user settings to default. Deletes stale user settings file if necessary.
---@return nil
function GameUserSettings.ValidateSettings() end

---Whether the curently running system supports HDR display output
---@return boolean
function GameUserSettings.SupportsHDRDisplayOutput() end

---Sets the user setting for vsync. See UGameUserSettings::bUseVSync.
---@param bEnable boolean
---@return nil
function GameUserSettings.SetVSyncEnabled(bEnable) end

---Sets the visual effects quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetVisualEffectQuality(Value) end

---Sets the view distance quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetViewDistanceQuality(Value) end

---Set to Defaults
---@return nil
function GameUserSettings.SetToDefaults() end

---Sets the texture quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetTextureQuality(Value) end

---Sets the shadow quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetShadowQuality(Value) end

---Sets the shading quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetShadingQuality(Value) end

---Sets the user setting for game screen resolution, in pixels.
---@param Resolution IntPoint
---@return nil
function GameUserSettings.SetScreenResolution(Resolution) end

---Sets the current resolution scale
---@param NewScaleValue number
---@return nil
function GameUserSettings.SetResolutionScaleValueEx(NewScaleValue) end

---Sets the current resolution scale as a normalized 0..1 value between MinScaleValue and MaxScaleValue
---@param NewScaleNormalized number
---@return nil
function GameUserSettings.SetResolutionScaleNormalized(NewScaleNormalized) end

---Sets the reflection quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetReflectionQuality(Value) end

---Sets the post-processing quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetPostProcessingQuality(Value) end

---Changes all scalability settings at once based on a single overall quality level
---@param Value integer
---@return nil
function GameUserSettings.SetOverallScalabilityLevel(Value) end

---Sets the global illumination quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetGlobalIlluminationQuality(Value) end

---Sets the user setting for the game window fullscreen mode. See UGameUserSettings::FullscreenMode.
---@param InFullscreenMode integer
---@return nil
function GameUserSettings.SetFullscreenMode(InFullscreenMode) end

---Sets the user's frame rate limit (0 will disable frame rate limiting)
---@param NewLimit number
---@return nil
function GameUserSettings.SetFrameRateLimit(NewLimit) end

---Sets the foliage quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetFoliageQuality(Value) end

---Sets the user setting for dynamic resolution. See UGameUserSettings::bUseDynamicResolution.
---@param bEnable boolean
---@return nil
function GameUserSettings.SetDynamicResolutionEnabled(bEnable) end

---Set scalability settings to sensible fallback values, for use when the benchmark fails or potentially causes a crash
---@return nil
function GameUserSettings.SetBenchmarkFallbackValues() end

---Sets the user's audio quality level setting
---@param QualityLevel integer
---@return nil
function GameUserSettings.SetAudioQualityLevel(QualityLevel) end

---Sets the anti-aliasing quality (0..4, higher is better)
---@param Value integer
---@return nil
function GameUserSettings.SetAntiAliasingQuality(Value) end

---Save the user settings to persistent storage (automatically happens as part of ApplySettings)
---@return nil
function GameUserSettings.SaveSettings() end

---Runs the hardware benchmark and populates ScalabilityQuality as well as the last benchmark results config members, but does not apply the settings it determines. Designed to be called in conjunction with ApplyHardwareBenchmarkResults
---@param WorkScale integer
---@param CPUMultiplier number
---@param GPUMultiplier number
---@return nil
function GameUserSettings.RunHardwareBenchmark(WorkScale, CPUMultiplier, GPUMultiplier) end

---Revert video mode (fullscreenmode/resolution) back to the last user confirmed values
---@return nil
function GameUserSettings.RevertVideoMode() end

---This function resets all settings to the current system settings
---@return nil
function GameUserSettings.ResetToCurrentSettings() end

---Loads the user settings from persistent storage
---@param bForceReload boolean
---@return nil
function GameUserSettings.LoadSettings(bForceReload) end

---Returns the user setting for vsync.
---@return boolean
function GameUserSettings.IsVSyncEnabled() end

---Checks if the vsync user setting is different from current system setting
---@return boolean
function GameUserSettings.IsVSyncDirty() end

---Checks if the Screen Resolution user setting is different from current
---@return boolean
function GameUserSettings.IsScreenResolutionDirty() end

---Is HDREnabled
---@return boolean
function GameUserSettings.IsHDREnabled() end

---Checks if the FullscreenMode user setting is different from current
---@return boolean
function GameUserSettings.IsFullscreenModeDirty() end

---Returns the user setting for dynamic resolution.
---@return boolean
function GameUserSettings.IsDynamicResolutionEnabled() end

---Checks if the dynamic resolution user setting is different from current system setting
---@return boolean
function GameUserSettings.IsDynamicResolutionDirty() end

---Checks if any user settings is different from current
---@return boolean
function GameUserSettings.IsDirty() end

---Returns the visual effects quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetVisualEffectQuality() end

---Returns the view distance quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetViewDistanceQuality() end

---Returns the texture quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetTextureQuality() end

---Get Sync Interval
---@return integer
function GameUserSettings.GetSyncInterval() end

---Returns the shadow quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetShadowQuality() end

---Returns the shading quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetShadingQuality() end

---Returns the user setting for game screen resolution, in pixels.
---@return IntPoint
function GameUserSettings.GetScreenResolution() end

---Gets the current resolution scale as a normalized 0..1 value between MinScaleValue and MaxScaleValue
---@return number
function GameUserSettings.GetResolutionScaleNormalized() end

---Returns the current resolution scale and the range
---@return nil, number, number, number, number
function GameUserSettings.GetResolutionScaleInformationEx() end

---Returns the reflection quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetReflectionQuality() end

---Gets the recommended resolution quality based on LastRecommendedScreenWidth/Height and the current screen resolution
---@return number
function GameUserSettings.GetRecommendedResolutionScale() end

---Returns the user setting for game window fullscreen mode.
---@return integer
function GameUserSettings.GetPreferredFullscreenMode() end

---Returns the post-processing quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetPostProcessingQuality() end

---Returns the overall scalability level (can return -1 if the settings are custom)
---@return integer
function GameUserSettings.GetOverallScalabilityLevel() end

---Returns the last confirmed user setting for game screen resolution, in pixels.
---@return IntPoint
function GameUserSettings.GetLastConfirmedScreenResolution() end

---Returns the last confirmed user setting for game window fullscreen mode.
---@return integer
function GameUserSettings.GetLastConfirmedFullscreenMode() end

---Returns the global illumination quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetGlobalIlluminationQuality() end

---Returns the game local machine settings (resolution, windowing mode, scalability settings, etc...)
---@return GameUserSettings
function GameUserSettings.GetGameUserSettings() end

---Returns the user setting for game window fullscreen mode.
---@return integer
function GameUserSettings.GetFullscreenMode() end

---Gets the user's frame rate limit (0 indiciates the frame rate limit is disabled)
---@return number
function GameUserSettings.GetFrameRateLimit() end

---Gets the current frame pacing frame rate in fps, or 0 if none
---@return integer
function GameUserSettings.GetFramePace() end

---Returns the foliage quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetFoliageQuality() end

---Returns user's desktop resolution, in pixels.
---@return IntPoint
function GameUserSettings.GetDesktopResolution() end

---Returns the default window position when no position is set
---@return IntPoint
function GameUserSettings.GetDefaultWindowPosition() end

---Returns the default window mode when no mode is set
---@return integer
function GameUserSettings.GetDefaultWindowMode() end

---Gets the desired resolution quality based on DesiredScreenWidth/Height and the current screen resolution
---@return number
function GameUserSettings.GetDefaultResolutionScale() end

---Returns the default resolution when no resolution is set
---@return IntPoint
function GameUserSettings.GetDefaultResolution() end

---Returns 0 if HDR isn't supported or is turned off
---@return integer
function GameUserSettings.GetCurrentHDRDisplayNits() end

---Returns the user's audio quality level setting
---@return integer
function GameUserSettings.GetAudioQualityLevel() end

---Returns the anti-aliasing quality (0..4, higher is better)
---@return integer
function GameUserSettings.GetAntiAliasingQuality() end

---Enables or disables HDR display output. Can be called again to change the desired nit level
---@param bEnable boolean
---@param DisplayNits integer
---@return nil
function GameUserSettings.EnableHDRDisplayOutput(bEnable, DisplayNits) end

---Mark current video mode settings (fullscreenmode/resolution) as being confirmed by the user
---@return nil
function GameUserSettings.ConfirmVideoMode() end

---Applies all current user settings to the game and saves to permanent storage (e.g. file), optionally checking for command line overrides.
---@param bCheckForCommandLineOverrides boolean
---@return nil
function GameUserSettings.ApplySettings(bCheckForCommandLineOverrides) end

---Apply Resolution Settings
---@param bCheckForCommandLineOverrides boolean
---@return nil
function GameUserSettings.ApplyResolutionSettings(bCheckForCommandLineOverrides) end

---Apply Non Resolution Settings
---@return nil
function GameUserSettings.ApplyNonResolutionSettings() end

---Applies the settings stored in ScalabilityQuality and saves settings
---@return nil
function GameUserSettings.ApplyHardwareBenchmarkResults() end

return GameUserSettings
