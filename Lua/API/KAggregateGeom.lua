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

--- Constructor
---@return KAggregateGeom
---@param SphereElems KSphereElem[]
---@param BoxElems KBoxElem[]
---@param SphylElems KSphylElem[]
---@param ConvexElems KConvexElem[]
---@param TaperedCapsuleElems KTaperedCapsuleElem[]
---@param LevelSetElems KLevelSetElem[]
---@param SkinnedLevelSetElems KSkinnedLevelSetElem[]
---@param MLLevelSetElems KMLLevelSetElem[]
---@param SkinnedTriangleMeshElems KSkinnedTriangleMeshElem[]
function KAggregateGeom.new(SphereElems, BoxElems, SphylElems, ConvexElems, TaperedCapsuleElems, LevelSetElems, SkinnedLevelSetElems, MLLevelSetElems, SkinnedTriangleMeshElems)
    local self = {}
    self.SphereElems = SphereElems
    self.BoxElems = BoxElems
    self.SphylElems = SphylElems
    self.ConvexElems = ConvexElems
    self.TaperedCapsuleElems = TaperedCapsuleElems
    self.LevelSetElems = LevelSetElems
    self.SkinnedLevelSetElems = SkinnedLevelSetElems
    self.MLLevelSetElems = MLLevelSetElems
    self.SkinnedTriangleMeshElems = SkinnedTriangleMeshElems
    return self
end

return KAggregateGeom
