---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NiagaraPlatformSet
---Niagara Platform Set
---
--- Properties
---States of specific device profiles we've set.
---@field DeviceProfileStates NiagaraDeviceProfileStateEntry[]
---Set of CVars values we require for this platform set to be enabled. If any of the linked CVars don't have the required values then this platform set will not be enabled.
---@field CVarConditions NiagaraPlatformSetCVarCondition[]
---Mask defining which effects qualities this set matches.
---@field QualityLevelMask integer
local NiagaraPlatformSet = {}
return NiagaraPlatformSet
