---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BoxSphereBounds
---A bounding box and bounding sphere with the same origin.
---@note The full C++ class is located here : Engine\Source\Runtime\Core\Public\Math\BoxSphereBounds.h
---
--- Properties
---Holds the origin of the bounding box and sphere.
---@field Origin Vector
---Holds the extent of the bounding box, which is half the size of the box in 3D space
---@field BoxExtent Vector
---Holds the radius of the bounding sphere.
---@field SphereRadius number
local BoxSphereBounds = {}
return BoxSphereBounds
