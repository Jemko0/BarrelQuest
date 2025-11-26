---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class DrawFrustumComponent : PrimitiveComponent
---Utility component for drawing a view frustum. Origin is at the component location, frustum points down position X axis.
---
--- Properties
---
---Enable or disable frustum visualization for this camera
---@field bFrustumEnabled boolean
---Color to draw the wireframe frustum.
---@field FrustumColor Color
---Angle of longest dimension of view shape.
---If the angle is 0 then an orthographic projection is used
---@field FrustumAngle number
---Ratio of horizontal size over vertical size.
---@field FrustumAspectRatio number
---Distance from origin to start drawing the frustum.
---@field FrustumStartDist number
---Distance from origin to stop drawing the frustum.
---@field FrustumEndDist number
---optional texture to show on the near plane
---@field Texture Texture
local DrawFrustumComponent = {}

--- Methods
return DrawFrustumComponent
