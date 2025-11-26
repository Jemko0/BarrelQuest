---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BPComponentClassOverride
---Utility struct to store class overrides for components.
---
--- Properties
---The component name an override is being specified for.
---@field ComponentName string
---The class to use when constructing the component.
---@field ComponentClass Class
local BPComponentClassOverride = {}

--- Constructor
---@return BPComponentClassOverride
---@param ComponentName string
---@param ComponentClass Class
function BPComponentClassOverride.new(ComponentName, ComponentClass)
    local self = {}
    self.ComponentName = ComponentName
    self.ComponentClass = ComponentClass
    return self
end

return BPComponentClassOverride
