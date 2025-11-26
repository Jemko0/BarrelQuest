---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SpringArmComponent : SceneComponent
---This component tries to maintain its children at a fixed distance from the parent,
---but will retract the children if there is a collision, and spring back when there is no collision.
---Example: Use as a 'camera boom' or 'selfie stick' to keep the follow camera for a player from colliding into the world.
---
--- Properties
---Natural length of the spring arm when there are no collisions
---@field TargetArmLength number
---offset at end of spring arm; use this instead of the relative offset of the attached component to ensure the line trace works as desired
---@field SocketOffset Vector
---Offset at start of spring, applied in world space. Use this if you want a world-space offset from the parent component instead of the usual relative-space offset.
---@field TargetOffset Vector
---How big should the query probe sphere be (in unreal units)
---@field ProbeSize number
---Collision channel of the query probe (defaults to ECC_Camera)
---@field ProbeChannel integer
---If true, do a collision test using ProbeChannel and ProbeSize to prevent camera clipping into level.
---@field bDoCollisionTest boolean
---If this component is placed on a pawn, should it use the view/control rotation of the pawn where possible?
---When disabled, the component will revert to using the stored RelativeRotation of the component.
---Note that this component itself does not rotate, but instead maintains its relative rotation to its parent as normal,
---and just repositions and rotates its children as desired by the inherited rotation settings. Use GetTargetRotation()
---if you want the rotation target based on all the settings (UsePawnControlRotation, InheritPitch, etc).
---@see GetTargetRotation(), APawn::GetViewRotation()
---@field bUsePawnControlRotation boolean
---Should we inherit pitch from parent component. Does nothing if using Absolute Rotation.
---@field bInheritPitch boolean
---Should we inherit yaw from parent component. Does nothing if using Absolute Rotation.
---@field bInheritYaw boolean
---Should we inherit roll from parent component. Does nothing if using Absolute Rotation.
---@field bInheritRoll boolean
---If true, camera lags behind target position to smooth its movement.
---@see CameraLagSpeed
---@field bEnableCameraLag boolean
---If true, camera lags behind target rotation to smooth its movement.
---@see CameraRotationLagSpeed
---@field bEnableCameraRotationLag boolean
---If bUseCameraLagSubstepping is true, sub-step camera damping so that it handles fluctuating frame rates well (though this comes at a cost).
---@see CameraLagMaxTimeStep
---@field bUseCameraLagSubstepping boolean
---If true and camera location lag is enabled, draws markers at the camera target (in green) and the lagged position (in yellow).
---A line is drawn between the two locations, in green normally but in red if the distance to the lag target has been clamped (by CameraLagMaxDistance).
---@field bDrawDebugLagMarkers boolean
---If bEnableCameraLag is true, controls how quickly camera reaches target position. Low values are slower (more lag), high values are faster (less lag), while zero is instant (no lag).
---@field CameraLagSpeed number
---If bEnableCameraRotationLag is true, controls how quickly camera reaches target position. Low values are slower (more lag), high values are faster (less lag), while zero is instant (no lag).
---@field CameraRotationLagSpeed number
---Max time step used when sub-stepping camera lag.
---@field CameraLagMaxTimeStep number
---Max distance the camera target may lag behind the current location. If set to zero, no max distance is enforced.
---@field CameraLagMaxDistance number
---If true AND the view target is simulating using physics then use the same max timestep cap as the physics system. Prevents camera jitter when delta time is clamped within Chaos Physics.
---@field bClampToMaxPhysicsDeltaTime boolean
local SpringArmComponent = {}

--- Methods
---Is the Collision Test displacement being applied?
---@return boolean
function SpringArmComponent.IsCollisionFixApplied() end

---Get the position where the camera should be without applying the Collision Test displacement
---@return Vector
function SpringArmComponent.GetUnfixedCameraPosition() end

---Get the target rotation we inherit, used as the base target for the boom rotation.
---This is derived from attachment to our parent and considering the UsePawnControlRotation and absolute rotation flags.
---@return Rotator
function SpringArmComponent.GetTargetRotation() end

return SpringArmComponent
