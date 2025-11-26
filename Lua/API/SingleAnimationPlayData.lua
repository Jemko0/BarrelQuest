---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SingleAnimationPlayData
---Single Animation Play Data
---
--- Properties
---
---@todo in the future, we should make this one UObject
---and have detail customization to display different things
---The default sequence to play on this skeletal mesh
---@field AnimToPlay AnimationAsset
---Default setting for looping for SequenceToPlay. This is not current state of looping.
---@field bSavedLooping boolean
---Default setting for playing for SequenceToPlay. This is not current state of playing.
---@field bSavedPlaying boolean
---Default setting for position of SequenceToPlay to play.
---@field SavedPosition number
---Default setting for play rate of SequenceToPlay to play.
---@field SavedPlayRate number
local SingleAnimationPlayData = {}

--- Constructor
---@return SingleAnimationPlayData
---@param AnimToPlay AnimationAsset
---@param bSavedLooping boolean
---@param bSavedPlaying boolean
---@param SavedPosition number
---@param SavedPlayRate number
function SingleAnimationPlayData.new(AnimToPlay, bSavedLooping, bSavedPlaying, SavedPosition, SavedPlayRate)
    local self = {}
    self.AnimToPlay = AnimToPlay
    self.bSavedLooping = bSavedLooping
    self.bSavedPlaying = bSavedPlaying
    self.SavedPosition = SavedPosition
    self.SavedPlayRate = SavedPlayRate
    return self
end

return SingleAnimationPlayData
