---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class Geometry
---Represents the position, size, and absolute position of a Widget in Slate.
---The absolute location of a geometry is usually screen space or
---window space depending on where the geometry originated.
---Geometries are usually paired with a SWidget pointer in order
---to provide information about a specific widget (see FArrangedWidget).
---A Geometry's parent is generally thought to be the Geometry of the
---the corresponding parent widget.
---
--- Properties
local Geometry = {}
return Geometry
