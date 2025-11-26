---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class UMGSequencePlayer
---UMGSequence Player
---
--- Properties
local UMGSequencePlayer = {}

--- Methods
---Set User Tag
---@param InUserTag string
---@return nil
function UMGSequencePlayer.SetUserTag(InUserTag) end

---@return string
function UMGSequencePlayer.GetUserTag() end

return UMGSequencePlayer
