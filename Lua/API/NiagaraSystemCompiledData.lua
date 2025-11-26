---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraSystemCompiledData
---Niagara System Compiled Data
---
--- Properties
---
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

--- Constructor
---@return NiagaraSystemCompiledData
---@param InstanceParamStore NiagaraParameterStore
---@param DataSetCompiledData NiagaraDataSetCompiledData
---@param SpawnInstanceParamsDataSetCompiledData NiagaraDataSetCompiledData
---@param UpdateInstanceParamsDataSetCompiledData NiagaraDataSetCompiledData
---@param SpawnInstanceGlobalBinding NiagaraParameterDataSetBindingCollection
---@param SpawnInstanceSystemBinding NiagaraParameterDataSetBindingCollection
---@param SpawnInstanceOwnerBinding NiagaraParameterDataSetBindingCollection
---@param SpawnInstanceEmitterBindings NiagaraParameterDataSetBindingCollection[]
---@param UpdateInstanceGlobalBinding NiagaraParameterDataSetBindingCollection
---@param UpdateInstanceSystemBinding NiagaraParameterDataSetBindingCollection
---@param UpdateInstanceOwnerBinding NiagaraParameterDataSetBindingCollection
---@param UpdateInstanceEmitterBindings NiagaraParameterDataSetBindingCollection[]
function NiagaraSystemCompiledData.new(InstanceParamStore, DataSetCompiledData, SpawnInstanceParamsDataSetCompiledData, UpdateInstanceParamsDataSetCompiledData, SpawnInstanceGlobalBinding, SpawnInstanceSystemBinding, SpawnInstanceOwnerBinding, SpawnInstanceEmitterBindings, UpdateInstanceGlobalBinding, UpdateInstanceSystemBinding, UpdateInstanceOwnerBinding, UpdateInstanceEmitterBindings)
    local self = {}
    self.InstanceParamStore = InstanceParamStore
    self.DataSetCompiledData = DataSetCompiledData
    self.SpawnInstanceParamsDataSetCompiledData = SpawnInstanceParamsDataSetCompiledData
    self.UpdateInstanceParamsDataSetCompiledData = UpdateInstanceParamsDataSetCompiledData
    self.SpawnInstanceGlobalBinding = SpawnInstanceGlobalBinding
    self.SpawnInstanceSystemBinding = SpawnInstanceSystemBinding
    self.SpawnInstanceOwnerBinding = SpawnInstanceOwnerBinding
    self.SpawnInstanceEmitterBindings = SpawnInstanceEmitterBindings
    self.UpdateInstanceGlobalBinding = UpdateInstanceGlobalBinding
    self.UpdateInstanceSystemBinding = UpdateInstanceSystemBinding
    self.UpdateInstanceOwnerBinding = UpdateInstanceOwnerBinding
    self.UpdateInstanceEmitterBindings = UpdateInstanceEmitterBindings
    return self
end

return NiagaraSystemCompiledData
