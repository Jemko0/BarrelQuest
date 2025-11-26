local barrel = {}

barrel.InventoryItem = require("API.wrappers.InventoryItem")
barrel.Item = require("API.wrappers.ItemData")
barrel.BoneHealth = require("API.wrappers.BoneHealth")
barrel.StatDefinition = require("API.wrappers.StatDefinition")
barrel.TileDefinition = require("API.wrappers.TileDefinition")
barrel.CraftingRecipe = require("API.wrappers.CraftingRecipe")
barrel.CraftingResult = require("API.wrappers.CraftingResult")

---@return BarrelCharacter_C
---gets the local player, nil on dedicated server
barrel.getLocalPlayer = function()
  return __getLocalPlayer()
end

---@return BarrelLuaNetworkActor_C
---gets the local player, nil on dedicated server
barrel.getNetActor = function()
  return __getNetActor()
end

---@return Class
barrel.getClassByName = function(className)
  return __getCBN(className)
end

---@return AssetData
barrel.getAssetByObjectPath = function(objPath)
  return __getAsset(objPath)
end

_G.barrel = barrel