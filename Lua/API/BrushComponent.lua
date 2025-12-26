---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class BrushComponent : PrimitiveComponent
---A brush component defines a shape that can be modified within the editor. They are used both as part of BSP building, and for volumes.
---@see https://docs.unrealengine.com/latest/INT/Engine/Actors/Volumes
---@see https://docs.unrealengine.com/latest/INT/Engine/Actors/Brushes
---
--- Properties
---
---@field Brush Model
---Description of collision
---@field BrushBodySetup BodySetup
---Local space translation
---@field PrePivot Vector
local BrushComponent = {}

--- Methods
return BrushComponent
