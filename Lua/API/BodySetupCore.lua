---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BodySetupCore
---Body Setup Core
---
--- Properties
---Used in the PhysicsAsset case. Associates this Body with Bone in a skeletal mesh.
---@field BoneName string
---If simulated it will use physics, if kinematic it will not be affected by physics, but can interact with physically simulated bodies. Default will inherit from OwnerComponent's behavior.
---@field PhysicsType integer
---Collision Trace behavior - by default, it will keep simple(convex)/complex(per-poly) separate *
---@field CollisionTraceFlag integer
---Collision Type for this body. This eventually changes response to collision to others *
---@field CollisionReponse integer
local BodySetupCore = {}

--- Methods
return BodySetupCore
