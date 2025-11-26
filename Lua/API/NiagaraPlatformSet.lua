---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraPlatformSet
---Niagara Platform Set
---
--- Properties
---
---States of specific device profiles we've set.
---@field DeviceProfileStates NiagaraDeviceProfileStateEntry[]
---Set of CVars values we require for this platform set to be enabled. If any of the linked CVars don't have the required values then this platform set will not be enabled.
---@field CVarConditions NiagaraPlatformSetCVarCondition[]
---Mask defining which effects qualities this set matches.
---@field QualityLevelMask integer
local NiagaraPlatformSet = {}

--- Constructor
---@return NiagaraPlatformSet
---@param DeviceProfileStates NiagaraDeviceProfileStateEntry[]
---@param CVarConditions NiagaraPlatformSetCVarCondition[]
---@param QualityLevelMask integer
function NiagaraPlatformSet.new(DeviceProfileStates, CVarConditions, QualityLevelMask)
    local self = {}
    self.DeviceProfileStates = DeviceProfileStates
    self.CVarConditions = CVarConditions
    self.QualityLevelMask = QualityLevelMask
    return self
end

return NiagaraPlatformSet
