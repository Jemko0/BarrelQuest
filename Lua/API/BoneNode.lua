---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class BoneNode
---Each Bone node in BoneTree
---
--- Properties
---Name of bone, this is the search criteria to match with mesh bone. This will be NAME_None if deleted.
---@field Name string
---Parent Index. -1 if not used. The root has 0 as its parent. Do not delete the element but set this to -1. If it is revived by other reason, fix up this link.
---@field ParentIndex integer
---Retargeting Mode for Translation Component.
---@field TranslationRetargetingMode integer
local BoneNode = {}
return BoneNode
