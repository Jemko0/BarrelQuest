---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraSystemUpdateContext
---Helper for reseting/reinitializing Niagara systems currently active when they are being edited.
---Can be used inside a scope with Systems being reinitialized on destruction or you can store the context and use CommitUpdate() to trigger reinitialization.
---For example, this can be split between PreEditChange and PostEditChange to ensure problematic data is not modified during execution of a system.
---This can be made a UPROPERTY() to ensure safey in cases where a GC could be possible between Add() and CommitUpdate().
---
--- Properties
---@field ComponentsToReset NiagaraComponent[]
---@field ComponentsToReInit NiagaraComponent[]
---@field ComponentsToNotifySimDestroy NiagaraComponent[]
---@field ComponentsToDestroyInstance NiagaraComponent[]
---@field SystemSimsToDestroy NiagaraSystem[]
---@field SystemSimsToRecache NiagaraSystem[]
local NiagaraSystemUpdateContext = {}

--- Constructor
---@return NiagaraSystemUpdateContext
---@param ComponentsToReset NiagaraComponent[]
---@param ComponentsToReInit NiagaraComponent[]
---@param ComponentsToNotifySimDestroy NiagaraComponent[]
---@param ComponentsToDestroyInstance NiagaraComponent[]
---@param SystemSimsToDestroy NiagaraSystem[]
---@param SystemSimsToRecache NiagaraSystem[]
function NiagaraSystemUpdateContext.new(ComponentsToReset, ComponentsToReInit, ComponentsToNotifySimDestroy, ComponentsToDestroyInstance, SystemSimsToDestroy, SystemSimsToRecache)
    local self = {}
    self.ComponentsToReset = ComponentsToReset
    self.ComponentsToReInit = ComponentsToReInit
    self.ComponentsToNotifySimDestroy = ComponentsToNotifySimDestroy
    self.ComponentsToDestroyInstance = ComponentsToDestroyInstance
    self.SystemSimsToDestroy = SystemSimsToDestroy
    self.SystemSimsToRecache = SystemSimsToRecache
    return self
end

return NiagaraSystemUpdateContext
