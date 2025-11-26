---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SoundConcurrencySettings
---Sound Concurrency Settings
---
--- Properties
---
---The max number of allowable concurrent active voices for voices playing in this concurrency group.
---@field MaxCount integer
---Whether or not to limit the concurrency to per sound owner (i.e. the actor that plays the sound). If the sound doesn't have an owner, it falls back to global concurrency.
---@field bLimitToOwner boolean
---Whether or not volume scaling can recover volume ducking behavior when concurrency group sounds stop (default scale mode only).
---@field bVolumeScaleCanRelease boolean
---Which concurrency resolution policy to use if max voice count is reached.
---@field ResolutionRule integer
---Amount of time to wait (in seconds) between different sounds which play with this concurrency. Sounds rejected from this will ignore virtualization settings.
---@field RetriggerTime number
---Ducking factor to apply per older voice instance (generation), which compounds based on scaling mode
---and (optionally) revives them as they stop according to the provided attack/release times.
---Note: This is not applied until after StopQuietest rules are evaluated, in order to avoid thrashing sounds.
---AppliedVolumeScale = Math.Pow(DuckingScale, VoiceGeneration)
---@field VolumeScale number
---Volume Scale mode designating how to scale voice volume based on number of member sounds active in group.
---@field VolumeScaleMode EConcurrencyVolumeScaleMode
---Time taken to apply duck using volume scalar.
---@field VolumeScaleAttackTime number
---Time taken to recover volume scalar duck.
---@field VolumeScaleReleaseTime number
---Time taken to fade out if voice is evicted or culled due to another voice in the group starting.
---@field VoiceStealReleaseTime number
local SoundConcurrencySettings = {}

--- Constructor
---@return SoundConcurrencySettings
---@param MaxCount integer
---@param bLimitToOwner boolean
---@param bVolumeScaleCanRelease boolean
---@param ResolutionRule integer
---@param RetriggerTime number
---@param VolumeScale number
---@param VolumeScaleMode EConcurrencyVolumeScaleMode
---@param VolumeScaleAttackTime number
---@param VolumeScaleReleaseTime number
---@param VoiceStealReleaseTime number
function SoundConcurrencySettings.new(MaxCount, bLimitToOwner, bVolumeScaleCanRelease, ResolutionRule, RetriggerTime, VolumeScale, VolumeScaleMode, VolumeScaleAttackTime, VolumeScaleReleaseTime, VoiceStealReleaseTime)
    local self = {}
    self.MaxCount = MaxCount
    self.bLimitToOwner = bLimitToOwner
    self.bVolumeScaleCanRelease = bVolumeScaleCanRelease
    self.ResolutionRule = ResolutionRule
    self.RetriggerTime = RetriggerTime
    self.VolumeScale = VolumeScale
    self.VolumeScaleMode = VolumeScaleMode
    self.VolumeScaleAttackTime = VolumeScaleAttackTime
    self.VolumeScaleReleaseTime = VolumeScaleReleaseTime
    self.VoiceStealReleaseTime = VoiceStealReleaseTime
    return self
end

return SoundConcurrencySettings
