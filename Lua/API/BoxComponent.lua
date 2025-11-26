---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BoxComponent : ShapeComponent
---A box generally used for simple collision. Bounds are rendered as lines in the editor.
---
--- Properties
---
---The extents (radii dimensions) of the box *
---@field BoxExtent Vector
local BoxComponent = {}

--- Methods
---Change the box extent size. This is the unscaled size, before component scale is applied.
---@param InBoxExtent Vector
---@param bUpdateOverlaps boolean
---@return nil
function BoxComponent.SetBoxExtent(InBoxExtent, bUpdateOverlaps) end

---@return Vector
function BoxComponent.GetUnscaledBoxExtent() end

---@return Vector
function BoxComponent.GetScaledBoxExtent() end

return BoxComponent
