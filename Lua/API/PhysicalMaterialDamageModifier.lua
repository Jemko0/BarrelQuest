---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PhysicalMaterialDamageModifier
---Damage threshold modifiers, used by the Chaos destruction system
---
--- Properties
---Multiplier for the geometry collection damage thresholds/ internal strain
---this allows for setting up unit damage threshold and use the material to scale them to the desired range of values
---Note that the geometry collection asset needs to opt-in for the material modifer to be able to use it
---@field DamageThresholdMultiplier number
local PhysicalMaterialDamageModifier = {}
return PhysicalMaterialDamageModifier
