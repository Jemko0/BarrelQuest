local barrel = {}

---@return BarrelCharacter_C
---gets the local player, nil on dedicated server
barrel.getLocalPlayer = function()
  return __getLocalPlayer()
end

_G.barrel = barrel