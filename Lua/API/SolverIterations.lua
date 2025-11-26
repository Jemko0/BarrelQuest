---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SolverIterations
---Solver settings for use by the Legacy RigidBody AnimNode (RBAN) solver.
---These settings are no longer used by default and will eventually be deprecated and then removed.
---@note These settings have no effect when the Physics Asset is used in a world simulation (ragdoll).
---
--- Properties
---The recommended number of solver iterations. Increase this if collision and joints are fighting, or joint chains are stretching.
---@field SolverIterations integer
---The recommended number of joint sub-iterations. Increasing this can help with chains of long-thin bodies.
---@field JointIterations integer
---The recommended number of collision sub-iterations. Increasing this can help with collision jitter.
---@field CollisionIterations integer
---Increase this if bodies remain penetrating
---@field SolverPushOutIterations integer
---The recommended number of joint sub-push-out iterations.
---@field JointPushOutIterations integer
---The recommended number of joint sub-push-out iterations. Increasing this can help with collision penetration problems.
---@field CollisionPushOutIterations integer
local SolverIterations = {}
return SolverIterations
