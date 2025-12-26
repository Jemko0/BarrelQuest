---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class SoundSubmixBase
---Sound Submix Base
---
--- Properties
---
---Auto-manage enabling and disabling the submix as a CPU optimization. It will be disabled if the submix and all child submixes are silent. It will re-enable if a sound is sent to the submix or a child submix is audible.
---@field bAutoDisable boolean
---The minimum amount of time to wait before automatically disabling a submix if it is silent. Will immediately re-enable if source audio is sent to it.
---@field AutoDisableTime number
---Child submixes to this sound mix
---@field ChildSubmixes SoundSubmixBase[]
---Dynamic Child submixes (Map of AudioDevice -> [Submix] )
---@field DynamicChildSubmixes table<integer, DynamicChildSubmix>
local SoundSubmixBase = {}

--- Methods
---Searching upwards from this Submix to the root looking for the first Submix marked Dynamic
---If this Submix is Dynamic this will be returned.
---@return SoundSubmixBase
function SoundSubmixBase.FindDynamicAncestor() end

---Dynamically Disconnect from a parent.
---@param WorldContextObject Object
---@return boolean
function SoundSubmixBase.DynamicDisconnect(WorldContextObject) end

---Dynamically Connects to a parent submix.
---@param WorldContextObject Object
---@param InParent SoundSubmixBase
---@return boolean
function SoundSubmixBase.DynamicConnect(WorldContextObject, InParent) end

return SoundSubmixBase
