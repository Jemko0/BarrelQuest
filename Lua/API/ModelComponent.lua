---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class ModelComponent : PrimitiveComponent
---ModelComponents are PrimitiveComponents that represent elements of BSP geometry in a ULevel object.
---They are used exclusively by ULevel and are not intended as general-purpose components.
---@see ULevel
---
--- Properties
---
---Description of collision
---@field ModelBodySetup BodySetup
local ModelComponent = {}

--- Methods
return ModelComponent
