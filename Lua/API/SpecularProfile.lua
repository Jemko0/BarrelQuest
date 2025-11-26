---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SpecularProfile
---Specular profile asset, can be specified at a material.
---Don't change at runtime. All properties in here are per material.
---
--- Properties
---@field Settings SpecularProfileStruct
---@field Guid Guid
local SpecularProfile = {}

--- Methods
return SpecularProfile
