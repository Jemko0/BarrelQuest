---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class BarrelNetCulledActor : Actor
---Barrel Net Culled Actor
---
--- Properties
---
---@field bUseBarrelCustomNetCulling boolean
local BarrelNetCulledActor = {}

--- Methods
---Get Barrel Custom Net Relevancy
---@param RealViewer Actor
---@param ViewTarget Actor
---@return boolean
function BarrelNetCulledActor.GetBarrelCustomNetRelevancy(RealViewer, ViewTarget) end

return BarrelNetCulledActor
