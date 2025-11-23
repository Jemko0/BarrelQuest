---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class PhysicalAnimationProfile
---Physical Animation Profile
---
--- Properties
---Profile name used to identify set of physical animation parameters
---@field ProfileName string
---Physical animation parameters used to drive animation
---@field PhysicalAnimationData PhysicalAnimationData
local PhysicalAnimationProfile = {}
return PhysicalAnimationProfile
