---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NamedEmitterMaterial
---Named Emitter Material
---
--- Properties
---
---@field Name string
---@field Material MaterialInterface
local NamedEmitterMaterial = {}

--- Constructor
---@return NamedEmitterMaterial
---@param Name string
---@param Material MaterialInterface
function NamedEmitterMaterial.new(Name, Material)
    local self = {}
    self.Name = Name
    self.Material = Material
    return self
end

return NamedEmitterMaterial
