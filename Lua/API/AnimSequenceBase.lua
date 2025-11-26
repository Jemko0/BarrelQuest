---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AnimSequenceBase : AnimationAsset
---Anim Sequence Base
---
--- Properties
---Animation notifies, sorted by time (earliest notification first).
---@field Notifies AnimNotifyEvent[]
---@field SequenceLength number
---@field RawCurveData RawCurveTracks
---Number for tweaking playback rate of this animation globally.
---@field RateScale number
---The default looping behavior of this animation.
---Asset players can override this
---@field bLoop boolean
---if you change Notifies array, this will need to be rebuilt
---@field AnimNotifyTracks AnimNotifyTrack[]
---@field DataModel AnimDataModel
---IAnimationDataModel instance containing (source) animation data
---@field DataModelInterface any
---UAnimDataController instance set to operate on DataModel
---@field Controller any
local AnimSequenceBase = {}

--- Methods
return AnimSequenceBase
