---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SingleAnimationPlayData
---Single Animation Play Data
---
--- Properties
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
return SingleAnimationPlayData
