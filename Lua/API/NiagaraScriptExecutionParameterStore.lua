---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NiagaraScriptExecutionParameterStore
---Storage class containing actual runtime buffers to be used by the VM and the GPU.
---Is not the actual source for any parameter data, rather just the final place it's gathered from various other places ready for execution.
---
--- Properties
---Size of the parameter data not including prev frame values or internal constants. Allows copying into previous parameter values for interpolated spawn scripts.
---@field ParameterSize integer
---@field bInitialized boolean
---Owner of this store. Used to provide an outer to data interfaces in this store.
---@field Owner any
---Map from parameter defs to their offset in the data table or the data interface. TODO: Separate out into a layout and instance class to reduce duplicated data for this?
---@field ParameterOffsets table<NiagaraVariable, integer>
---Storage for the set of variables that are represented by this ParameterStore.  Shouldn't be accessed directly, instead use
---      ReadParameterVariables()
---@field SortedParameterOffsets NiagaraVariableWithOffset[]
---Buffer containing parameter data. Indexed using offsets in ParameterOffsets
---@field ParameterData integer[]
---Data interfaces for this script. Possibly overridden with externally owned interfaces. Also indexed by ParameterOffsets.
---@field DataInterfaces NiagaraDataInterface[]
---UObjects referenced by this store. Also indexed by ParameterOffsets.
---@field UObjects Object[]
---Holds position type source data to be later converted to LWC format. We use an array here instead of a map to save some memory and because linear search is faster with the few elements in here.
---@field OriginalPositionData NiagaraPositionSource[]
---@field DebugName string
---Guid data to remap rapid iteration parameters after a function input was renamed.
---@field ParameterGuidMapping table<NiagaraVariable, Guid>
local NiagaraScriptExecutionParameterStore = {}
return NiagaraScriptExecutionParameterStore
