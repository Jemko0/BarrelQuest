---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SpriteCategoryInfo
---Information about the sprite category, used for visualization in the editor
---
--- Properties
---Sprite category that the component belongs to
---@field Category string
---Localized name of the sprite category
---@field DisplayName string
---Localized description of the sprite category
---@field Description string
local SpriteCategoryInfo = {}

--- Constructor
---@return SpriteCategoryInfo
---@param Category string
---@param DisplayName string
---@param Description string
function SpriteCategoryInfo.new(Category, DisplayName, Description)
    local self = {}
    self.Category = Category
    self.DisplayName = DisplayName
    self.Description = Description
    return self
end

return SpriteCategoryInfo
