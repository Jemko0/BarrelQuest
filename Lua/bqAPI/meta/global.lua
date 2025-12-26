---@meta
---@alias void nil

---references an asset object
---@class Object

--- testing
---@module 'bUtil'
---@return RightClickMenuOption
function test_get_rco() end

---@return BarrelCharacter_C
function __getLocalPlayer() end

---@return BarrelLuaNetworkActor_C
function __getNetActor() end

---@return Class
function __getCBN(className) end

---@return BarrelGamemode_C
function __getGM() end

---@param class Class
---@param location Vector
---@param owner Actor
---@return Actor
function __spawnActor(class, location, owner) end

---@generic T
---@return T
function __getAsset(objPath) end

---@return string
function __registerLuaClass(baseClass, table) end

---@return Object
function __spawnLuaActor(luaClass, location, rotation) end

---@return string
---gets the path to the lua module directory
function __getLuaModulePath() end

---adds a lua file to package.path, usually used internally and not by user code
function addPackage(path) end

function __hookCall(eventName, ...) end
function __hookRemove(eventName, identifier) end
function __hookAdd(eventName, identifier, func) end

-- Engine Internal
---@class UInterface