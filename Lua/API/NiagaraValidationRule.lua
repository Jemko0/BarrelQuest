---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraValidationRule
---Base class for system validation logic.
---These allow Niagara systems to be inspected for content validation either at save time or from a commandlet.
---
--- Properties
---Allows disabling validation rules from config
---@field bIsConfigDisabled boolean
local NiagaraValidationRule = {}

--- Methods
return NiagaraValidationRule
