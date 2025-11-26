---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class KAggregateGeom
---Container for an aggregate of collision shapes
---
--- Properties
---@field SphereElems KSphereElem[]
---@field BoxElems KBoxElem[]
---@field SphylElems KSphylElem[]
---@field ConvexElems KConvexElem[]
---@field TaperedCapsuleElems KTaperedCapsuleElem[]
---@field LevelSetElems KLevelSetElem[]
---@field SkinnedLevelSetElems KSkinnedLevelSetElem[]
---@field MLLevelSetElems KMLLevelSetElem[]
---@field SkinnedTriangleMeshElems KSkinnedTriangleMeshElem[]
local KAggregateGeom = {}
return KAggregateGeom
