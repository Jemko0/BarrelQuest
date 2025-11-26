---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PropertyBinding
---Property Binding
---
--- Properties
---The source object to use as the initial container to resolve the Source Property Path on.
---@field SourceObject any
---The property path to trace to resolve this binding on the Source Object
---@field SourcePath DynamicPropertyPath
---Used to determine if a binding already exists on the object and if this binding can be safely removed.
---@field DestinationProperty string
local PropertyBinding = {}

--- Methods
return PropertyBinding
