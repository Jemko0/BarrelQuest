---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class QuartzTransportTimeStamp
---Transport Time stamp, used for tracking the musical time stamp on a clock
---
--- Properties
---The current bar this clock is on
---@field Bars integer
---The current beat this clock is on
---@field Beat integer
---A fractional representation of the time that's played since the last bear
---@field BeatFraction number
---The time in seconds that this TimeStamp occured at
---@field Seconds number
local QuartzTransportTimeStamp = {}
return QuartzTransportTimeStamp
