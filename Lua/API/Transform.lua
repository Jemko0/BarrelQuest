---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Transform
---Transform composed of Quat/Translation/Scale.
---@note This is implemented in either TransformVectorized.h or TransformNonVectorized.h depending on the platform.
---
--- Properties
---Rotation of this transformation, as a quaternion.
---@field Rotation Quat
---Translation of this transformation, as a vector.
---@field Translation Vector
---3D scale (always applied in local space) as a vector.
---@field Scale3D Vector
local Transform = {}

--- Constructor
---@return Transform
---@param Rotation Quat
---@param Translation Vector
---@param Scale3D Vector
function Transform.new(Rotation, Translation, Scale3D)
    local self = {}
    self.Rotation = Rotation
    self.Translation = Translation
    self.Scale3D = Scale3D
    return self
end

return Transform
