---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class StaticParameterSet
---Contains all the information needed to identify a single permutation of static parameters.
---
--- Properties
---
---@field EditorOnly StaticParameterSetEditorOnlyData
---@field MaterialLayersParameters StaticMaterialLayersParameter[]
---@field StaticComponentMaskParameters StaticComponentMaskParameter[]
---@field TerrainLayerWeightParameters StaticTerrainLayerWeightParameter[]
---An array of static switch parameters in this set
---@field StaticSwitchParameters StaticSwitchParameter[]
---Material layers for this set
---@field MaterialLayers MaterialLayersFunctionsRuntimeData
---@field bHasMaterialLayers boolean
local StaticParameterSet = {}

--- Constructor
---@return StaticParameterSet
---@param EditorOnly StaticParameterSetEditorOnlyData
---@param MaterialLayersParameters StaticMaterialLayersParameter[]
---@param StaticComponentMaskParameters StaticComponentMaskParameter[]
---@param TerrainLayerWeightParameters StaticTerrainLayerWeightParameter[]
---@param StaticSwitchParameters StaticSwitchParameter[]
---@param MaterialLayers MaterialLayersFunctionsRuntimeData
---@param bHasMaterialLayers boolean
function StaticParameterSet.new(EditorOnly, MaterialLayersParameters, StaticSwitchParameters, StaticComponentMaskParameters, TerrainLayerWeightParameters, StaticSwitchParameters, MaterialLayers, bHasMaterialLayers)
    local self = {}
    self.EditorOnly = EditorOnly
    self.MaterialLayersParameters = MaterialLayersParameters
    self.StaticSwitchParameters = StaticSwitchParameters
    self.StaticComponentMaskParameters = StaticComponentMaskParameters
    self.TerrainLayerWeightParameters = TerrainLayerWeightParameters
    self.StaticSwitchParameters = StaticSwitchParameters
    self.MaterialLayers = MaterialLayers
    self.bHasMaterialLayers = bHasMaterialLayers
    return self
end

return StaticParameterSet
