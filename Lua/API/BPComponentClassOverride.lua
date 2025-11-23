---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class BPComponentClassOverride
---Utility struct to store class overrides for components.
---
--- Properties
---The component name an override is being specified for.
---@field ComponentName string
---The class to use when constructing the component.
---@field ComponentClass Class
local BPComponentClassOverride = {}
return BPComponentClassOverride
