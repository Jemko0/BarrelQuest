---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SphereComponent : ShapeComponent
---A sphere generally used for simple collision. Bounds are rendered as lines in the editor.
---
--- Properties
---The radius of the sphere *
---@field SphereRadius number
local SphereComponent = {}

--- Methods
---Change the sphere radius. This is the unscaled radius, before component scale is applied.
---@param InSphereRadius number
---@param bUpdateOverlaps boolean
---@return nil
function SphereComponent.SetSphereRadius(InSphereRadius, bUpdateOverlaps) end

---@return number
function SphereComponent.GetUnscaledSphereRadius() end

---Get the scale used by this shape. This is a uniform scale that is the minimum of any non-uniform scaling.
---@return number
function SphereComponent.GetShapeScale() end

---@return number
function SphereComponent.GetScaledSphereRadius() end

return SphereComponent
