---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ConstraintInstance
---Container for a physics representation of an object.
---
--- Properties
---Name of bone that this joint is associated with.
---@field JointName string
---Name of first bone (body) that this constraint is connecting.
---This will be the 'child' bone in a PhysicsAsset.
---@field ConstraintBone1 string
---Name of second bone (body) that this constraint is connecting.
---This will be the 'parent' bone in a PhysicsAset.
---@field ConstraintBone2 string
---Location of constraint in Body1 reference frame (usually the "child" body for skeletal meshes).
---@field Pos1 Vector
---Primary (twist) axis in Body1 reference frame.
---@field PriAxis1 Vector
---Secondary axis in Body1 reference frame. Orthogonal to PriAxis1.
---@field SecAxis1 Vector
---Location of constraint in Body2 reference frame (usually the "parent" body for skeletal meshes).
---@field Pos2 Vector
---Primary (twist) axis in Body2 reference frame.
---@field PriAxis2 Vector
---Secondary axis in Body2 reference frame. Orthogonal to PriAxis2.
---@field SecAxis2 Vector
---Specifies the angular offset between the two frames of reference. By default limit goes from (-Angle, +Angle)
---This allows you to bias the limit for swing1 swing2 and twist.
---@field AngularRotationOffset Rotator
---If true, linear limits scale using the absolute min of the 3d scale of the owning component
---@field bScaleLinearLimits boolean
---Constraint Data (properties easily swapped at runtime based on different constraint profiles)
---@field ProfileInstance ConstraintProfileProperties
---@field bDisableCollision boolean
---@field bEnableProjection boolean
---@field ProjectionLinearTolerance number
---@field ProjectionAngularTolerance number
---@field LinearXMotion integer
---@field LinearYMotion integer
---@field LinearZMotion integer
---@field LinearLimitSize number
---@field bLinearLimitSoft boolean
---@field LinearLimitStiffness number
---@field LinearLimitDamping number
---@field bLinearBreakable boolean
---@field LinearBreakThreshold number
---@field AngularSwing1Motion integer
---@field AngularTwistMotion integer
---@field AngularSwing2Motion integer
---@field bSwingLimitSoft boolean
---@field bTwistLimitSoft boolean
---@field Swing1LimitAngle number
---@field TwistLimitAngle number
---@field Swing2LimitAngle number
---@field SwingLimitStiffness number
---@field SwingLimitDamping number
---@field TwistLimitStiffness number
---@field TwistLimitDamping number
---@field bAngularBreakable boolean
---@field AngularBreakThreshold number
---@field bLinearXPositionDrive boolean
---@field bLinearXVelocityDrive boolean
---@field bLinearYPositionDrive boolean
---@field bLinearYVelocityDrive boolean
---@field bLinearZPositionDrive boolean
---@field bLinearZVelocityDrive boolean
---@field bLinearPositionDrive boolean
---@field bLinearVelocityDrive boolean
---@field LinearPositionTarget Vector
---@field LinearVelocityTarget Vector
---@field LinearDriveSpring number
---@field LinearDriveDamping number
---@field LinearDriveForceLimit number
---@field bSwingPositionDrive boolean
---@field bSwingVelocityDrive boolean
---@field bTwistPositionDrive boolean
---@field bTwistVelocityDrive boolean
---@field bAngularSlerpDrive boolean
---@field bAngularOrientationDrive boolean
---@field bEnableSwingDrive boolean
---@field bEnableTwistDrive boolean
---@field bAngularVelocityDrive boolean
---@field AngularPositionTarget Quat
---@field AngularDriveMode integer
---@field AngularOrientationTarget Rotator
---@field AngularVelocityTarget Vector
---Revolutions per second
---@field AngularDriveSpring number
---@field AngularDriveDamping number
---@field AngularDriveForceLimit number
local ConstraintInstance = {}

--- Constructor
---@return ConstraintInstance
---@param JointName string
---@param ConstraintBone1 string
---@param ConstraintBone2 string
---@param Pos1 Vector
---@param PriAxis1 Vector
---@param SecAxis1 Vector
---@param Pos2 Vector
---@param PriAxis2 Vector
---@param SecAxis2 Vector
---@param AngularRotationOffset Rotator
---@param bScaleLinearLimits boolean
---@param ProfileInstance ConstraintProfileProperties
---@param bDisableCollision boolean
---@param bEnableProjection boolean
---@param ProjectionLinearTolerance number
---@param ProjectionAngularTolerance number
---@param LinearXMotion integer
---@param LinearYMotion integer
---@param LinearZMotion integer
---@param LinearLimitSize number
---@param bLinearLimitSoft boolean
---@param LinearLimitStiffness number
---@param LinearLimitDamping number
---@param bLinearBreakable boolean
---@param LinearBreakThreshold number
---@param AngularSwing1Motion integer
---@param AngularTwistMotion integer
---@param AngularSwing2Motion integer
---@param bSwingLimitSoft boolean
---@param bTwistLimitSoft boolean
---@param Swing1LimitAngle number
---@param TwistLimitAngle number
---@param Swing2LimitAngle number
---@param SwingLimitStiffness number
---@param SwingLimitDamping number
---@param TwistLimitStiffness number
---@param TwistLimitDamping number
---@param bAngularBreakable boolean
---@param AngularBreakThreshold number
---@param bLinearXPositionDrive boolean
---@param bLinearXVelocityDrive boolean
---@param bLinearYPositionDrive boolean
---@param bLinearYVelocityDrive boolean
---@param bLinearZPositionDrive boolean
---@param bLinearZVelocityDrive boolean
---@param bLinearPositionDrive boolean
---@param bLinearVelocityDrive boolean
---@param LinearPositionTarget Vector
---@param LinearVelocityTarget Vector
---@param LinearDriveSpring number
---@param LinearDriveDamping number
---@param LinearDriveForceLimit number
---@param bSwingPositionDrive boolean
---@param bSwingVelocityDrive boolean
---@param bTwistPositionDrive boolean
---@param bTwistVelocityDrive boolean
---@param bAngularSlerpDrive boolean
---@param bAngularOrientationDrive boolean
---@param bEnableSwingDrive boolean
---@param bEnableTwistDrive boolean
---@param bAngularVelocityDrive boolean
---@param AngularPositionTarget Quat
---@param AngularDriveMode integer
---@param AngularOrientationTarget Rotator
---@param AngularVelocityTarget Vector
---@param AngularDriveSpring number
---@param AngularDriveDamping number
---@param AngularDriveForceLimit number
function ConstraintInstance.new(JointName, ConstraintBone1, ConstraintBone2, Pos1, PriAxis1, SecAxis1, Pos2, PriAxis2, SecAxis2, AngularRotationOffset, bScaleLinearLimits, ProfileInstance, bDisableCollision, bEnableProjection, ProjectionLinearTolerance, ProjectionAngularTolerance, LinearXMotion, LinearYMotion, LinearZMotion, LinearLimitSize, bLinearLimitSoft, LinearLimitStiffness, LinearLimitDamping, bLinearBreakable, LinearBreakThreshold, AngularSwing1Motion, AngularTwistMotion, AngularSwing2Motion, bSwingLimitSoft, bTwistLimitSoft, Swing1LimitAngle, TwistLimitAngle, Swing2LimitAngle, SwingLimitStiffness, SwingLimitDamping, TwistLimitStiffness, TwistLimitDamping, bAngularBreakable, AngularBreakThreshold, bLinearXPositionDrive, bLinearXVelocityDrive, bLinearYPositionDrive, bLinearYVelocityDrive, bLinearZPositionDrive, bLinearZVelocityDrive, bLinearPositionDrive, bLinearVelocityDrive, LinearPositionTarget, LinearVelocityTarget, LinearDriveSpring, LinearDriveDamping, LinearDriveForceLimit, bSwingPositionDrive, bSwingVelocityDrive, bTwistPositionDrive, bTwistVelocityDrive, bAngularSlerpDrive, bAngularOrientationDrive, bEnableSwingDrive, bEnableTwistDrive, bAngularVelocityDrive, AngularPositionTarget, AngularDriveMode, AngularOrientationTarget, AngularVelocityTarget, AngularDriveSpring, AngularDriveDamping, AngularDriveForceLimit)
    local self = {}
    self.JointName = JointName
    self.ConstraintBone1 = ConstraintBone1
    self.ConstraintBone2 = ConstraintBone2
    self.Pos1 = Pos1
    self.PriAxis1 = PriAxis1
    self.SecAxis1 = SecAxis1
    self.Pos2 = Pos2
    self.PriAxis2 = PriAxis2
    self.SecAxis2 = SecAxis2
    self.AngularRotationOffset = AngularRotationOffset
    self.bScaleLinearLimits = bScaleLinearLimits
    self.ProfileInstance = ProfileInstance
    self.bDisableCollision = bDisableCollision
    self.bEnableProjection = bEnableProjection
    self.ProjectionLinearTolerance = ProjectionLinearTolerance
    self.ProjectionAngularTolerance = ProjectionAngularTolerance
    self.LinearXMotion = LinearXMotion
    self.LinearYMotion = LinearYMotion
    self.LinearZMotion = LinearZMotion
    self.LinearLimitSize = LinearLimitSize
    self.bLinearLimitSoft = bLinearLimitSoft
    self.LinearLimitStiffness = LinearLimitStiffness
    self.LinearLimitDamping = LinearLimitDamping
    self.bLinearBreakable = bLinearBreakable
    self.LinearBreakThreshold = LinearBreakThreshold
    self.AngularSwing1Motion = AngularSwing1Motion
    self.AngularTwistMotion = AngularTwistMotion
    self.AngularSwing2Motion = AngularSwing2Motion
    self.bSwingLimitSoft = bSwingLimitSoft
    self.bTwistLimitSoft = bTwistLimitSoft
    self.Swing1LimitAngle = Swing1LimitAngle
    self.TwistLimitAngle = TwistLimitAngle
    self.Swing2LimitAngle = Swing2LimitAngle
    self.SwingLimitStiffness = SwingLimitStiffness
    self.SwingLimitDamping = SwingLimitDamping
    self.TwistLimitStiffness = TwistLimitStiffness
    self.TwistLimitDamping = TwistLimitDamping
    self.bAngularBreakable = bAngularBreakable
    self.AngularBreakThreshold = AngularBreakThreshold
    self.bLinearXPositionDrive = bLinearXPositionDrive
    self.bLinearXVelocityDrive = bLinearXVelocityDrive
    self.bLinearYPositionDrive = bLinearYPositionDrive
    self.bLinearYVelocityDrive = bLinearYVelocityDrive
    self.bLinearZPositionDrive = bLinearZPositionDrive
    self.bLinearZVelocityDrive = bLinearZVelocityDrive
    self.bLinearPositionDrive = bLinearPositionDrive
    self.bLinearVelocityDrive = bLinearVelocityDrive
    self.LinearPositionTarget = LinearPositionTarget
    self.LinearVelocityTarget = LinearVelocityTarget
    self.LinearDriveSpring = LinearDriveSpring
    self.LinearDriveDamping = LinearDriveDamping
    self.LinearDriveForceLimit = LinearDriveForceLimit
    self.bSwingPositionDrive = bSwingPositionDrive
    self.bSwingVelocityDrive = bSwingVelocityDrive
    self.bTwistPositionDrive = bTwistPositionDrive
    self.bTwistVelocityDrive = bTwistVelocityDrive
    self.bAngularSlerpDrive = bAngularSlerpDrive
    self.bAngularOrientationDrive = bAngularOrientationDrive
    self.bEnableSwingDrive = bEnableSwingDrive
    self.bEnableTwistDrive = bEnableTwistDrive
    self.bAngularVelocityDrive = bAngularVelocityDrive
    self.AngularPositionTarget = AngularPositionTarget
    self.AngularDriveMode = AngularDriveMode
    self.AngularOrientationTarget = AngularOrientationTarget
    self.AngularVelocityTarget = AngularVelocityTarget
    self.AngularDriveSpring = AngularDriveSpring
    self.AngularDriveDamping = AngularDriveDamping
    self.AngularDriveForceLimit = AngularDriveForceLimit
    return self
end

return ConstraintInstance
