---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraCullProxyComponent : NiagaraComponent
---A specialization of UNiagaraComponent that can act as a proxy for many other NiagaraComponents that have been culled by scalability.
---
--- Properties
---
---Array of additional instance transforms. This component will be rendered at it's own transform and additionally at each of these transforms.
---@field Instances NiagaraCulledComponentInfo[]
local NiagaraCullProxyComponent = {}

--- Methods
return NiagaraCullProxyComponent
