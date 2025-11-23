---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class Box
---A bounding box.
---@note The full C++ class is located here: Engine\Source\Runtime\Core\Public\Math\Box.h
---
--- Properties
---@field Min Vector
---@field Max Vector
---@field IsValid boolean
local Box = {}
return Box
