---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class StaticMaterial
---Static Material
---
--- Properties
---@field MaterialInterface MaterialInterface
---This name should be use by the gameplay to avoid error if the skeletal mesh Materials array topology change
---@field MaterialSlotName string
---This name should be use when we re-import a skeletal mesh so we can order the Materials array like it should be
---@field ImportedMaterialSlotName string
---Data used for texture streaming relative to each UV channels.
---@field UVChannelData MeshUVChannelInfo
---@field OverlayMaterialInterface MaterialInterface
local StaticMaterial = {}
return StaticMaterial
