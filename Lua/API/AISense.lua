---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class AISense
---AISense
---
--- Properties
---
---@field NotifyType EAISenseNotifyType
---whether this sense is interested in getting notified about new Pawns being spawned
---    this can be used for example for automated sense sources registration
---@field bWantsNewPawnNotification boolean
---If true all newly spawned pawns will get auto registered as source for this sense.
---@field bAutoRegisterAllPawnsAsSources boolean
local AISense = {}

--- Methods
return AISense
