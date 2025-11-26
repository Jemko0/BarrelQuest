local ply = barrel.getLocalPlayer()

local item = InventoryItemStruct.new("base", 5, {}, nil)
ply.ContainerComponentNew.AddItem(item)