---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class MaterialFunctionInterface
---A Material Function is a collection of material expressions that can be reused in different materials
---
--- Properties
---
---@field EditorOnlyData MaterialFunctionInterfaceEditorOnlyData
---Used by materials using this function to know when to recompile.
---@field StateId Guid
---The intended usage of this function, required for material layers.
---@field MaterialFunctionUsage EMaterialFunctionUsage
---@field CombinedInputTypes integer
---@field CombinedOutputTypes integer
---Information for thumbnail rendering
---@field ThumbnailInfo ThumbnailInfo
local MaterialFunctionInterface = {}

--- Methods
return MaterialFunctionInterface
