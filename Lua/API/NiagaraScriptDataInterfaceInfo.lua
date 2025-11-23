---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NiagaraScriptDataInterfaceInfo
---Niagara Script Data Interface Info
---
--- Properties
---@field DataInterface NiagaraDataInterface
---@field Name string
---@field CompileName string
---Index of the user pointer for this data interface.
---@field UserPtrIdx integer
---@field Type NiagaraTypeDefinition
---@field RegisteredParameterMapRead string
---@field RegisteredParameterMapWrite string
---@field SourceEmitterName string
local NiagaraScriptDataInterfaceInfo = {}
return NiagaraScriptDataInterfaceInfo
