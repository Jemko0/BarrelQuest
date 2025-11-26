---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class EditedDocumentInfo
---Edited Document Info
---
--- Properties
---Edited object
---@field EditedObjectPath SoftObjectPath
---Saved view position
---@field SavedViewOffset DeprecateSlateVector2D
---Saved zoom amount
---@field SavedZoomAmount number
---Legacy hard reference is now serialized as a soft reference (see above).
---@field EditedObject Object
local EditedDocumentInfo = {}
return EditedDocumentInfo
