local classPath = "/Game/BarrelContent/Items/Items/Tools/ItemTool.ItemTool_C"

---@param target BarrelCharacter_C
---@param delta number

local function customtick(target, delta)
    print(target)
    return 30.3
end

local a = {customtick()}

hook.Add(hook.Names.PlayerTick, "Test", customtick)