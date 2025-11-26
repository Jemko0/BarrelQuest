---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PhysicalAnimationProfile
---Physical Animation Profile
---
--- Properties
---
---Profile name used to identify set of physical animation parameters
---@field ProfileName string
---Physical animation parameters used to drive animation
---@field PhysicalAnimationData PhysicalAnimationData
local PhysicalAnimationProfile = {}

--- Constructor
---@return PhysicalAnimationProfile
---@param ProfileName string
---@param PhysicalAnimationData PhysicalAnimationData
function PhysicalAnimationProfile.new(ProfileName, PhysicalAnimationData)
    local self = {}
    self.ProfileName = ProfileName
    self.PhysicalAnimationData = PhysicalAnimationData
    return self
end

return PhysicalAnimationProfile
