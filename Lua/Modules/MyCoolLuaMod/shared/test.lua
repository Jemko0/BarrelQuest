-- local ply = barrel.getLocalPlayer()

-- local objPath = "/Game/BarrelContent/Meshes/Tiles/Props/Radiator/1299_Radiator.1299_Radiator"
-- local mesh = barrel.loadAssetByObjectPath(objPath)

-- local iconPath = "/Game/BarrelContent/UI/UISprites/items/small_pebble.small_pebble"
-- local icon = barrel.loadAssetByObjectPath(iconPath)

-- local tagp = "/Game/BarrelContent/Tags/MedicalTag.MedicalTag"

-- ---@type TagDataAsset_C
-- local tag = barrel.loadAssetByObjectPath(tagp)

-- local net = barrel.getNetActor()

-- local d = {
--     "lua=true",
--     "color=#000000FF"
-- }

-- local defaultData = {
--     ["right_click_menu_options"] = "Drop Item,btn.menu.opt,drop_item"
-- }

-- local tags = {
--     tag
-- }

-- local toolClass = barrel.getClassByName("/Game/BarrelContent/Items/Items/Tools/ItemTool.ItemTool_C")

-- local args = {
--     Name = "Lua test Item",
--     Tooltip = "Item tooltip",
--     Icon = icon,
--     IconMaterial = nil,
--     isBillboard = false,
--     Mesh = mesh,
--     MaxStack = 99,
--     DefaultData = defaultData,
--     Class = toolClass,
--     SlotUIColor = "bg.default",
--     Weight = 0.1,
--     HeldSocketName = "Hand_L",
--     TilePlacingID = "None",
--     Tags = tags
-- }

-- local itemdata = barrel.Item.new(args)
-- net.RegisterItem("luaItem", itemdata:GetRaw())

-- local i = barrel.InventoryItem.new("luaItem", 12, {}, nil)

-- ply.ContainerComponentNew.AddItem(i:GetRaw())