---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NiagaraEmitterHandle
---Stores emitter information within the context of a System.
---
--- Properties
---The display name for this emitter in the System.
---@field Name string
---The id of this emitter handle.
---@field Id Guid
---HACK!  Data sets used to use the emitter name, but this isn't guaranteed to be unique.  This is a temporary hack
---to allow the data sets to continue work with using names, but that code needs to be refactored to use the id defined here.
---@field IdName string
---Whether or not this emitter is enabled within the System.  Disabled emitters aren't simulated.
---@field bIsEnabled boolean
---@field EmitterMode ENiagaraEmitterMode
---The source emitter this emitter handle was built from.
---@field Source NiagaraEmitter
---An unmodified copy of the emitter this handle references for use when merging change from the source emitter.
---@field LastMergedSource NiagaraEmitter
---@field bIsolated boolean
---The copied instance of the emitter this handle references.
---@field Instance NiagaraEmitter
---The copied instance of the emitter this handle references.
---@field VersionedInstance VersionedNiagaraEmitter
----TODO:Stateless: Should we return a bass class here / have a factory method to generate the runtime instance?
---@field StatelessEmitter NiagaraStatelessEmitter
local NiagaraEmitterHandle = {}
return NiagaraEmitterHandle
