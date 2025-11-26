---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraVariable
---Niagara Variable
---
--- Properties
---This gets serialized but do we need to worry about endianness doing things like this? If not, where does that get handled?
---TODO: Remove storage here entirely and move everything to an FNiagaraParameterStore.
---@field VarData integer[]
---@field Name string
---@field TypeDefHandle NiagaraTypeDefinitionHandle
---@field TypeDef NiagaraTypeDefinition
local NiagaraVariable = {}
return NiagaraVariable
