---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RightClickMenuAnchor_C : UserWidget
---Right Click Menu Anchor
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field MenuAnchor_19 MenuAnchor
---@field RCM RightClickMenu_C
---@field Slot_ID integer -- Original name: "Slot ID"
---@field Options RightClickMenuOption[]
---@field Container ContainerComponentNew_C
---@field Actor Actor
local RightClickMenuAnchor_C = {}

--- Methods
---Get Menu
---@return Widget
function RightClickMenuAnchor_C.GetMenu() end

---Init
---@return nil
function RightClickMenuAnchor_C.Init() end

---Should Close
---@param Option string
---@return nil
function RightClickMenuAnchor_C.ShouldClose(Option) end

return RightClickMenuAnchor_C
