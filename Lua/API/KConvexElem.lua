---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class KConvexElem
---One convex hull, used for simplified collision.
---
--- Properties
---Array of indices that make up the convex hull.
---@field VertexData Vector[]
---@field IndexData integer[]
---Bounding box of this convex hull.
---@field ElemBox Box
---Transform of this element
---@field Transform Transform
---Offset used when generating contact points. This allows you to smooth out
---              the Minkowski sum by radius R. Useful for making objects slide smoothly
---              on top of irregularities
---@field RestOffset number
---True when the shape was created by the engine and was not imported.
---@field bIsGenerated boolean
---User-defined name for this shape
---@field Name string
---True if this shape should contribute to the overall mass of the body it
---              belongs to. This lets you create extra collision volumes which do not affect
---              the mass properties of an object.
---@field bContributeToMass boolean
---Course per-primitive collision filtering. This allows for individual primitives to
---              be toggled in and out of sim and query collision without changing filtering details.
---@field CollisionEnabled integer
local KConvexElem = {}
return KConvexElem
