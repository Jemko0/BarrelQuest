---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class FontCharacter
---This struct is serialized using native serialization so any changes to it require a package version bump.
---
--- Properties
---
---@field StartU integer
---@field StartV integer
---@field USize integer
---@field VSize integer
---@field TextureIndex integer
---@field VerticalOffset integer
local FontCharacter = {}

--- Constructor
---@return FontCharacter
---@param StartU integer
---@param StartV integer
---@param USize integer
---@param VSize integer
---@param TextureIndex integer
---@param VerticalOffset integer
function FontCharacter.new(StartU, StartV, USize, VSize, TextureIndex, VerticalOffset)
    local self = {}
    self.StartU = StartU
    self.StartV = StartV
    self.USize = USize
    self.VSize = VSize
    self.TextureIndex = TextureIndex
    self.VerticalOffset = VerticalOffset
    return self
end

return FontCharacter
