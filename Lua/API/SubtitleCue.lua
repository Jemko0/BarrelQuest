---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SubtitleCue
---A line of subtitle text and the time at which it should be displayed.
---
--- Properties
---The text to appear in the subtitle.
---@field Text string
---The time at which the subtitle is to be displayed, in seconds relative to the beginning of the line.
---@field Time number
local SubtitleCue = {}
return SubtitleCue
