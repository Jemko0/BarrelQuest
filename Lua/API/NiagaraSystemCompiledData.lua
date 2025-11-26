---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraSystemCompiledData
---Niagara System Compiled Data
---
--- Properties
---@field InstanceParamStore NiagaraParameterStore
---@field DataSetCompiledData NiagaraDataSetCompiledData
---@field SpawnInstanceParamsDataSetCompiledData NiagaraDataSetCompiledData
---@field UpdateInstanceParamsDataSetCompiledData NiagaraDataSetCompiledData
---@field SpawnInstanceGlobalBinding NiagaraParameterDataSetBindingCollection
---@field SpawnInstanceSystemBinding NiagaraParameterDataSetBindingCollection
---@field SpawnInstanceOwnerBinding NiagaraParameterDataSetBindingCollection
---@field SpawnInstanceEmitterBindings NiagaraParameterDataSetBindingCollection[]
---@field UpdateInstanceGlobalBinding NiagaraParameterDataSetBindingCollection
---@field UpdateInstanceSystemBinding NiagaraParameterDataSetBindingCollection
---@field UpdateInstanceOwnerBinding NiagaraParameterDataSetBindingCollection
---@field UpdateInstanceEmitterBindings NiagaraParameterDataSetBindingCollection[]
local NiagaraSystemCompiledData = {}
return NiagaraSystemCompiledData
