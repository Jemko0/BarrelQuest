---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class BlueprintExtension
---Per-instance extension object that can be added to UBlueprint::Extensions in order to augment built-in blueprint functionality
---Ideally this would be an editor-only class, but such classes are not permitted within Engine modules (even inside WITH_EDITORONLY_DATA blocks)
---
--- Properties
---
local BlueprintExtension = {}

--- Methods
return BlueprintExtension
