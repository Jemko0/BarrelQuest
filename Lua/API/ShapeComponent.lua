---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ShapeComponent : PrimitiveComponent
---ShapeComponent is a PrimitiveComponent that is represented by a simple geometrical shape (sphere, capsule, box, etc).
---
--- Properties
---Description of collision
---@field ShapeBodySetup BodySetup
---@field AreaClass Class
---Color used to draw the shape.
---@field ShapeColor Color
---Only show this component if the actor is selected
---@field bDrawOnlyIfSelected boolean
---If true it allows Collision when placing even if collision is not enabled
---@field bShouldCollideWhenPlacing boolean
---If set, shape will be exported for navigation as dynamic modifier instead of using regular collision data
---@field bDynamicObstacle boolean
---Uses FNavigationSystem::GetDefaultObstacleArea() by default instead of AreaClassOverride, bDynamicObstacle must be true to use this.
---@field bUseSystemDefaultObstacleAreaClass boolean
---Navigation area type override, null / none = no change to nav mesh.
---bDynamicObstacle must be true and bUseSystemDefaultAreaClass false to use this.
---@field AreaClassOverride Class
---Used to control the line thickness when rendering
---@field LineThickness number
local ShapeComponent = {}

--- Methods
---Set the LineThickness
---@param Thickness number
---@return nil
function ShapeComponent.SetLineThickness(Thickness) end

return ShapeComponent
