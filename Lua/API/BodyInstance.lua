---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BodyInstance
---Container for a physics representation of an object
---
--- Properties
---This physics body's solver iteration count for position. Increasing this will be more CPU intensive, but better stabilized.
---@field PositionSolverIterationCount integer
---This physics body's solver iteration count for velocity. Increasing this will be more CPU intensive, but better stabilized.
---@field VelocitySolverIterationCount integer
---This physics body's solver iteration count for projection. Increasing this will be more CPU intensive, but better stabilized.
---@field ProjectionSolverIterationCount integer
---Enum indicating what type of object this should be considered as when it moves
---@field ObjectType integer
---Type of collision enabled.
---      No Collision      : Will not create any representation in the physics engine. Cannot be used for spatial queries (raycasts, sweeps, overlaps) or simulation (rigid body, constraints). Best performance possible (especially for moving objects)
---      Query Only        : Only used for spatial queries (raycasts, sweeps, and overlaps). Cannot be used for simulation (rigid body, constraints). Useful for character movement and things that do not need physical simulation. Performance gains by keeping data out of simulation tree.
---      Physics Only      : Only used only for physics simulation (rigid body, constraints). Cannot be used for spatial queries (raycasts, sweeps, overlaps). Useful for jiggly bits on characters that do not need per bone detection. Performance gains by keeping data out of query tree
---      Collision Enabled : Can be used for both spatial queries (raycasts, sweeps, overlaps) and simulation (rigid body, constraints).
---@field CollisionEnabled integer
---The set of values used in considering when put this body to sleep.
---@field SleepFamily ESleepFamily
---Locks physical movement along specified axis.
---@field DOFMode integer
---If true Continuous Collision Detection (CCD) will be used for this component
---@field bUseCCD boolean
---[EXPERIMENTAL] If true Motion-Aware Collision Detection (MACD) will be used for this component
---@field bUseMACD boolean
---If true ignore analytic collisions and treat objects as a general implicit surface
---@field bIgnoreAnalyticCollisions boolean
---Should 'Hit' events fire when this object collides during physics simulation.
---@field bNotifyRigidBodyCollision boolean
---Remove unnecessary edge collisions to allow smooth sliding over surfaces composed of multiple actors/components.
---This is fairly expensive and should only be enabled on hero objects.
---@field bSmoothEdgeCollisions boolean
---When a Locked Axis Mode is selected, will lock translation on the specified axis
---@field bLockTranslation boolean
---When a Locked Axis Mode is selected, will lock rotation to the specified axis
---@field bLockRotation boolean
---Lock translation along the X-axis
---@field bLockXTranslation boolean
---Lock translation along the Y-axis
---@field bLockYTranslation boolean
---Lock translation along the Z-axis
---@field bLockZTranslation boolean
---Lock rotation about the X-axis
---@field bLockXRotation boolean
---Lock rotation about the Y-axis
---@field bLockYRotation boolean
---Lock rotation about the Z-axis
---@field bLockZRotation boolean
---Override the default max angular velocity
---@field bOverrideMaxAngularVelocity boolean
---Whether this body instance has its own custom MaxDepenetrationVelocity
---@field bOverrideMaxDepenetrationVelocity boolean
---Whether this instance of the object has its own custom walkable slope override setting.
---@field bOverrideWalkableSlopeOnInstance boolean
---Internal flag to allow us to quickly check whether we should interpolate when substepping
---e.g. kinematic bodies that are QueryOnly do not need to interpolate as we will not be querying them
---at a sub-position.
---This is complicated by welding, where multiple the CollisionEnabled flag of the root must be considered.
---@field bInterpolateWhenSubStepping boolean
---@brief Enable automatic inertia conditioning to stabilize constraints.
---Inertia conditioning increases inertia when an object is long and thin and also when it has joints that are outside the
---collision shapes of the body. Increasing the inertia reduces the amount of rotation applied at joints which helps stabilize
---joint chains, especially when bodies are small. In principle you can get the same behaviour by setting the InertiaTensorScale
---appropriately, but this takes some of the guesswork out of it.
---@note This only changes the inertia used in the low-level solver. That inertia is not visible to the BodyInstance
---which will still report the inertia calculated from the mass, shapes, and InertiaTensorScale.
---@note When enabled, the effective inertia depends on the joints attached to the body so the inertia will change when
---joints are added or removed (automatically - no user action required).
---@field bInertiaConditioning boolean
---If set to true, this body will treat bodies that do not have the flag set as having infinite mass
---@field bOneWayInteraction boolean
---Set the desired delta time for the body. *
---@field bOverrideSolverAsyncDeltaTime boolean
---Override value for physics solver async delta time.  With multiple actors specifying this, the solver will use the smallest delta time *
---@field SolverAsyncDeltaTime number
---Collision Profile Name *
---@field CollisionProfileName string
---Types of objects that this physics objects will collide with.
---@field ResponseToChannels CollisionResponseContainer
---Custom Channels for Responses
---@field CollisionResponses CollisionResponse
---The maximum velocity used to depenetrate this object from others when spawned or teleported with initial overlaps (does not affect overlaps as a result of normal movement).
---A value of zero will allow objects that are spawned overlapping to go to sleep without moving rather than pop out of each other. E.g., use zero if you spawn dynamic rocks
---partially embedded in the ground and want them to be interactive but not pop out of the ground when touched.
---A negative value is equivalent to bOverrideMaxDepenetrationVelocity = false, meaning use the project setting.
---This overrides the CollisionInitialOverlapDepenetrationVelocity project setting on a per-body basis (and not the MaxDepenetrationVelocity solver setting that will be deprecated).
---@field MaxDepenetrationVelocity number
---Mass of the body in KG. By default we compute this based on physical material and mass scale.
---@see bOverrideMass to set this directly
---@field MassInKgOverride number
---'Drag' force added to reduce linear movement
---@field LinearDamping number
---'Drag' force added to reduce angular movement
---@field AngularDamping number
---Locks physical movement along a custom plane for a given normal.
---@field CustomDOFPlaneNormal Vector
---User specified offset for this object's Center of Mass. The offset is defined in bone space and will be added to the calculated location.
---@field COMNudge Vector
---Per-instance scaling of mass
---@field MassScale number
---What gravity group the BI should use, which determines rate of acceleration
---@field GravityGroupIndex integer
---Per-instance scaling of inertia (bigger number means  it'll be harder to rotate)
---@field InertiaTensorScale Vector
---Custom walkable slope override setting for this instance.
---@see GetWalkableSlopeOverride(), SetWalkableSlopeOverride()
---@field WalkableSlopeOverride WalkableSlopeOverride
---Allows you to override the PhysicalMaterial to use for simple collision on this body.
---@field PhysMaterialOverride PhysicalMaterial
---The maximum angular velocity for this instance [degrees/s]
---@field MaxAngularVelocity number
---If the SleepFamily is set to custom, multiply the natural sleep threshold by this amount. A higher number will cause the body to sleep sooner.
---@field CustomSleepThresholdMultiplier number
---Stabilization factor for this body if Physics stabilization is enabled. A higher number will cause more aggressive stabilization at the risk of loss of momentum at low speeds. A value of 0 will disable stabilization for this body.
---@field StabilizationThresholdMultiplier number
---Provide appropriate interface for doing this instead of allowing BlueprintReadWrite *
---@field PhysicsBlendWeight number
---If true, this body will use simulation. If false, will be 'fixed' (ie kinematic) and move where it is told.
---For a Skeletal Mesh Component, simulating requires a physics asset setup and assigned on the SkeletalMesh asset.
---For a Static Mesh Component, simulating requires simple collision to be setup on the StaticMesh asset.
---@field bSimulatePhysics boolean
---If true, mass will not be automatically computed and you must set it directly
---@field bOverrideMass boolean
---If object should have the force of gravity applied
---@field bEnableGravity boolean
---When kinematic, whether the actor transform should be updated as a result of movement in the simulation, rather than immediately whenever a target transform is set.
---@field bUpdateKinematicFromSimulation boolean
---Enabled/disables whether this body is affected by gyroscopic torque, mainly useful for long/thin objects that spin
---@field bGyroscopicTorqueEnabled boolean
---If true and is attached to a parent, the two bodies will be joined into a single rigid body. Physical settings like collision profile and body settings are determined by the root
---@field bAutoWeld boolean
---If object should start awake, or if it should initially be sleeping
---@field bStartAwake boolean
---Should 'wake/sleep' events fire when this object is woken up or put to sleep by the physics simulation.
---@field bGenerateWakeEvents boolean
---If true, it will update mass when scale change *
---@field bUpdateMassWhenScaleChanges boolean
local BodyInstance = {}

--- Constructor
---@return BodyInstance
---@param PositionSolverIterationCount integer
---@param VelocitySolverIterationCount integer
---@param ProjectionSolverIterationCount integer
---@param ObjectType integer
---@param CollisionEnabled integer
---@param SleepFamily ESleepFamily
---@param DOFMode integer
---@param bUseCCD boolean
---@param bUseMACD boolean
---@param bIgnoreAnalyticCollisions boolean
---@param bNotifyRigidBodyCollision boolean
---@param bSmoothEdgeCollisions boolean
---@param bLockTranslation boolean
---@param bLockRotation boolean
---@param bLockXTranslation boolean
---@param bLockYTranslation boolean
---@param bLockZTranslation boolean
---@param bLockXRotation boolean
---@param bLockYRotation boolean
---@param bLockZRotation boolean
---@param bOverrideMaxAngularVelocity boolean
---@param bOverrideMaxDepenetrationVelocity boolean
---@param bOverrideWalkableSlopeOnInstance boolean
---@param bInterpolateWhenSubStepping boolean
---@param bInertiaConditioning boolean
---@param bOneWayInteraction boolean
---@param bOverrideSolverAsyncDeltaTime boolean
---@param SolverAsyncDeltaTime number
---@param CollisionProfileName string
---@param ResponseToChannels CollisionResponseContainer
---@param CollisionResponses CollisionResponse
---@param MaxDepenetrationVelocity number
---@param MassInKgOverride number
---@param LinearDamping number
---@param AngularDamping number
---@param CustomDOFPlaneNormal Vector
---@param COMNudge Vector
---@param MassScale number
---@param GravityGroupIndex integer
---@param InertiaTensorScale Vector
---@param WalkableSlopeOverride WalkableSlopeOverride
---@param PhysMaterialOverride PhysicalMaterial
---@param MaxAngularVelocity number
---@param CustomSleepThresholdMultiplier number
---@param StabilizationThresholdMultiplier number
---@param PhysicsBlendWeight number
---@param bSimulatePhysics boolean
---@param bOverrideMass boolean
---@param bEnableGravity boolean
---@param bUpdateKinematicFromSimulation boolean
---@param bGyroscopicTorqueEnabled boolean
---@param bAutoWeld boolean
---@param bStartAwake boolean
---@param bGenerateWakeEvents boolean
---@param bUpdateMassWhenScaleChanges boolean
function BodyInstance.new(PositionSolverIterationCount, VelocitySolverIterationCount, ProjectionSolverIterationCount, ObjectType, CollisionEnabled, SleepFamily, DOFMode, bUseCCD, bUseMACD, bIgnoreAnalyticCollisions, bNotifyRigidBodyCollision, bSmoothEdgeCollisions, bLockTranslation, bLockRotation, bLockXTranslation, bLockYTranslation, bLockZTranslation, bLockXRotation, bLockYRotation, bLockZRotation, bOverrideMaxAngularVelocity, bOverrideMaxDepenetrationVelocity, bOverrideWalkableSlopeOnInstance, bInterpolateWhenSubStepping, bInertiaConditioning, bOneWayInteraction, bOverrideSolverAsyncDeltaTime, SolverAsyncDeltaTime, CollisionProfileName, ResponseToChannels, CollisionResponses, MaxDepenetrationVelocity, MassInKgOverride, LinearDamping, AngularDamping, CustomDOFPlaneNormal, COMNudge, MassScale, GravityGroupIndex, InertiaTensorScale, WalkableSlopeOverride, PhysMaterialOverride, MaxAngularVelocity, CustomSleepThresholdMultiplier, StabilizationThresholdMultiplier, PhysicsBlendWeight, bSimulatePhysics, bOverrideMass, bEnableGravity, bUpdateKinematicFromSimulation, bGyroscopicTorqueEnabled, bAutoWeld, bStartAwake, bGenerateWakeEvents, bUpdateMassWhenScaleChanges)
    local self = {}
    self.PositionSolverIterationCount = PositionSolverIterationCount
    self.VelocitySolverIterationCount = VelocitySolverIterationCount
    self.ProjectionSolverIterationCount = ProjectionSolverIterationCount
    self.ObjectType = ObjectType
    self.CollisionEnabled = CollisionEnabled
    self.SleepFamily = SleepFamily
    self.DOFMode = DOFMode
    self.bUseCCD = bUseCCD
    self.bUseMACD = bUseMACD
    self.bIgnoreAnalyticCollisions = bIgnoreAnalyticCollisions
    self.bNotifyRigidBodyCollision = bNotifyRigidBodyCollision
    self.bSmoothEdgeCollisions = bSmoothEdgeCollisions
    self.bLockTranslation = bLockTranslation
    self.bLockRotation = bLockRotation
    self.bLockXTranslation = bLockXTranslation
    self.bLockYTranslation = bLockYTranslation
    self.bLockZTranslation = bLockZTranslation
    self.bLockXRotation = bLockXRotation
    self.bLockYRotation = bLockYRotation
    self.bLockZRotation = bLockZRotation
    self.bOverrideMaxAngularVelocity = bOverrideMaxAngularVelocity
    self.bOverrideMaxDepenetrationVelocity = bOverrideMaxDepenetrationVelocity
    self.bOverrideWalkableSlopeOnInstance = bOverrideWalkableSlopeOnInstance
    self.bInterpolateWhenSubStepping = bInterpolateWhenSubStepping
    self.bInertiaConditioning = bInertiaConditioning
    self.bOneWayInteraction = bOneWayInteraction
    self.bOverrideSolverAsyncDeltaTime = bOverrideSolverAsyncDeltaTime
    self.SolverAsyncDeltaTime = SolverAsyncDeltaTime
    self.CollisionProfileName = CollisionProfileName
    self.ResponseToChannels = ResponseToChannels
    self.CollisionResponses = CollisionResponses
    self.MaxDepenetrationVelocity = MaxDepenetrationVelocity
    self.MassInKgOverride = MassInKgOverride
    self.LinearDamping = LinearDamping
    self.AngularDamping = AngularDamping
    self.CustomDOFPlaneNormal = CustomDOFPlaneNormal
    self.COMNudge = COMNudge
    self.MassScale = MassScale
    self.GravityGroupIndex = GravityGroupIndex
    self.InertiaTensorScale = InertiaTensorScale
    self.WalkableSlopeOverride = WalkableSlopeOverride
    self.PhysMaterialOverride = PhysMaterialOverride
    self.MaxAngularVelocity = MaxAngularVelocity
    self.CustomSleepThresholdMultiplier = CustomSleepThresholdMultiplier
    self.StabilizationThresholdMultiplier = StabilizationThresholdMultiplier
    self.PhysicsBlendWeight = PhysicsBlendWeight
    self.bSimulatePhysics = bSimulatePhysics
    self.bOverrideMass = bOverrideMass
    self.bEnableGravity = bEnableGravity
    self.bUpdateKinematicFromSimulation = bUpdateKinematicFromSimulation
    self.bGyroscopicTorqueEnabled = bGyroscopicTorqueEnabled
    self.bAutoWeld = bAutoWeld
    self.bStartAwake = bStartAwake
    self.bGenerateWakeEvents = bGenerateWakeEvents
    self.bUpdateMassWhenScaleChanges = bUpdateMassWhenScaleChanges
    return self
end

return BodyInstance
