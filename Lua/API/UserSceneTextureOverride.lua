---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class UserSceneTextureOverride
---User Scene Texture Override
---
--- Properties
---Key value of NONE represents override of UserSceneTexture output
---@field Key string
---@field Value string
local UserSceneTextureOverride = {}

--- Constructor
---@return UserSceneTextureOverride
---@param Key string
---@param Value string
function UserSceneTextureOverride.new(Key, Value)
    local self = {}
    self.Key = Key
    self.Value = Value
    return self
end

return UserSceneTextureOverride
