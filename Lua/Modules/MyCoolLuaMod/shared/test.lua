local ply = barrel.getLocalPlayer()

local classname = '/Game/BarrelContent/Lua/BPBarrelLuaState.BPBarrelLuaState_C'
local c = barrel.getClassByName(classname)
print("-------CLASS-------")
print(c)
print("-------------------")

local objPath = "/Game/BarrelContent/Meshes/Foliage/foliage_billboard_twoSide.foliage_billboard_twoSide"
local mesh = barrel.getAssetByObjectPath(objPath)
print("-------MESH-------")
printTable(mesh)
print("-------------------")

local net = barrel.getNetActor()

local itemdata = barrel.Item.new("Lua Test Item", "TOOLTIP", nil, nil, true, nil, 99, {}, {}, nil, "bg.default", 0.1, "Hand_L", "None", {})
net.RegisterItem("luaItem", itemdata:GetRaw())

local i = barrel.InventoryItem.new("luaItem", 12, {}, nil)

ply.ContainerComponentNew.AddItem(i:GetRaw())