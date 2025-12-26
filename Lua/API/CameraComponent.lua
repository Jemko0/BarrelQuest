---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class CameraComponent : SceneComponent
---Represents a camera viewpoint and settings, such as projection type, field of view, and post-process overrides.
---The default behavior for an actor used as the camera view target is to look for an attached camera component and use its location, rotation, and settings.
---
--- Properties
---
---The horizontal field of view (in degrees) in perspective mode (ignored in Orthographic mode)
---If the aspect ratio axis constraint (from ULocalPlayer, ALevelSequenceActor, etc.) is set to maintain vertical FOV, the AspectRatio
---property will be used to convert this property's value to a vertical FOV.
---@field FieldOfView number
---The horizontal field of view (in degrees) used for primitives tagged as "IsFirstPerson".
---@field FirstPersonFieldOfView number
---The scale to apply to primitives tagged as "IsFirstPerson". This is used to scale down primitives towards the camera such that they are small enough not to intersect with the scene.
---@field FirstPersonScale number
---The desired width (in world units) of the orthographic view (ignored in Perspective mode)
---@field OrthoWidth number
---Automatically determine a min/max Near/Far clip plane position depending on OrthoWidth value
---@field bAutoCalculateOrthoPlanes boolean
---Manually adjusts the planes of this camera, maintaining the distance between them. Positive moves out to the farplane, negative towards the near plane
---@field AutoPlaneShift number
---The near plane distance of the orthographic view (in world units)
---@field OrthoNearClipPlane number
---The far plane distance of the orthographic view (in world units)
---@field OrthoFarClipPlane number
---Adjusts the near/far planes and the view origin of the current camera automatically to avoid clipping and light artefacting
---@field bUpdateOrthoPlanes boolean
---If UpdateOrthoPlanes is enabled, this setting will use the cameras current height to compensate the distance to the general view (as a pseudo distance to view target when one isn't present)
---@field bUseCameraHeightAsViewTarget boolean
---Aspect Ratio (Width/Height)
---@field AspectRatio number
---Override for the default aspect ratio axis constraint defined on the local player
---@field AspectRatioAxisConstraint integer
---If bConstrainAspectRatio is true, black bars will be added if the destination view has a different aspect ratio than this camera requested.
---@field bConstrainAspectRatio boolean
---Whether to override the default aspect ratio axis constraint defined on the local player
---@field bOverrideAspectRatioAxisConstraint boolean
---If true, account for the field of view angle when computing which level of detail to use for meshes.
---@field bUseFieldOfViewForLOD boolean
---Amount to increase the view frustum by, from 0.0 for no increase to 1.0 for 100% increase
---@field Overscan number
---Experimental: Amount to increase each side of the view frustum by, from 0.0 for no increase to 1.0 for 100% increase.
---By convention, X is the left overscan, Y is the right overscan, Z is the top overscan, and W is the bottom overscan. Stacks with uniform Overscan.
---Not currently exposed to the editor or blueprints, intended for internal use for now
---@field AsymmetricOverscan Vector4f
---Indicates that the resolution should be scaled by the overscan amount so that the original view frustum remains the same resolution.
---Note that when enabled, increasing overscan will result in increased rendering workload, potentially decreasing performance as resolution increases
---@field bScaleResolutionWithOverscan boolean
---Indicates that the overscanned pixels should be cropped at the end of the rendering pipeline, allowing the overscanned pixels to be used in post process effects
---that need extra pixels beyond the view frustum (e.g. lens distortion) without having to render those pixels to the screen. When bScaleResolutionWithOverscan is enabled,
---the cropped image will have the same resolution as the original non-overscanned image, but when disabled, the cropped image will be a lower resolution.
---@field bCropOverscan boolean
---The Frustum visibility flag for draw frustum component initialization
---@field bDrawFrustumAllowed boolean
---If the camera mesh is visible in game. Only relevant when running editor builds.
---@field bCameraMeshHiddenInGame boolean
---True if the camera's orientation and position should be locked to the HMD
---@field bLockToHmd boolean
---If this camera component is placed on a pawn, should it use the view/control rotation of the pawn where possible?
---\@see APawn::GetViewRotation()
---@field bUsePawnControlRotation boolean
---True if the first person field of view should be used for primitives tagged as "IsFirstPerson".
---@field bEnableFirstPersonFieldOfView boolean
---True if the first person scale should be used for primitives tagged as "IsFirstPerson".
---@field bEnableFirstPersonScale boolean
---The type of camera
---@field ProjectionMode integer
---@field CameraMesh StaticMesh
---Indicates if PostProcessSettings should be used when using this Camera to view through.
---@field PostProcessBlendWeight number
---Post process settings to use for this camera. Don't forget to check the properties you want to override
---@field PostProcessSettings PostProcessSettings
---DEPRECATED: use bUsePawnControlRotation instead
---@field bUseControllerViewRotation boolean
local CameraComponent = {}

--- Methods
---Set Use Field Of View for LOD
---@param bInUseFieldOfViewForLOD boolean
---@return nil
function CameraComponent.SetUseFieldOfViewForLOD(bInUseFieldOfViewForLOD) end

---Set Use Camera Height as View Target
---@param bInUseCameraHeightAsViewTarget boolean
---@return nil
function CameraComponent.SetUseCameraHeightAsViewTarget(bInUseCameraHeightAsViewTarget) end

---Set Update Ortho Planes
---@param bInUpdateOrthoPlanes boolean
---@return nil
function CameraComponent.SetUpdateOrthoPlanes(bInUpdateOrthoPlanes) end

---Sets whether to scale the resolution by the amount of overscan so that the original view frustum remains the same resolution.
---Note that when enabled, increasing overscan will result in increased rendering workload, potentially decreasing performance as resolution increases
---@param bInScaleResolutionWithOverscan boolean
---@return nil
function CameraComponent.SetScaleResolutionWithOverscan(bInScaleResolutionWithOverscan) end

---Set Projection Mode
---@param InProjectionMode integer
---@return nil
function CameraComponent.SetProjectionMode(InProjectionMode) end

---Set Post Process Blend Weight
---@param InPostProcessBlendWeight number
---@return nil
function CameraComponent.SetPostProcessBlendWeight(InPostProcessBlendWeight) end

---Set Overscan
---@param InOverscan number
---@return nil
function CameraComponent.SetOverscan(InOverscan) end

---Set Ortho Width
---@param InOrthoWidth number
---@return nil
function CameraComponent.SetOrthoWidth(InOrthoWidth) end

---Set Ortho Near Clip Plane
---@param InOrthoNearClipPlane number
---@return nil
function CameraComponent.SetOrthoNearClipPlane(InOrthoNearClipPlane) end

---Set Ortho Far Clip Plane
---@param InOrthoFarClipPlane number
---@return nil
function CameraComponent.SetOrthoFarClipPlane(InOrthoFarClipPlane) end

---Set First Person Scale
---@param InFirstPersonScale number
---@return nil
function CameraComponent.SetFirstPersonScale(InFirstPersonScale) end

---Set First Person Field Of View
---@param InFirstPersonFieldOfView number
---@return nil
function CameraComponent.SetFirstPersonFieldOfView(InFirstPersonFieldOfView) end

---Set Field Of View
---@param InFieldOfView number
---@return nil
function CameraComponent.SetFieldOfView(InFieldOfView) end

---Set Enable First Person Scale
---@param bInEnableFirstPersonScale boolean
---@return nil
function CameraComponent.SetEnableFirstPersonScale(bInEnableFirstPersonScale) end

---Set Enable First Person Field Of View
---@param bInEnableFirstPersonFieldOfView boolean
---@return nil
function CameraComponent.SetEnableFirstPersonFieldOfView(bInEnableFirstPersonFieldOfView) end

---Sets whether to crop the overscanned pixels at the end of the rendering pipeline, allowing the overscanned pixels to be used in post process effects
---that need extra pixels beyond the view frustum (e.g. lens distortion) without having to render those pixels to the screen. When bScaleResolutionWithOverscan is enabled,
---the cropped image will have the same resolution as the original non-overscanned image, but when disabled, the cropped image will be a lower resolution.
---@param bInCropOverscan boolean
---@return nil
function CameraComponent.SetCropOverscan(bInCropOverscan) end

---Set Constraint Aspect Ratio
---@param bInConstrainAspectRatio boolean
---@return nil
function CameraComponent.SetConstraintAspectRatio(bInConstrainAspectRatio) end

---Set Auto Plane Shift
---@param InAutoPlaneShift number
---@return nil
function CameraComponent.SetAutoPlaneShift(InAutoPlaneShift) end

---Set Auto Calculate Ortho Planes
---@param bAutoCalculate boolean
---@return nil
function CameraComponent.SetAutoCalculateOrthoPlanes(bAutoCalculate) end

---Set Aspect Ratio Axis Constraint
---@param InAspectRatioAxisConstraint integer
---@return nil
function CameraComponent.SetAspectRatioAxisConstraint(InAspectRatioAxisConstraint) end

---Set Aspect Ratio
---@param InAspectRatio number
---@return nil
function CameraComponent.SetAspectRatio(InAspectRatio) end

---Removes a blendable.
---@param InBlendableObject any
---@return nil
function CameraComponent.RemoveBlendable(InBlendableObject) end

---Internal function for updating the camera mesh visibility in PIE
---@return nil
function CameraComponent.OnCameraMeshHiddenChanged() end

---Returns camera's Point of View.
---Called by Camera class. Subclass and postprocess to add any effects.
---@param DeltaTime number
---@return nil, MinimalViewInfo
function CameraComponent.GetCameraView(DeltaTime) end

---Adds an Blendable (implements IBlendableInterface) to the array of Blendables (if it doesn't exist) and update the weight
---@param InBlendableObject any
---@param InWeight number
---@return nil
function CameraComponent.AddOrUpdateBlendable(InBlendableObject, InWeight) end

return CameraComponent
