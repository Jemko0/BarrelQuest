---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class MusicManager_C : Actor
---Music Manager
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field RandomSong AudioComponent
---@field Audio AudioComponent
---@field DefaultSceneRoot SceneComponent
---@field Check Vector[]
---@field CollectedSurfaces integer[]
---@field OwnerCharacter BarrelCharacter_C
---@field CurrentlyPlaying AudioComponent
---@field CurrentFading AudioComponent
---@field BoxSize number
---@field Intensity1 any[]
---@field Intensity2 any[]
---@field DynamicIntensityTracks table<string, DynamicIntensityTrackStruct>
---@field CurrentDynamicTrack table<integer, AudioComponent>
---@field TrackStart integer
---@field CurrentTrack string
---@field stopAll boolean
local MusicManager_C = {}

--- Methods
---Load Dynamic Tracks
---@return nil
function MusicManager_C.LoadDynamicTracks() end

---Adjust Global Dynamic Track Volume
---@param RiseFall boolean
---@return nil
function MusicManager_C.AdjustGlobalDynamicTrackVolume(RiseFall) end

---Tick Dynamic Intensity Song
---@return nil
function MusicManager_C.TickDynamicIntensitySong() end

---Force Play
---@param song integer
---@param intensity boolean
---@return nil
function MusicManager_C.ForcePlay(song, intensity) end

---Get Random Song
---@return nil
function MusicManager_C.GetRandomSong() end

---Get Highest Percent Surface
---@param SurfacePercents table<integer, number>
---@return nil, integer, number
function MusicManager_C.GetHighestPercentSurface(SurfacePercents) end

---Get Surface Percents
---@return nil, table<integer, number>
function MusicManager_C.GetSurfacePercents() end

---Update Music
---@return nil
function MusicManager_C.UpdateMusic() end

---Update Sound
---@return nil
function MusicManager_C.UpdateSound() end

---Play Random Song
---@return nil
function MusicManager_C.PlayRandomSong() end

---Restart Timer
---@return nil
function MusicManager_C.RestartTimer() end

---Death
---@return nil
function MusicManager_C.Death() end

return MusicManager_C
