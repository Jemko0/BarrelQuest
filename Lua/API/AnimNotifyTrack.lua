---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class AnimNotifyTrack
---Keyframe position data for one track.  Pos(i) occurs at Time(i).  Pos.Num() always equals Time.Num().
---
--- Properties
---@field TrackName string
---@field TrackColor LinearColor
local AnimNotifyTrack = {}
return AnimNotifyTrack
