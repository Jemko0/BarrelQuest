---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class StaticMaterial
---Static Material
---
--- Properties
---
---@field MaterialInterface MaterialInterface
---This name should be use by the gameplay to avoid error if the skeletal mesh Materials array topology change
---@field MaterialSlotName string
---This name should be use when we re-import a skeletal mesh so we can order the Materials array like it should be
---@field ImportedMaterialSlotName string
---Data used for texture streaming relative to each UV channels.
---@field UVChannelData MeshUVChannelInfo
---@field OverlayMaterialInterface MaterialInterface
local StaticMaterial = {}

--- Constructor
---@return StaticMaterial
---@param MaterialInterface MaterialInterface
---@param MaterialSlotName string
---@param ImportedMaterialSlotName string
---@param UVChannelData MeshUVChannelInfo
---@param OverlayMaterialInterface MaterialInterface
function StaticMaterial.new(MaterialInterface, MaterialSlotName, ImportedMaterialSlotName, UVChannelData, OverlayMaterialInterface)
    local self = {}
    self.MaterialInterface = MaterialInterface
    self.MaterialSlotName = MaterialSlotName
    self.ImportedMaterialSlotName = ImportedMaterialSlotName
    self.UVChannelData = UVChannelData
    self.OverlayMaterialInterface = OverlayMaterialInterface
    return self
end

return StaticMaterial
