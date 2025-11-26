---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BoneMirrorInfo
---Bone Mirror Info
---
--- Properties
---The bone to mirror.
---@field SourceIndex integer
---Axis the bone is mirrored across.
---@field BoneFlipAxis integer
local BoneMirrorInfo = {}
return BoneMirrorInfo
