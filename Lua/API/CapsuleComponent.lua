---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CapsuleComponent : ShapeComponent
---A capsule generally used for simple collision. Bounds are rendered as lines in the editor.
---
--- Properties
---
---Half-height, from center of capsule to the end of top or bottom hemisphere.
---This cannot be less than CapsuleRadius.
---@field CapsuleHalfHeight number
---Radius of cap hemispheres and center cylinder.
---This cannot be more than CapsuleHalfHeight.
---@field CapsuleRadius number
---@field CapsuleHeight number
local CapsuleComponent = {}

--- Methods
---Change the capsule size. This is the unscaled size, before component scale is applied.
---@param InRadius number
---@param InHalfHeight number
---@param bUpdateOverlaps boolean
---@return nil
function CapsuleComponent.SetCapsuleSize(InRadius, InHalfHeight, bUpdateOverlaps) end

---Set the capsule radius. This is the unscaled radius, before component scale is applied.
---If this capsule collides, updates touching array for owner actor.
---@param Radius number
---@param bUpdateOverlaps boolean
---@return nil
function CapsuleComponent.SetCapsuleRadius(Radius, bUpdateOverlaps) end

---Set the capsule half-height. This is the unscaled half-height, before component scale is applied.
---If this capsule collides, updates touching array for owner actor.
---@param HalfHeight number
---@param bUpdateOverlaps boolean
---@return nil
function CapsuleComponent.SetCapsuleHalfHeight(HalfHeight, bUpdateOverlaps) end

---Returns the capsule radius and half-height, ignoring component scaling. Half-height excludes the hemisphere end cap.
---@return nil, number, number
function CapsuleComponent.GetUnscaledCapsuleSize_WithoutHemisphere() end

---Returns the capsule radius and half-height scaled by the component scale. Half-height includes the hemisphere end cap.
---@return nil, number, number
function CapsuleComponent.GetUnscaledCapsuleSize() end

---Returns the capsule radius, ignoring component scaling.
---@return number
function CapsuleComponent.GetUnscaledCapsuleRadius() end

---Returns the capsule half-height minus radius (to exclude the hemisphere), ignoring component scaling. This excludes the hemisphere end cap.
---From the center of the capsule this is the vertical distance along the straight cylindrical portion to the point just before the curve of top hemisphere begins.
---@return number
function CapsuleComponent.GetUnscaledCapsuleHalfHeight_WithoutHemisphere() end

---Returns the capsule half-height, ignoring component scaling. This includes the hemisphere end cap.
---@return number
function CapsuleComponent.GetUnscaledCapsuleHalfHeight() end

---Get the scale used by this shape. This is a uniform scale that is the minimum of any non-uniform scaling.
---@return number
function CapsuleComponent.GetShapeScale() end

---Returns the capsule radius and half-height scaled by the component scale. Half-height excludes the hemisphere end cap.
---@return nil, number, number
function CapsuleComponent.GetScaledCapsuleSize_WithoutHemisphere() end

---Returns the capsule radius and half-height scaled by the component scale. Half-height includes the hemisphere end cap.
---@return nil, number, number
function CapsuleComponent.GetScaledCapsuleSize() end

---Returns the capsule radius scaled by the component scale.
---@return number
function CapsuleComponent.GetScaledCapsuleRadius() end

---Returns the capsule half-height minus radius (to exclude the hemisphere), scaled by the component scale.
---From the center of the capsule this is the vertical distance along the straight cylindrical portion to the point just before the curve of top hemisphere begins.
---@return number
function CapsuleComponent.GetScaledCapsuleHalfHeight_WithoutHemisphere() end

---Returns the capsule half-height scaled by the component scale. This includes both the cylinder and hemisphere cap.
---@return number
function CapsuleComponent.GetScaledCapsuleHalfHeight() end

return CapsuleComponent
