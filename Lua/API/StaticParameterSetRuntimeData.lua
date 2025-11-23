---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class StaticParameterSetRuntimeData
---Static Parameter Set Runtime Data
---
--- Properties
---An array of static switch parameters in this set
---@field StaticSwitchParameters StaticSwitchParameter[]
---Material layers for this set
---@field MaterialLayers MaterialLayersFunctionsRuntimeData
---@field bHasMaterialLayers boolean
local StaticParameterSetRuntimeData = {}
return StaticParameterSetRuntimeData
