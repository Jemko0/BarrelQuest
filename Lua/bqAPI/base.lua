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


---Usually the class name is just the Asset Path with _C as a suffix, 
---only append _C on Blueprint Classes
---@return Class
barrel.getClassByName = function(className)
  return __getCBN(className)
end

-- ---@generic T
-- ---@param type T
-- ---@param objPath string  
-- ---@return T
-- barrel.loadAssetByObjectPathTyped = function(type, objPath)
--   return __getAsset(objPath)
-- end

---@param objPath string
---@return any
barrel.loadAssetByObjectPath = function(objPath)
  return __getAsset(objPath)
end

---@return string
barrel.registerLuaClass = function(baseClassPath, classTable)
  return __registerLuaClass(baseClassPath, classTable)
end

---@return Object
barrel.spawnLuaActor = function(luaClass, location, rotation)
  return __spawnLuaActor(luaClass, location, rotation)
end

---@return BarrelGamemode_C
barrel.getGamemode = function()
  return __getGM()
end

barrel.spawnActor = function(class, location, owner)
  return __spawnActor(class, location, owner)
end

_G.barrel = barrel