---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class PlayerInput
---Object within PlayerController that processes player input.
---Only exists on the client in network games.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Input/index.html
---
--- Properties
---Generic bindings of keys to Exec()-compatible strings for development purposes only
---@field DebugExecBindings KeyBind[]
---List of Axis Mappings that have been inverted
---@field InvertedAxis string[]
local PlayerInput = {}

--- Methods
---Return's this object casted to a player controller. This can be null if there is no player controller.
---@return PlayerController
function PlayerInput.GetOuterAPlayerController() end

return PlayerInput
