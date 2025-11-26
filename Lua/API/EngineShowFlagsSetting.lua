---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class EngineShowFlagsSetting
---Engine Show Flags Setting
---
--- Properties
---
---@field ShowFlagName string
---@field Enabled boolean
local EngineShowFlagsSetting = {}

--- Constructor
---@return EngineShowFlagsSetting
---@param ShowFlagName string
---@param Enabled boolean
function EngineShowFlagsSetting.new(ShowFlagName, Enabled)
    local self = {}
    self.ShowFlagName = ShowFlagName
    self.Enabled = Enabled
    return self
end

return EngineShowFlagsSetting
