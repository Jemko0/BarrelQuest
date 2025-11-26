---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ParticleSysParam
---Struct used for a particular named instance parameter for this ParticleSystemComponent.
---
--- Properties
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
return ParticleSysParam
