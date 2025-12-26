---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class NiagaraParameterCollection
---Asset containing a collection of global parameters usable by Niagara. Similar to Material parameter collections,
---any number of Niagara assets may reference attributes from this parameter collection and will get new values when they are changed.
---A Niagara parameter collection can reference a Material parameter collection, so it is in sync with the values provided to a Material.
---To use a value from a parameter collection in a Niagara system or emitter, add a reference to it from the Parameters panel (in the Niagara Parameter Collection section).
---
--- Properties
---
---Namespace for this parameter collection. Is enforced to be unique across all parameter collections.
---@field Namespace string
---@field Parameters NiagaraVariable[]
---Optional set of MPC that can drive scalar and vector parameters
---@field SourceMaterialCollection MaterialParameterCollection
---@field DefaultInstance NiagaraParameterCollectionInstance
---Used to track whenever something of note changes in this parameter collection that might invalidate a compilation downstream of a script/emitter/system.
---@field CompileId Guid
local NiagaraParameterCollection = {}

--- Methods
return NiagaraParameterCollection
