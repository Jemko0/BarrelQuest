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

--- Constructor
---@return EditedDocumentInfo
---@param EditedObjectPath SoftObjectPath
---@param SavedViewOffset DeprecateSlateVector2D
---@param SavedZoomAmount number
---@param EditedObject Object
function EditedDocumentInfo.new(EditedObjectPath, SavedViewOffset, SavedZoomAmount, EditedObject)
    local self = {}
    self.EditedObjectPath = EditedObjectPath
    self.SavedViewOffset = SavedViewOffset
    self.SavedZoomAmount = SavedZoomAmount
    self.EditedObject = EditedObject
    return self
end

return EditedDocumentInfo
