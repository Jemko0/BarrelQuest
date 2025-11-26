---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ParticleSysParam
---Struct used for a particular named instance parameter for this ParticleSystemComponent.
---
--- Properties
---
---The name of the parameter
---@field Name string
---The type of parameters
---PSPT_None       - There is no data type
---PSPT_Scalar     - Use the scalar value
---PSPT_ScalarRand - Select a scalar value in the range [Scalar_Low..Scalar)
---PSPT_Vector     - Use the vector value
---PSPT_VectorRand - Select a vector value in the range [Vector_Low..Vector)
---PSPT_Color      - Use the color value
---PSPT_Actor      - Use the actor value
---PSPT_Material   - Use the material value
---PSPT_VectorUnitRand - Select a random unit vector and scale along the range [Vector_Low..Vector)
---@field ParamType integer
---@field Scalar number
---@field Scalar_Low number
---@field Vector Vector
---@field Vector_Low Vector
---@field Color Color
---@field Actor Actor
---@field Material MaterialInterface
local ParticleSysParam = {}

--- Constructor
---@return ParticleSysParam
---@param Name string
---@param ParamType integer
---@param Scalar number
---@param Scalar_Low number
---@param Vector Vector
---@param Vector_Low Vector
---@param Color Color
---@param Actor Actor
---@param Material MaterialInterface
function ParticleSysParam.new(Name, ParamType, Scalar, Scalar_Low, Vector, Vector_Low, Color, Actor, Material)
    local self = {}
    self.Name = Name
    self.ParamType = ParamType
    self.Scalar = Scalar
    self.Scalar_Low = Scalar_Low
    self.Vector = Vector
    self.Vector_Low = Vector_Low
    self.Color = Color
    self.Actor = Actor
    self.Material = Material
    return self
end

return ParticleSysParam
