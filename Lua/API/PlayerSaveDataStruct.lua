---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PlayerSaveDataStruct
---Player Save Data Struct
---
--- Properties
---@field Location_2_DD30FA8C425584A2716CA88A67A917A3 Vector
---@field Rotation_20_1BC7573A4AB7F679CC5478BE8C87A025 Rotator
---@field Hotbar_8_33ECA6D14036A976286D3ABC49A8D6E0 integer[]
---@field SelectedItem_11_A299F964423B3588252547B01AECF395 integer
---@field Inventory_15_FAE8401045052E25CABE458C0115DD5E InventoryItemStruct[]
---@field Banned_19_105ABA33484C3425B9A3BD89FEC9F00B boolean
local PlayerSaveDataStruct = {}
return PlayerSaveDataStruct
