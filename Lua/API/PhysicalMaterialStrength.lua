---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PhysicalMaterialStrength
---Defines the directional strengths of a physical material in term of force per surface area
---
--- Properties
---Tensile strength of the material in MegaPascal ( 10^6 N/m2 )
---This amount of tension force per area the material can withstand before it fractures
---@field TensileStrength number
---Compression strength of the material in MegaPascal ( 10^6 N/m2 )
---This amount of compression force per area the material can withstand before it fractures, crumbles or buckles
---@field CompressionStrength number
---Shear strength of the material in MegaPascal ( 10^6 N/m2 )
---This amount of shear force per area the material can withstand before it fractures
---@field ShearStrength number
local PhysicalMaterialStrength = {}

--- Constructor
---@return PhysicalMaterialStrength
---@param TensileStrength number
---@param CompressionStrength number
---@param ShearStrength number
function PhysicalMaterialStrength.new(TensileStrength, CompressionStrength, ShearStrength)
    local self = {}
    self.TensileStrength = TensileStrength
    self.CompressionStrength = CompressionStrength
    self.ShearStrength = ShearStrength
    return self
end

return PhysicalMaterialStrength
