---@meta
---@alias void nil
---

--- testing
---@module 'bUtil'
---@return RightClickMenuOption
function test_get_rco() end

---prints a tables content, can also just print normally but consistent behavior not guaranteed
---@param table any
function printTable(table)
end

---@return BarrelCharacter_C
---gets the local player, nil on dedicated server
function getLocalPlayer() end

---@return string
---gets the path to the lua module directory
function getLuaModulePath() end

---adds a lua file to package.path, usually used internally and not by user code
function addPackage(path) end