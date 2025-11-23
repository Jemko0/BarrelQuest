---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class StaticParameterSet
---Contains all the information needed to identify a single permutation of static parameters.
---
--- Properties
---@field EditorOnly StaticParameterSetEditorOnlyData
---@field MaterialLayersParameters StaticMaterialLayersParameter[]
---@field StaticSwitchParameters StaticSwitchParameter[]
---@field StaticComponentMaskParameters StaticComponentMaskParameter[]
---@field TerrainLayerWeightParameters StaticTerrainLayerWeightParameter[]
---An array of static switch parameters in this set
---@field StaticSwitchParameters StaticSwitchParameter[]
---Material layers for this set
---@field MaterialLayers MaterialLayersFunctionsRuntimeData
---@field bHasMaterialLayers boolean
local StaticParameterSet = {}
return StaticParameterSet
