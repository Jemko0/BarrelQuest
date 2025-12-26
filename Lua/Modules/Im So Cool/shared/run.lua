local meshPath = "/Game/BarrelContent/Meshes/Tiles/Props/Radiator/1299_Radiator.1299_Radiator"
local mesh = barrel.loadAssetByObjectPath(meshPath)

local iconPath = "/Game/BarrelContent/UI/UISprites/items/small_pebble.small_pebble"
local icon = barrel.loadAssetByObjectPath(iconPath)

local tagPath = "/Game/BarrelContent/Tags/MedicalTag.MedicalTag"
local tag = barrel.loadAssetByObjectPath(tagPath)

local toolClass = barrel.getClassByName("/Game/BarrelContent/Items/Items/Tools/ItemTool.ItemTool_C")

local net = barrel.getNetActor()

local args = {
    Name = "Lua test Item",
    Tooltip = "Item tooltip",
    Icon = icon,
    IconMaterial = nil,
    isBillboard = false,
    Mesh = mesh,
    MaxStack = 99,
    DefaultItemData = {
        "lua=true",
        "color=#000000FF"
    },
    DefaultData = {
        ["right_click_menu_options"] = "Drop Item,btn.menu.opt,drop_item"
    },
    Class = toolClass,
    SlotUIColor = "bg.default",
    Weight = 0.1,
    HeldSocketName = "Hand_L",
    TilePlacingID = "None",
    Tags = { tag }
}

local itemdata = barrel.Item.new(args)
net.RegisterItem("luaItem", itemdata:GetRaw())