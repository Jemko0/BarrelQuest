---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MaterialRemapIndex
---Material Remap Index
---
--- Properties
---@field ImportVersionKey integer
---@field MaterialRemap integer[]
local MaterialRemapIndex = {}

--- Constructor
---@return MaterialRemapIndex
---@param ImportVersionKey integer
---@param MaterialRemap integer[]
function MaterialRemapIndex.new(ImportVersionKey, MaterialRemap)
    local self = {}
    self.ImportVersionKey = ImportVersionKey
    self.MaterialRemap = MaterialRemap
    return self
end

return MaterialRemapIndex
