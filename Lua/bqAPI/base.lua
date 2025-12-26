local barrel = {}

barrel.Action = require("API.wrappers.Action_W")
barrel.BoneHealth = require("API.wrappers.BoneHealth_W")
barrel.InventoryItem = require("API.wrappers.InventoryItem_W")
barrel.Item = require("API.wrappers.ItemData_W")
barrel.TimedActionData = require("API.wrappers.TimedActionData_W")
barrel.DropTableEntry = require("API.wrappers.DropTableEntry_W")
barrel.DropTableItem = require("API.wrappers.DropTableItem_W")
barrel.DamageTypeData = require("API.wrappers.DamageTypeData_W")
barrel.GameCommand = require("API.wrappers.GameCommand_W")
barrel.RightClickMenuOption = require("API.wrappers.RightClickMenuOption_W")
barrel.ProjectileData = require("API.wrappers.ProjectileData_W")

barrel.StatNotificationDefinition = require("API.wrappers.StatNotificationDefinition_W")
barrel.StatNotificationDefinitionArray = require("API.wrappers.StatNotificationDefinitionArray_W")
barrel.StatDefinition = require("API.wrappers.StatDefinition_W")
barrel.TileDefinition = require("API.wrappers.TileDefinition_W")

barrel.CraftingQueueItem = require("API.wrappers.CraftingQueueItem_W")
barrel.CraftingQueueQuickAmountLookupMapValue = require("API.wrappers.CraftingQueueQuickAmountLookupMapValue_W")
barrel.CraftingRecipe = require("API.wrappers.CraftingRecipe_W")
barrel.CraftingResult = require("API.wrappers.CraftingResult_W")
barrel.CraftingRecipeIngredient = require("API.wrappers.CraftingRecipeIngredient_W")

barrel.Button = require("API.wrappers.Button_W")

barrel.CharacterClothing = require("API.wrappers.CharacterClothing_W")
barrel.ClothingItemData = require("API.wrappers.ClothingItemData_W")

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