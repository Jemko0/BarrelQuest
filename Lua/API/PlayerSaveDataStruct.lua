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

--- Constructor
---@return PlayerSaveDataStruct
---@param Location_2_DD30FA8C425584A2716CA88A67A917A3 Vector
---@param Rotation_20_1BC7573A4AB7F679CC5478BE8C87A025 Rotator
---@param Hotbar_8_33ECA6D14036A976286D3ABC49A8D6E0 integer[]
---@param SelectedItem_11_A299F964423B3588252547B01AECF395 integer
---@param Inventory_15_FAE8401045052E25CABE458C0115DD5E InventoryItemStruct[]
---@param Banned_19_105ABA33484C3425B9A3BD89FEC9F00B boolean
function PlayerSaveDataStruct.new(Location_2_DD30FA8C425584A2716CA88A67A917A3, Rotation_20_1BC7573A4AB7F679CC5478BE8C87A025, Hotbar_8_33ECA6D14036A976286D3ABC49A8D6E0, SelectedItem_11_A299F964423B3588252547B01AECF395, Inventory_15_FAE8401045052E25CABE458C0115DD5E, Banned_19_105ABA33484C3425B9A3BD89FEC9F00B)
    local self = {}
    self.Location_2_DD30FA8C425584A2716CA88A67A917A3 = Location_2_DD30FA8C425584A2716CA88A67A917A3
    self.Rotation_20_1BC7573A4AB7F679CC5478BE8C87A025 = Rotation_20_1BC7573A4AB7F679CC5478BE8C87A025
    self.Hotbar_8_33ECA6D14036A976286D3ABC49A8D6E0 = Hotbar_8_33ECA6D14036A976286D3ABC49A8D6E0
    self.SelectedItem_11_A299F964423B3588252547B01AECF395 = SelectedItem_11_A299F964423B3588252547B01AECF395
    self.Inventory_15_FAE8401045052E25CABE458C0115DD5E = Inventory_15_FAE8401045052E25CABE458C0115DD5E
    self.Banned_19_105ABA33484C3425B9A3BD89FEC9F00B = Banned_19_105ABA33484C3425B9A3BD89FEC9F00B
    return self
end

return PlayerSaveDataStruct
