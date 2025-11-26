local barrel = {}

InventoryItemStruct = require("API.InventoryItemStruct")
BoneHealthStruct = require("API.BoneHealthStruct")
StatDefinitionStruct = require("API.StatDefinitionStruct")
TileDefinitionStruct = require("API.TileDefinitionStruct")
CraftingRecipeStruct = require("API.CraftingRecipeStruct")
CraftingResultStruct = require("API.CraftingResultStruct")

---@return BarrelCharacter_C
---gets the local player, nil on dedicated server
barrel.getLocalPlayer = function()
  return __getLocalPlayer()
end

_G.barrel = barrel