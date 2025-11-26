---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PhysicalMaterialMask
---Physical material masks are used to map multiple physical materials to a single rendering material
---
--- Properties
---@field AssetImportData AssetImportData
---Mask input texture, square aspect ratio recommended. Recognized mask colors include: white, black, red, green, yellow, cyan, turquoise, and magenta.
---@field MaskTexture Texture
---StaticMesh UV channel index to use when performing lookups with this mask.
---@field UVChannelIndex integer
---The addressing mode to use for the X axis.
---@field AddressX integer
---The addressing mode to use for the Y axis.
---@field AddressY integer
local PhysicalMaterialMask = {}

--- Methods
return PhysicalMaterialMask
