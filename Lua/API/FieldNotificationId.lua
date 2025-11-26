---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class FieldNotificationId
---namespace
---
--- Properties
---
---@field FieldName string
local FieldNotificationId = {}

--- Constructor
---@return FieldNotificationId
---@param FieldName string
function FieldNotificationId.new(FieldName)
    local self = {}
    self.FieldName = FieldName
    return self
end

return FieldNotificationId
