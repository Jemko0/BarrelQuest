---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MaterialOverrideNanite
---Storage for nanite material override.
---An override material can be selected, and the override material can be used according to the current settings.
---We handle removing the override material and its dependencies from the cook on platforms where we can determine
---that the override material can never be used.
---
--- Properties
---Stored flag to set whether we apply this override.
---This is useful when evaluating an override along a hierachy of settings.
---We default to true to always override.
---@field bEnableOverride boolean
---EditorOnly version of the OverrideMaterial reference.
---This is a hard reference, but is editoronly. We rely on -skiponlyeditoronly to avoid pulling this editoronly hard reference into the cook.
---@field OverrideMaterialEditor MaterialInterface
---Reference to our override material.
---This is only non-null in cooked packages, and is only non-null for cooked platforms that support nanite.
---Note that we skip default serialization and use special logic inside Serialize().
---@field OverrideMaterial MaterialInterface
---Legacy editor soft reference that has been replaced by OverrideMaterialEditor.
---@field OverrideMaterialRef any
local MaterialOverrideNanite = {}
return MaterialOverrideNanite
