---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class PhysicsAsset
---PhysicsAsset contains a set of rigid bodies and constraints that make up a single ragdoll.
---The asset is not limited to human ragdolls, and can be used for any physical simulation using bodies and constraints.
---A SkeletalMesh has a single PhysicsAsset, which allows for easily turning ragdoll physics on or off for many SkeletalMeshComponents
---The asset can be configured inside the Physics Asset Editor.
---@see https://docs.unrealengine.com/InteractiveExperiences/Physics/PhysicsAssetEditor
---@see USkeletalMesh
---
--- Properties
---
---Default skeletal mesh to use when previewing this PhysicsAsset etc.
---Is the one that was used as the basis for creating this Asset.
---@field DefaultSkelMesh SkeletalMesh
---@field PreviewSkeletalMesh any
---@field PhysicalAnimationProfiles string[]
---@field ConstraintProfiles string[]
---A set of flags for each physics body. Used to store persistent per body editor data.
---@field EditorBodyFlags integer[]
---@field CurrentPhysicalAnimationProfileName string
---@field CurrentConstraintProfileName string
---Index of bodies that are marked bConsiderForBounds
---@field BoundsBodies integer[]
---Array of SkeletalBodySetup objects. Stores information about collision shape etc. for each body.
---Does not include body position - those are taken from mesh.
---@field SkeletalBodySetups SkeletalBodySetup[]
---Array of RB_ConstraintSetup objects.
---Stores information about a joint between two bodies, such as position relative to each body, joint limits etc.
---@field ConstraintSetup PhysicsConstraintTemplate[]
---Solver settings when the asset is used with a RigidBody Anim Node (RBAN).
---@field SolverSettings PhysicsAssetSolverSettings
---Old solver settings shown for reference. These will be removed at some point.
---When you open an old asset you should see that the settings were transferred to "SolverSettings" above.
---You should usually see:
---SolverSettings.PositionIterations = OldSettings.SolverIterations * OldSetting.JointIterations;
---SolverSettings.VelocityIterations = 1;
---SolverSettings.ProjectionIterations = 1;
---@field SolverIterations SolverIterations
---Solver type used in physics asset editor. This can be used to make what you see in the asset editor more closely resembles what you
---see in game (though there will be differences owing to framerate variation etc). If your asset will primarily be used as a ragdoll
---select "World", but if it will be used in the AnimGraph select "RBAN".
---@field SolverType EPhysicsAssetSolverType
---If true, we skip instancing bodies for this PhysicsAsset on dedicated servers
---@field bNotForDedicatedServer boolean
---Information for thumbnail rendering
---@field ThumbnailInfo ThumbnailInfo
local PhysicsAsset = {}

--- Methods
---Gets all constraints
---@param bIncludesTerminated boolean
---@return nil, ConstraintInstanceAccessor[]
function PhysicsAsset.GetConstraints(bIncludesTerminated) end

---Gets a constraint by its joint name
---@param ConstraintName string
---@return ConstraintInstanceAccessor
function PhysicsAsset.GetConstraintByName(ConstraintName) end

---Gets a constraint by its joint name
---@param Bone1Name string
---@param Bone2Name string
---@return ConstraintInstanceAccessor
function PhysicsAsset.GetConstraintByBoneNames(Bone1Name, Bone2Name) end

return PhysicsAsset
