---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraMessageStore
---Niagara Message Store
---
--- Properties
---@field MessageKeyToMessageMap table<Guid, NiagaraMessageDataBase>
---@field DismissedMessageKeys Guid[]
local NiagaraMessageStore = {}

--- Constructor
---@return NiagaraMessageStore
---@param MessageKeyToMessageMap table<Guid, NiagaraMessageDataBase>
---@param DismissedMessageKeys Guid[]
function NiagaraMessageStore.new(MessageKeyToMessageMap, DismissedMessageKeys)
    local self = {}
    self.MessageKeyToMessageMap = MessageKeyToMessageMap
    self.DismissedMessageKeys = DismissedMessageKeys
    return self
end

return NiagaraMessageStore
