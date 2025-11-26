---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BlendProfile
---A blend profile is a set of per-bone scales that can be used in transitions and blend lists
---to tweak the weights of specific bones. The scales are applied to the normal weight for that bone
---
--- Properties
---
---The skeleton that owns this profile
---@field OwningSkeleton Skeleton
---List of blend scale entries
---@field ProfileEntries BlendProfileBoneEntry[]
---Blend Profile Mode. Read EBlendProfileMode for more details
---@field Mode EBlendProfileMode
local BlendProfile = {}

--- Methods
return BlendProfile
