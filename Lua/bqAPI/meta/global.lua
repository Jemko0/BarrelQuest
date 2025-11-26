---@meta
---@alias void nil
---

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

---@return AssetData
function __getAsset(objPath) end

---@return string
---gets the path to the lua module directory
function __getLuaModulePath() end

---adds a lua file to package.path, usually used internally and not by user code
function addPackage(path) end