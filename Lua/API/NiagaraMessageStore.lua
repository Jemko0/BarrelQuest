---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NiagaraMessageStore
---Niagara Message Store
---
--- Properties
---@field MessageKeyToMessageMap table<Guid, NiagaraMessageDataBase>
---@field DismissedMessageKeys Guid[]
local NiagaraMessageStore = {}
return NiagaraMessageStore
