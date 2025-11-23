local Vector = require("bqAPI.vector")

local v = Vector(0, 0, 5000)
local ply = getLocalPlayer()

ply.LaunchCharacter(v, false, true)