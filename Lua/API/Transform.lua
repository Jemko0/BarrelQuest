---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

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
return Transform
