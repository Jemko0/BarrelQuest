---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class SkeletalBodySetup : BodySetup
---Skeletal Body Setup
---
--- Properties
---
---dummy place for customization inside phat. Profiles are ordered dynamically and we need a static place for detail customization
---@field CurrentPhysicalAnimationProfile PhysicalAnimationProfile
---If true we ignore scale changes from animation. This is useful for subtle scale animations like breathing where the physics collision should remain unchanged
---@field bSkipScaleFromAnimation boolean
local SkeletalBodySetup = {}

--- Methods
return SkeletalBodySetup
